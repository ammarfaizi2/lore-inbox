Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263210AbRFCPGr>; Sun, 3 Jun 2001 11:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263167AbRFCPFh>; Sun, 3 Jun 2001 11:05:37 -0400
Received: from 513.holly-springs.nc.us ([216.27.31.173]:41454 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S263015AbRFCPF0>; Sun, 3 Jun 2001 11:05:26 -0400
Date: Sun, 3 Jun 2001 11:02:39 -0400
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Michael Rothwell <rothwell@holly-springs.nc.us>, Andries.Brouwer@cwi.nl,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: keyboard hook?
Message-ID: <20010603110239.A4982@513.holly-springs.nc.us>
Mail-Followup-To: Michael Rothwell <rothwell@holly-springs.nc.us>,
	James Simmons <jsimmons@transvirtual.com>, Andries.Brouwer@cwi.nl,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux console project <linuxconsole-dev@lists.sourceforge.net>
In-Reply-To: <991518977.5581.0.camel@gromit> <Pine.LNX.4.10.10106022028040.9396-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10106022028040.9396-100000@transvirtual.com>; from jsimmons@transvirtual.com on Sat, Jun 02, 2001 at 08:40:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I'm loking through your driver now. Does the input api already/currently support ps2 keyboards?

-M

On Sat, Jun 02, 2001 at 08:40:04PM -0700, James Simmons wrote:
> 
> Hi!
> 
>    Your best bet for a kernel driver is to use the linux input api like
> the usb keyboard do. The drivers are pretty simple to write and since all
> the keyboard drivers will be port over to this api it will save a lot of 
> work done the road. If you need help let me know. I will be glad to help.
> It sounds alot alike the p2 to serial driver just placed in our CVS. You
> can access our CVS by doing 
> 
> cvs -d:pserver:anonymous@cvs.linuxconsole.sourceforge.net:/cvsroot/linuxconsole login
> 
> cvs -z3 -d:pserver:anonymous@cvs.linuxconsole.sourceforge.net:/cvsroot/linuxconsole co ruby
> 
> The driver is in ruby/linux/drivers/input as ps2serkbd.c.
> 
> > I'm beginning the process of writing a driver for the "Qoder"
> > keyboard-fob barcode scanner made by InterMec. It communicates with the
> > host computer using the PS/2 port by way of a "dock" that sits in
> > between the keyboard and the computer.
>  
> > One of them is "turn
> > numlock light on," which I can do with an ioctl from userspace (as root,
> > anyway), but also caps lock, num lock and carriage-return scancodes.
> 
> EV_LED
> 
> > The CueCat driver written by Pierre Coupard also modifies the keyboard
> > driver. It would be nice if it was possible to load modules that hook
> > into keyboard processing without requiring a kernel patch. And perhaps
> > there is, but I haven't run across it yet.
> 
> input api :-)
>  
