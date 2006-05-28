Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965244AbWE1FVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965244AbWE1FVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 01:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbWE1FVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 01:21:25 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:7626 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S965244AbWE1FVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 01:21:24 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: gcc 4.1.1 issues with 2.6.17-rc5
Date: Sun, 28 May 2006 15:21:20 +1000
User-Agent: KMail/1.9.1
References: <200605281255.49821.kernel@kolivas.org>
In-Reply-To: <200605281255.49821.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605281521.20876.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 May 2006 12:55, Con Kolivas wrote:
> Funky new warnings on upgrading to gcc 4.1.1
>
> gcc compiled locally with:
> Target: i686-pc-linux-gnu
> Configured with: ../gcc-4.1.1/configure --prefix=/usr
> --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared
> --enable-threads=posix
> --disable-checking --enable-long-long --enable-__cxa_atexit
> --enable-clocale=gnu --disable-libunwind-exceptions
> --enable-languages=c,c++ --program-suffix=-4.1.1
>
> warnings:
>   OBJCOPY arch/i386/boot/vmlinux.bin
> WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference
> to .init.text: from .smp_locks after '' (at offset 0x0)
> WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference
> to .init.text: from .smp_locks after '' (at offset 0x4)
> WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference
> to .exit.text: from .smp_locks after '' (at offset 0x8)
> WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference
> to .exit.text: from .smp_locks after '' (at offset 0xc)
> WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference
> to .exit.text: from .smp_locks after '' (at offset 0x10)
>   BUILD   arch/i386/boot/bzImage

Should also mention:
binutils-2.15.92.0.2-6.2.102mdk

and a missed one:
WARNING: drivers/usb/storage/usb-storage.o - Section mismatch: reference 
to .exit.text: from .smp_locks after '' (at offset 0x40)

-- 
-ck
