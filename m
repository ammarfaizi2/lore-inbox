Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSGUUjf>; Sun, 21 Jul 2002 16:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSGUUjf>; Sun, 21 Jul 2002 16:39:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37642 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313416AbSGUUjf>; Sun, 21 Jul 2002 16:39:35 -0400
Date: Sun, 21 Jul 2002 21:42:39 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A1
Message-ID: <20020721214239.C26376@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0207212038350.23450-100000@localhost.localdomain> <20020721205800.B26376@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020721205800.B26376@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Jul 21, 2002 at 08:58:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2002 at 08:58:01PM +0100, Russell King wrote:
> On Sun, Jul 21, 2002 at 08:50:35PM +0200, Ingo Molnar wrote:
> > (the serial subsystem is disabled for example.)
> 
> As far as the serial stuff goes:
> 
> - William Irvin and Zwane Mwaikambo have been testing it, found a
>   deadlock, now fixed. (yay)
> 
> - Zwane reports that serial console doesn't work for him.  Oddly,
>   it works here on a Netwinder (which has all the bits'n'pieces to
>   be close enough to a PC with a PCI bus, southbridge, and standard
>   serial ports at standard IO bases and standard IRQs) so I'm at a
>   loss why this works for me but not Zwane.
> 
> I'm just sorting out a 2.5.26-rmk1 release, then update to 2.5.27,
> make sure it builds, and then I'll be sending the serial stuff to
> Linus.  Until then, I've no idea if any patch I create will apply
> to 2.5.27.
> 
> Gimme about an hour or so and I'll have the patch ready.

Ok, 2.5.27 doesn't seem to touch any of the affected files; the patch
still applies.  In such a short time period, I've not been able to
confirm that it actually works with 2.5.27, only with 2.5.26.

Here's the complete patch; it's rather large, so for mortals it's
available from:

  http://www.arm.linux.org.uk/cvs/serial-2.5.26-3.diff.bz2

I'm going to send it in mail to Linus separately.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

