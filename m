Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263828AbTJFRrt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264000AbTJFRrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:47:46 -0400
Received: from turkey.mail.pas.earthlink.net ([207.217.120.126]:20387 "EHLO
	turkey.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S263828AbTJFRq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 13:46:57 -0400
Message-ID: <00b401c38c31$d1360390$2eedfea9@kittycat>
From: "jdow" <jdow@earthlink.net>
To: "Jesper Juhl" <jju@dif.dk>, "Matthias Andree" <matthias.andree@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
References: <20031006082340.GA1135@matchmail.com> <1065428996.5033.5.camel@laptop.fenrus.com> <20031006083803.GB1135@matchmail.com> <20031006102415.GB7598@merlin.emma.line.org> <Pine.LNX.4.56.0310061655070.26687@jju_lnx.backbone.dif.dk>
Subject: Re: 71MB compressed for COMPILED(!!!) 2.6.0-test6
Date: Mon, 6 Oct 2003 10:46:48 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jesper Juhl" <jju@dif.dk>
> On Mon, 6 Oct 2003, Matthias Andree wrote:
>
> > On Mon, 06 Oct 2003, Mike Fedyk wrote:
> >
> > > config DEBUG_INFO
> > > bool "Compile the kernel with debug info"
> > > depends on DEBUG_KERNEL
> > > help
> > >           If you say Y here the resulting kernel image will include
> > >   debugging info resulting in a larger kernel image.
> > >   Say Y here only if you plan to use gdb to debug the kernel.
> > >   If you don't debug the kernel, you can say N.
> > >
> > > "Larger kernel image" yeah, NO SHIT! ;)
> > >
> > > Maybe something that says it may enlarge your kernel by 5-10 times
would be
> > > nice...
> >
> > Send a patch...
> >
>
> How about this one?  :
>
>
> diff -ur linux-2.6.0-test6-orig/arch/alpha/Kconfig
linux-2.6.0-test6/arch/alpha/Kconfig
> --- linux-2.6.0-test6-orig/arch/alpha/Kconfig 2003-09-28
02:50:39.000000000 +0200
> +++ linux-2.6.0-test6/arch/alpha/Kconfig 2003-10-06 17:10:32.000000000
+0200
> @@ -769,6 +769,8 @@
>   help
>            If you say Y here the resulting kernel image will include
>     debugging info resulting in a larger kernel image.
> +   This will substantially increase the size of the kernel image.
> +   Size increases of 5 to 10 times normal size is to be expected.

--------------------------------------------------^^ "are"

>     Say Y here only if you plan to use gdb to debug the kernel.
>     If you don't debug the kernel, you can say N.
>
> diff -ur linux-2.6.0-test6-orig/arch/arm26/Kconfig
linux-2.6.0-test6/arch/arm26/Kconfig
> --- linux-2.6.0-test6-orig/arch/arm26/Kconfig 2003-09-28
02:50:29.000000000 +0200
> +++ linux-2.6.0-test6/arch/arm26/Kconfig 2003-10-06 17:08:55.000000000
+0200
> @@ -336,6 +336,8 @@
>   help
>            If you say Y here the resulting kernel image will include
>     debugging info resulting in a larger kernel image.
> +   This will substantially increase the size of the kernel image.
> +   Size increases of 5 to 10 times normal size is to be expected.


--------------------------------------------------^^ "are"

>     Say Y here only if you plan to use gdb to debug the kernel.
>     If you don't debug the kernel, you can say N.
>
> diff -ur linux-2.6.0-test6-orig/arch/i386/Kconfig
linux-2.6.0-test6/arch/i386/Kconfig
> --- linux-2.6.0-test6-orig/arch/i386/Kconfig 2003-09-28 02:50:10.000000000
+0200
> +++ linux-2.6.0-test6/arch/i386/Kconfig 2003-10-06 17:05:38.000000000
+0200
> @@ -1244,6 +1244,8 @@
>   help
>            If you say Y here the resulting kernel image will include
>     debugging info resulting in a larger kernel image.
> +   This will substantially increase the size of the kernel image.
> +   Size increases of 5 to 10 times normal size is to be expected.

--------------------------------------------------^^ "are"

>     Say Y here only if you plan to use gdb to debug the kernel.
>     If you don't debug the kernel, you can say N.
>
> diff -ur linux-2.6.0-test6-orig/arch/ia64/Kconfig
linux-2.6.0-test6/arch/ia64/Kconfig
> --- linux-2.6.0-test6-orig/arch/ia64/Kconfig 2003-09-28 02:51:04.000000000
+0200
> +++ linux-2.6.0-test6/arch/ia64/Kconfig 2003-10-06 17:10:08.000000000
+0200
> @@ -683,6 +683,8 @@
>   help
>            If you say Y here the resulting kernel image will include
>     debugging info resulting in a larger kernel image.
> +   This will substantially increase the size of the kernel image.
> +   Size increases of 5 to 10 times normal size is to be expected.


--------------------------------------------------^^ "are"

>     Say Y here only if you plan to use gdb to debug the kernel.
>     If you don't debug the kernel, you can say N.
>
> diff -ur linux-2.6.0-test6-orig/arch/m68k/Kconfig
linux-2.6.0-test6/arch/m68k/Kconfig
> --- linux-2.6.0-test6-orig/arch/m68k/Kconfig 2003-09-28 02:50:29.000000000
+0200
> +++ linux-2.6.0-test6/arch/m68k/Kconfig 2003-10-06 17:09:33.000000000
+0200
> @@ -1166,6 +1166,8 @@
>   help
>            If you say Y here the resulting kernel image will include
>     debugging info resulting in a larger kernel image.
> +   This will substantially increase the size of the kernel image.
> +   Size increases of 5 to 10 times normal size is to be expected.


--------------------------------------------------^^ "are"

>     Say Y here only if you plan to use gdb to debug the kernel.
>     If you don't debug the kernel, you can say N.
>
> diff -ur linux-2.6.0-test6-orig/arch/parisc/Kconfig
linux-2.6.0-test6/arch/parisc/Kconfig
> --- linux-2.6.0-test6-orig/arch/parisc/Kconfig 2003-09-28
02:50:29.000000000 +0200
> +++ linux-2.6.0-test6/arch/parisc/Kconfig 2003-10-06 17:12:14.000000000
+0200
> @@ -257,6 +257,8 @@
>   help
>            If you say Y here the resulting kernel image will include
>     debugging info resulting in a larger kernel image.
> +   This will substantially increase the size of the kernel image.
> +   Size increases of 5 to 10 times normal size is to be expected.


--------------------------------------------------^^ "are"

>     Say Y here only if you plan to use gdb to debug the kernel.
>     If you don't debug the kernel, you can say N.
>
> diff -ur linux-2.6.0-test6-orig/arch/ppc/Kconfig
linux-2.6.0-test6/arch/ppc/Kconfig
> --- linux-2.6.0-test6-orig/arch/ppc/Kconfig 2003-09-28 02:51:12.000000000
+0200
> +++ linux-2.6.0-test6/arch/ppc/Kconfig 2003-10-06 17:06:47.000000000 +0200
> @@ -1390,6 +1390,8 @@
>   help
>            If you say Y here the resulting kernel image will include
>     debugging info resulting in a larger kernel image.
> +   This will substantially increase the size of the kernel image.
> +   Size increases of 5 to 10 times normal size is to be expected.

--------------------------------------------------^^ "are"

>     Say Y here only if you plan to use some sort of debugger to
>     debug the kernel.
>     If you don't debug the kernel, you can say N.
> diff -ur linux-2.6.0-test6-orig/arch/ppc64/Kconfig
linux-2.6.0-test6/arch/ppc64/Kconfig
> --- linux-2.6.0-test6-orig/arch/ppc64/Kconfig 2003-09-28
02:50:25.000000000 +0200
> +++ linux-2.6.0-test6/arch/ppc64/Kconfig 2003-10-06 17:11:00.000000000
+0200
> @@ -374,6 +374,8 @@
>   help
>            If you say Y here the resulting kernel image will include
>     debugging info resulting in a larger kernel image.
> +   This will substantially increase the size of the kernel image.
> +   Size increases of 5 to 10 times normal size is to be expected.

--------------------------------------------------^^ "are"

>     Say Y here only if you plan to use gdb to debug the kernel.
>     If you don't debug the kernel, you can say N.
>
> diff -ur linux-2.6.0-test6-orig/arch/s390/Kconfig
linux-2.6.0-test6/arch/s390/Kconfig
> --- linux-2.6.0-test6-orig/arch/s390/Kconfig 2003-09-28 02:50:16.000000000
+0200
> +++ linux-2.6.0-test6/arch/s390/Kconfig 2003-10-06 17:13:03.000000000
+0200
> @@ -309,6 +309,8 @@
>   help
>            If you say Y here the resulting kernel image will include
>     debugging info resulting in a larger kernel image.
> +   This will substantially increase the size of the kernel image.
> +   Size increases of 5 to 10 times normal size is to be expected.


--------------------------------------------------^^ "are"

>     Say Y here only if you plan to use gdb to debug the kernel.
>     If you don't debug the kernel, you can say N.
>
> diff -ur linux-2.6.0-test6-orig/arch/sparc64/Kconfig
linux-2.6.0-test6/arch/sparc64/Kconfig
> --- linux-2.6.0-test6-orig/arch/sparc64/Kconfig 2003-09-28
02:50:53.000000000 +0200
> +++ linux-2.6.0-test6/arch/sparc64/Kconfig 2003-10-06 17:07:22.000000000
+0200
> @@ -819,6 +819,8 @@
>   help
>            If you say Y here the resulting kernel image will include
>     debugging info resulting in a larger kernel image.
> +   This will substantially increase the size of the kernel image.
> +   Size increases of 5 to 10 times normal size is to be expected.


--------------------------------------------------^^ "are"

>     Say Y here only if you plan to use gdb to debug the kernel.
>     If you don't debug the kernel, you can say N.
>
> diff -ur linux-2.6.0-test6-orig/arch/x86_64/Kconfig
linux-2.6.0-test6/arch/x86_64/Kconfig
> --- linux-2.6.0-test6-orig/arch/x86_64/Kconfig 2003-09-28
02:50:40.000000000 +0200
> +++ linux-2.6.0-test6/arch/x86_64/Kconfig 2003-10-06 17:12:39.000000000
+0200
> @@ -495,6 +495,8 @@
>   help
>            If you say Y here the resulting kernel image will include
>     debugging info resulting in a larger kernel image.
> +   This will substantially increase the size of the kernel image.
> +   Size increases of 5 to 10 times normal size is to be expected.


--------------------------------------------------^^ "are"

>     Say Y here only if you plan to use gdb to debug the kernel.
>     If you don't debug the kernel, you can say N.
>
>
>
>
> Kind regards,
>
> Jesper Juhl <jju@dif.dk>

{o.o}    Joanne   (ME being a language weenie? Sheesh!)

