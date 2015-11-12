REPORT=report
LATEX=pdflatex
BIBTEX=bibtex

CLS = $(wildcard *.cls)
TEX = $(wildcard *.tex)
SRCS = $(TEX) refs.bib

FIG_TMP = tmp.eps
FIGS = $(patsubst %, figs/pdf/%.pdf, examplefig1)

all: pdf

figs: $(FIGS)

pdf: $(SRCS) $(CLS) $(FIGS)
	$(LATEX) $(REPORT)
	$(BIBTEX) $(REPORT)
	$(LATEX) $(REPORT)
	$(LATEX) $(REPORT)

figs/pdf/%.pdf: figs/svg/%.svg
	inkscape --export-area-drawing --export-eps="$(FIG_TMP)" --file="$<"
	epstopdf "$(FIG_TMP)" --outfile="$@"
	rm "$(FIG_TMP)"

bibsort: refs.bib
	bibtool -s -o ./refs.bib -i ./refs.bib

clean:
	$(RM) figs/pdf/*.pdf *.eps
	$(RM) *.dvi *.aux *.log *.blg *.bbl *.out *.lof *.lot *.toc
	$(RM) *~ .*~
