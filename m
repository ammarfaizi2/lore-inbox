Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267206AbSKXMSG>; Sun, 24 Nov 2002 07:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267211AbSKXMSF>; Sun, 24 Nov 2002 07:18:05 -0500
Received: from [144.135.24.138] ([144.135.24.138]:27355 "EHLO
	mta02bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S267206AbSKXMSE>; Sun, 24 Nov 2002 07:18:04 -0500
Message-ID: <01ec01c293b4$7190b320$41368490@archaic>
From: "David McIlwraith" <quack@bigpond.net.au>
To: "Tomas Szepe" <szepe@pinerecords.com>
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
References: <0H6200FDECOBEI@mtaout05.icomcast.net> <20021124121546.GA16407@louise.pinerecords.com>
Subject: Re: LEX = flex
Date: Sun, 24 Nov 2002 23:24:32 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3663.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3663.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Requires a DB library compiled with --enable-compat185, I believe (SleepyCat
DB version 2.x or later), or Berkeley DB 1.85 itself.

- David McIlwraith

----- Original Message -----
From: "Tomas Szepe" <szepe@pinerecords.com>
To: "Jerry McBride" <mcbrides9@comcast.net>
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
Sent: Sunday, November 24, 2002 11:15 PM
Subject: Re: LEX = flex


> > It's an old one... and it's STILL HERE!
> > 2.4.20-rc3...
> > make kernel on i386 fails in /drivers/scsi/aic7xxx/aicasm/Makefile
> > LEX is not assigned a value...
> > However making LEX=flex works and make modules completes 100%...
>
> Just do
> (cd $(dirname $(which flex)) && ln -s flex lex)
>
> There's another problem, though:
>
> make[5]: Entering directory
`/home/kala/lx/linux-2.4.20-rc3/drivers/scsi/aic7xxx/aicasm'
> yacc -d -b aicasm_gram aicasm_gram.y
> mv aicasm_gram.tab.c aicasm_gram.c
> mv aicasm_gram.tab.h aicasm_gram.h
> yacc -d -b aicasm_macro_gram -p mm aicasm_macro_gram.y
> mv aicasm_macro_gram.tab.c aicasm_macro_gram.c
> mv aicasm_macro_gram.tab.h aicasm_macro_gram.h
> yacc -d -b aicasm_macro_gram -p mm aicasm_macro_gram.y
> mv aicasm_macro_gram.tab.c aicasm_macro_gram.c
> mv aicasm_macro_gram.tab.h aicasm_macro_gram.h
> lex  -oaicasm_scan.c aicasm_scan.l
> lex  -Pmm -oaicasm_macro_scan.c aicasm_macro_scan.l
> gcc -I/usr/include -I. -ldb aicasm.c aicasm_symbol.c aicasm_gram.c
aicasm_macro_gram.c aicasm_scan.c aicasm_macro_scan.c -o aicasm
> /tmp/ccwpPZ3E.o: In function `symtable_open':
> /tmp/ccwpPZ3E.o(.text+0x1df): undefined reference to `__db185_open'
> collect2: ld returned 1 exit status
> make[5]: *** [aicasm] Error 1
> make[5]: Leaving directory
`/home/kala/lx/linux-2.4.20-rc3/drivers/scsi/aic7xxx/aicasm'
>
> --
> Tomas Szepe <szepe@pinerecords.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

