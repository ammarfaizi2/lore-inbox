Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTJFOJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 10:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbTJFOJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 10:09:28 -0400
Received: from mail.nvc.net ([64.68.160.43]:25094 "EHLO garbanzo.nvc.net")
	by vger.kernel.org with ESMTP id S262115AbTJFOJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 10:09:19 -0400
Message-ID: <3F81778E.6000807@dakotainet.net>
Date: Mon, 06 Oct 2003 09:09:18 -0500
From: merwan kashouty <kashouty@dakotainet.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test6 usblp and scanner lock system
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

modprobing usblp and scanner on my system lock the console... i can 
switch consoles and continue to work but the output of 
/lib/modules/2.6.0-test6/modules.symbols looks like this....

error A -nostdlib  -c weak.ml
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib  -c lazy.mli
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib  -c lazy.ml
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib  -c filename.mli
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib  -c filename.ml
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib  -c int32.mli
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib  -c int32.ml
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib  -c int64.mli
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib  -c int64.ml
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib  -c nativeint.mli
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib  -c nativeint.ml
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib  -c complex.mli
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib  -c complex.ml
make EXTRAFLAGS=-nolabels RUNTIME=../boot/ocamlrun \
                COMPILER=../boot/ocamlc arrayLabels.cmo listLabels.cmo 
stringLabels.cmo moreLabels.cmo
make[2]: Entering directory 
`/var/tmp/portage/ocaml-3.06-r2/work/ocaml-3.06/stdlib'
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib -nolabels -c 
arrayLabels.mli
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib -nolabels -c 
arrayLabels.ml
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib -nolabels -c 
listLabels.mli
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib -nolabels -c 
listLabels.ml
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib -nolabels -c 
stringLabels.mli
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib -nolabels -c 
stringLabels.ml
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib -nolabels -c 
moreLabels.mli
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib -nolabels -c 
moreLabels.ml
make[2]: Leaving directory 
`/var/tmp/portage/ocaml-3.06-r2/work/ocaml-3.06/stdlib'
touch labelled.cmo
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib  -c stdLabels.mli
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib  -c stdLabels.ml
../boot/ocamlrun ../boot/ocamlc -a -o stdlib.cma pervasives.cmo 
array.cmo list.cmo char.cmo string.cmo sys.cmo hashtbl.cmo sort.cmo marshal.
cmo obj.cmo lexing.cmo parsing.cmo set.cmo map.cmo stack.cmo queue.cmo 
stream.cmo buffer.cmo printf.cmo format.cmo scanf.cmo arg.cmo printex
c.cmo gc.cmo digest.cmo random.cmo camlinternalOO.cmo oo.cmo genlex.cmo 
callback.cmo weak.cmo lazy.cmo filename.cmo int32.cmo int64.cmo nati
veint.cmo complex.cmo arrayLabels.cmo listLabels.cmo stringLabels.cmo 
moreLabels.cmo stdLabels.cmo
../boot/ocamlrun ../boot/ocamlc -g -warn-error A -nostdlib  -c std_exit.ml
if true; then \
          echo '#!/usr/bin/ocamlrun' > camlheader && \
          echo '#!' | tr -d '\012' > camlheader_ur; \
        else \
  gcc -fno-defer-pop -Wall -Wno-unused -D_FILE_OFFSET_BITS=64 
-D_REENTRANT -Wl,-E \
                    -DRUNTIME_NAME='"/usr/bin/ocamlrun"' \
                    header.c -o tmpheader && \
          strip tmpheader && \
  mv tmpheader camlheader && \
          cp camlheader camlheader_ur; \
        fi
make[1]: Leaving directory 
`/var/tmp/portage/ocaml-3.06-r2/work/ocaml-3.06/stdlib'
cd stdlib; cp stdlib.cma std_exit.cmo *.cmi camlheader ../boot
if test -f boot/libcamlrun.a; then :; else \
          ln -s ../byterun/libcamlrun.a boot/libcamlrun.a; fi
if test -d stdlib/caml; then :; else \
          ln -s ../byterun stdlib/caml; fi
cd byterun; make all
make[1]: Entering directory 
`/var/tmp/portage/ocaml-3.06-r2/work/ocaml-3.06/byterun'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory 
`/var/tmp/portage/ocaml-3.06-r2/work/ocaml-3.06/byterun'
if test -f stdlib/libcamlrun.a; then :; else \
          ln -s ../byterun/libcamlrun.a stdlib/libcamlrun.a; fi
boot/ocamlrun boot/ocamlc -nostdlib -I boot -warn-error A -I utils -I 
parsing -I typing -I bytecomp -I asmcomp -I driver -I toplevel -c util
s/misc.mli
boot/ocamlrun boot/ocamlc -nostdlib -I boot -warn-error A -I utils -I 
parsing -I typing -I bytecomp -I asmcomp -I driver -I toplevel -c util
s/misc.ml
boot/ocamlrun boot/ocamlc -nostdlib -I boot -warn-error A -I utils -I 
parsing -I typing -I bytecomp -I asmcomp -I driver -I toplevel -c util
s/tbl.mli
boot/ocamlrun boot/ocamlc -nostdlib -I boot -warn-error A -I utils -I 
parsing -I typing -I bytecomp -I asmcomp -I driver -I toplevel -c util
s/tbl.ml............................

sorry i am not more able to help with this but i subscribed tot eh 
mailing list and if further verification of this is needed and i can 
help please instruct me as to what i need to do and i will.
 
i am running test5 now without this issue and all test6 kernels i have 
tried produce this behavior for me.


ciao

merwan


