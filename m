Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314961AbSD2JTA>; Mon, 29 Apr 2002 05:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314962AbSD2JS7>; Mon, 29 Apr 2002 05:18:59 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:47867 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S314961AbSD2JS6>; Mon, 29 Apr 2002 05:18:58 -0400
Date: Mon, 29 Apr 2002 11:14:57 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.10-dj1
In-Reply-To: <20020427030823.GA21608@suse.de>
Message-ID: <Pine.NEB.4.44.0204290906540.3103-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

while building 2.5.10-dj the following build error occured that doesn't
occur when I back out the changes to drivers/scsi/aic7xxx/aicasm that are
in the -dj1 patch:

<--  snip  -->

...
make[5]: Entering directory
`/home/bunk/linux/kernel-2.5/linux-2.5.10/drivers/sc
si/aic7xxx/aicasm'
yacc -d -b aicasm_gram aicasm_gram.y
aicasm_gram.y:921: warning: previous rule lacks an ending `;'
aicasm_gram.y:935: warning: previous rule lacks an ending `;'
mv aicasm_gram.tab.c aicasm_gram.c
mv aicasm_gram.tab.h aicasm_gram.h
lex  -t aicasm_scan.l > aicasm_scan.c
gcc -I/usr/include -I. -ldb aicasm.c aicasm_symbol.c aicasm_gram.c
aicasm_macro_gram.c aicasm_scan.c aicasm_macro_scan.c -o aicasm
aicasm_gram.y:1846: warning: type mismatch with previous implicit
declaration
/usr/share/bison/bison.simple:924: warning: previous implicit declaration
of `yyerror'
aicasm_gram.y:1846: warning: `yyerror' was previously implicitly declared
to return `int'
aicasm_macro_gram.y:162: warning: type mismatch with previous implicit
declaration
/usr/share/bison/bison.simple:924: warning: previous implicit declaration
of `mmerror'
aicasm_macro_gram.y:162: warning: `mmerror' was previously implicitly
declared to return `int'
make[5]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.10/drivers/scsi/aic7xxx/aicasm'
aicasm/aicasm -I. -r aic7xxx_reg.h -o aic7xxx_seq.h aic7xxx.seq
aicasm/aicasm: Stopped at file aic7xxx.reg, line 1013 - parse error
aicasm/aicasm: Removing aic7xxx_seq.h due to error
aicasm/aicasm: Removing aic7xxx_reg.h due to error
make[4]: *** [aic7xxx_reg.h] Error 65
make[4]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.10/drivers/scsi/aic7xxx'

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


