Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282147AbRLDGRS>; Tue, 4 Dec 2001 01:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282165AbRLDGRI>; Tue, 4 Dec 2001 01:17:08 -0500
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:26023 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S282147AbRLDGQ6>; Tue, 4 Dec 2001 01:16:58 -0500
Date: Tue, 4 Dec 2001 01:16:55 -0500 (EST)
From: "Daniel T. Chen" <crimsun@email.unc.edu>
To: safemode <safemode@speakeasy.net>
cc: real <haxmail@subdimension.com>, linux-kernel@vger.kernel.org
Subject: Re: Compilation error with Kernels 2.4.16 && 2.5.X
In-Reply-To: <1007442642.5959.1.camel@psuedomode>
Message-ID: <Pine.A41.4.21L1.0112040113310.59820-100000@login3.isis.unc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upon further investigation this is related to the specific version of
binutils used in linking the kernel after compilation. Please see
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=122179&repeatmerged=yes
for more details. Additionally, not all kernel .configs will trigger
it. The USB segment is definitely in a common point, though. 2.2 kernels
don't seem to exhibit it; but any 2.4 with certain .configs will.

---
Dan Chen                 crimsun@email.unc.edu
GPG key: www.cs.unc.edu/~chenda/pubkey.gpg.asc

On 4 Dec 2001, safemode wrote:

> On Mon, 2001-12-03 at 09:54, real wrote:
> > drivers/char/char.o(.data+0x46b4): undefined reference to `local symbols 
> > in discarded section .text.exit'
> > drivers/net/net.o(.data+0xbb4): undefined reference to `local symbols in 
> > discarded section .text.exit'
> > drivers/sound/sounddrivers.o(.data+0xb4): undefined reference to `local 
> > symbols in discarded section .text.exit'
> > drivers/usb/usbdrv.o(.data+0x234): undefined reference to `local symbols 
> > in discarded section .text.exit'
> > make: *** [vmlinux] Error 1
> 
> Same here.  How many other people are finding this to be a problem?   
> same problem with 2.4.17-pre2  

