Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266612AbTGFFj2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 01:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbTGFFj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 01:39:28 -0400
Received: from co239024-a.almel1.ov.home.nl ([217.120.226.100]:7811 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266612AbTGFFj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 01:39:26 -0400
Date: Sun, 6 Jul 2003 07:55:57 +0200 (CEST)
From: Aschwin Marsman <a.marsman@aYniK.com>
X-X-Sender: marsman@localhost.localdomain
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre3
In-Reply-To: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.44.0307060742320.1805-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jul 2003, Marcelo Tosatti wrote:

> Hi,
> 
> Here goes -pre3. It contains a lot of updates and fixes all over.
> 
> We should have increased interactivity under heavy IO (users with
> interactivity problems please test and report results).

Compilation breaks for me:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.21/include -Wall -Wstrict-prototypes 
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
 -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS 
 -include /usr/src/linux-2.4.21/include/linux/modversions.h  -nostdinc 
 -iwithprefix include -DKBUILD_BASENAME=vicam  -c -o vicam.o vicam.c
vicam.c: In function `vicam_close':
vicam.c:767: parse error before `struct'
vicam.c:770: `cam' undeclared (first use in this function)
vicam.c:770: (Each undeclared identifier is reported only once
vicam.c:770: for each function it appears in.)
make[2]: *** [vicam.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.21/drivers/usb'
make[1]: *** [_modsubdir_usb] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.21/drivers'
make: *** [_mod_drivers] Error 2

Two patches are included that might be a cause, although it looks like
they were included to solve compilation problems:

>   o USB: compiler fixes for previous vicam patches
>   o USB: fix to previous vicam patch
 
I changed CONFIG_USB_VICAM from a module to no, because I don't need
the driver.

Have a nice weekend,
 
Aschwin Marsman
 
--
aYniK Software Solutions         all You need is Knowledge
P.O. box 134                     NL-7600 AC Almelo - the Netherlands
a.marsman@aYniK.com              http://www.aYniK.com

