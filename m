Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261224AbTCFXSy>; Thu, 6 Mar 2003 18:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261258AbTCFXSx>; Thu, 6 Mar 2003 18:18:53 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:35276 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id <S261224AbTCFXSu>; Thu, 6 Mar 2003 18:18:50 -0500
Date: Fri, 7 Mar 2003 10:29:11 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.64 - xircom realport no workie well
Message-ID: <20030306232911.GA588@zip.com.au>
References: <20030306130340.GA453@zip.com.au> <20030306132904.A838@flint.arm.linux.org.uk> <20030306134746.GE464@zip.com.au> <20030306140945.B838@flint.arm.linux.org.uk> <20030306152036.GA432@zip.com.au> <20030306153611.C838@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030306153611.C838@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 03:36:11PM +0000, Russell King wrote:
> > > > drivers/serial/8250_pci.c:1920: initializer element is not constant
> > > > drivers/serial/8250_pci.c:1920: (near initialization for
> > > > `serial_pci_tbl[86].device')
> > > 
> > > Bah.  You need this as well then:
> > 
> > Applied. It compiles now. Did a reboot into the new kernel and it hangs
> > somewhere in the point where it blanks the display but before it
> > switches to the framebuffer to display the kernel output messages (hope
> > that helps). I have no oops or anything. Just a blank display and no
> > disc activity or anything. ctrl-alt-del don't work and I have to turn my
> > laptop off in order to reboot.
> 
> Hmm.  Did you build 8250 into the kernel, or as a module?  TBH, I'm not

Into the kernel. I also forgot to mention that the pcmcia card was not
present at the time.

> sure how this could have affected the framebuffer driver.  I'll look
> harder in a couple of hours though.

A lot of things appear to happen once the fb driver comes up. From the
messages displayed the kernel seems to have gone through a fair chunk of
its init. (although that could be it goiing through it at such a fast
pace after the fb comes up that it just seems that way :)

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, 'President' of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)
