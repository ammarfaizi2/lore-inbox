Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291574AbSBAHE1>; Fri, 1 Feb 2002 02:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291577AbSBAHES>; Fri, 1 Feb 2002 02:04:18 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:3341 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S291574AbSBAHEH>;
	Fri, 1 Feb 2002 02:04:07 -0500
Date: Fri, 1 Feb 2002 08:04:05 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@oss.sgi.com,
        Linux ARM mailing list 
	<linux-arm-kernel@lists.arm.linux.org.uk>
Subject: Re: [PATCH] Migration to input api for keyboards
Message-ID: <20020201080405.B15571@suse.cz>
In-Reply-To: <20020131004041.K19292@flint.arm.linux.org.uk> <Pine.LNX.4.10.10201311159380.23385-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10201311159380.23385-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Thu, Jan 31, 2002 at 12:06:36PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 12:06:36PM -0800, James Simmons wrote:

> > >    As some on you know the input api drivers for the PS/2 keyboard/mice
> > > have gone into the dj tree for 2.5.X. I need people on other platforms
> > > besides ix86 to test it out. I made the following patch that forces the
> > > use of the new input drivers so people can test it. Shortly this patch
> > > will be placed into the DJ tree but before I do this I want to make sure
> > > it works for all platforms. Here is the patch to do this. Thank you.  
> > 
> > Oops.
> 
> Oops?
> 
> > Out of those 3 ARM machines, only 1 or maybe 2 has an 8042-compatible
> > port.
> > 
> > CONFIG_PC_KEYB != i8042 controller present.  Please look more closely
> > at stuff in include/asm-arm/arch-*/keyboard.h
> 
> I posted to find out which ones. BTW we have a driver for the acorn
> keyboard controller. No acorn keyboard but we do have support the acorn

The acorn RiscPC keyboard controller has a connector for the standard AT
keyboard, so it's rpckbd.c + atkbd.c doing the trick there.

> mouse. I can create a patch so you can give the mouse driver a try. Also
> help on porting the acorn keyboard driver would be helpful, any docs on
> it. 

Not needed. It's atkbd.c. And that way it'll be for a lot of other
hardware - AT keyboards are used everywhere, only the controllers
differ. That's the main reason for the keyboard (input) and keyboard
controller (serio) driver split!

-- 
Vojtech Pavlik
SuSE Labs
