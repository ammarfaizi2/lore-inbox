Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262750AbRFCDlS>; Sat, 2 Jun 2001 23:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262751AbRFCDlI>; Sat, 2 Jun 2001 23:41:08 -0400
Received: from www.transvirtual.com ([206.14.214.140]:40970 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S262750AbRFCDku>; Sat, 2 Jun 2001 23:40:50 -0400
Date: Sat, 2 Jun 2001 20:40:04 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: Andries.Brouwer@cwi.nl,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: keyboard hook?
In-Reply-To: <991518977.5581.0.camel@gromit>
Message-ID: <Pine.LNX.4.10.10106022028040.9396-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

   Your best bet for a kernel driver is to use the linux input api like
the usb keyboard do. The drivers are pretty simple to write and since all
the keyboard drivers will be port over to this api it will save a lot of 
work done the road. If you need help let me know. I will be glad to help.
It sounds alot alike the p2 to serial driver just placed in our CVS. You
can access our CVS by doing 

cvs -d:pserver:anonymous@cvs.linuxconsole.sourceforge.net:/cvsroot/linuxconsole login

cvs -z3 -d:pserver:anonymous@cvs.linuxconsole.sourceforge.net:/cvsroot/linuxconsole co ruby

The driver is in ruby/linux/drivers/input as ps2serkbd.c.

> I'm beginning the process of writing a driver for the "Qoder"
> keyboard-fob barcode scanner made by InterMec. It communicates with the
> host computer using the PS/2 port by way of a "dock" that sits in
> between the keyboard and the computer.
 
> One of them is "turn
> numlock light on," which I can do with an ioctl from userspace (as root,
> anyway), but also caps lock, num lock and carriage-return scancodes.

EV_LED

> The CueCat driver written by Pierre Coupard also modifies the keyboard
> driver. It would be nice if it was possible to load modules that hook
> into keyboard processing without requiring a kernel patch. And perhaps
> there is, but I haven't run across it yet.

input api :-)
 

