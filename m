Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbSLXLhZ>; Tue, 24 Dec 2002 06:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbSLXLhZ>; Tue, 24 Dec 2002 06:37:25 -0500
Received: from cibs9.sns.it ([192.167.206.29]:56587 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S261312AbSLXLhY>;
	Tue, 24 Dec 2002 06:37:24 -0500
Date: Tue, 24 Dec 2002 12:45:35 +0100 (CET)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: aicasm: SIG 11 with 2.5.53 (new aic7xxx driver problem)
Message-ID: <Pine.LNX.4.43.0212241237480.30482-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI,
I was compiling new kernel 2.5.53.
If "build adaptec formware" option is enabled, (I know I should avoid it, but it
is a development kernel, and I am doing tests ;) ),
compiling aic7xxx driver,
compilation fails because
of a segmentation fault I get running aicasm.


Here is the error message:

yacc -d -b aicasm_gram aicasm_gram.y
yacc: 2 rules never reduced
mv aicasm_gram.tab.c aicasm_gram.c
mv aicasm_gram.tab.h aicasm_gram.h
yacc -d -b aicasm_macro_gram -p mm aicasm_macro_gram.y
mv aicasm_macro_gram.tab.c aicasm_macro_gram.c
mv aicasm_macro_gram.tab.h aicasm_macro_gram.h
lex  -oaicasm_scan.c aicasm_scan.l
lex  -Pmm -oaicasm_macro_scan.c aicasm_macro_scan.l
gcc -I/usr/include -I. -ldb aicasm.c aicasm_symbol.c aicasm_gram.c
aicasm_macro_gram.c aicasm_scan.c aicasm_macro_scan.c -o aicasm
drivers/scsi/aic7xxx/aicasm/aicasm -Idrivers/scsi/aic7xxx -r
drivers/scsi/aic7xxx/aic7xxx_reg.h -o drivers/scsi/aic7xxx/aic7xxx_seq.h
drivers/scsi/aic7xxx/aic7xxx.seq
drivers/scsi/aic7xxx/aicasm/aicasm: 888 instructions used
make[3]: *** [drivers/scsi/aic7xxx/aic7xxx_seq.h] Segmentation fault
make[3]: *** Deleting file `drivers/scsi/aic7xxx/aic7xxx_seq.h'
make[2]: *** [drivers/scsi/aic7xxx] Error 2
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2


system is Athlon tbird 1300, 768 MB RAM,
via 686b chipset, gcc 3.2.1, binutils 2.13.90.0.16,
glibc 2.3.1.

Hope this helps

Luigi



