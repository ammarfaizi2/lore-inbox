Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965249AbWE1FhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbWE1FhM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 01:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbWE1FhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 01:37:12 -0400
Received: from xenotime.net ([66.160.160.81]:23249 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965249AbWE1FhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 01:37:11 -0400
Date: Sat, 27 May 2006 22:39:45 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc 4.1.1 issues with 2.6.17-rc5
Message-Id: <20060527223945.05cd5b5b.rdunlap@xenotime.net>
In-Reply-To: <200605281521.20876.kernel@kolivas.org>
References: <200605281255.49821.kernel@kolivas.org>
	<200605281521.20876.kernel@kolivas.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2006 15:21:20 +1000 Con Kolivas wrote:

> On Sunday 28 May 2006 12:55, Con Kolivas wrote:
> > Funky new warnings on upgrading to gcc 4.1.1
> >
> > gcc compiled locally with:
> > Target: i686-pc-linux-gnu
> > Configured with: ../gcc-4.1.1/configure --prefix=/usr
> > --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared
> > --enable-threads=posix
> > --disable-checking --enable-long-long --enable-__cxa_atexit
> > --enable-clocale=gnu --disable-libunwind-exceptions
> > --enable-languages=c,c++ --program-suffix=-4.1.1
> >
> > warnings:
> >   OBJCOPY arch/i386/boot/vmlinux.bin
> > WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference
> > to .init.text: from .smp_locks after '' (at offset 0x0)
> > WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference
> > to .init.text: from .smp_locks after '' (at offset 0x4)
> > WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference
> > to .exit.text: from .smp_locks after '' (at offset 0x8)
> > WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference
> > to .exit.text: from .smp_locks after '' (at offset 0xc)
> > WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference
> > to .exit.text: from .smp_locks after '' (at offset 0x10)
> >   BUILD   arch/i386/boot/bzImage
> 
> Should also mention:
> binutils-2.15.92.0.2-6.2.102mdk
> 
> and a missed one:
> WARNING: drivers/usb/storage/usb-storage.o - Section mismatch: reference 
> to .exit.text: from .smp_locks after '' (at offset 0x40)

Yep, Jesper posted that one.
I also see it in ieee1394.o.

So where does the .smp_locks section come from?
Is this just a section checker bug/issue?

---
~Randy
