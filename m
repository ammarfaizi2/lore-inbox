Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132919AbRDXXba>; Tue, 24 Apr 2001 19:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135701AbRDXXbV>; Tue, 24 Apr 2001 19:31:21 -0400
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:47886 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S132919AbRDXXbK>; Tue, 24 Apr 2001 19:31:10 -0400
Date: Tue, 24 Apr 2001 19:32:50 -0400
From: Michael Meissner <meissner@spectacle-pond.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3ac13
Message-ID: <20010424193250.A4242@munchkin.spectacle-pond.org>
In-Reply-To: <E14rqT9-0000s4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14rqT9-0000s4-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Apr 24, 2001 at 01:14:11AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 01:14:11AM +0100, Alan Cox wrote:
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> 
> 		Intermediate diffs are available from
> 
> 			http://www.bzimage.org
> 
> This isnt a proper release as such, it should just deal with most of the 
> compile failure/symbol failure problems.
> 
> 2.4.3-ac13
> o	Switch to NOVERS symbols for rwsem		(me)
> 	| Called from asm blocks so they can't be versioned
> o	Fix gcc 2.95 building on rwsem			(Niels Jensen)
> o	Fix cmsfs build				    (Andrzej Krzysztofowicz)
> o	Fix rio build/HZ setup			    (Andrzej Krzysztofowicz)
> o	Fix PPP filtering dependancy in config      (Andrzej Krzysztofowicz)

I just tried 2.4.3-ac13 on my laptop, a Toshiba Tecra 8000, which has a
NeoMagic video controller.  I boot it using the VESA frame buffer, using the
arguments:

	video=vesa:mtrr vga=0x317

for a 16-bit 1024x768 screen.  The video doesn't come on at all, but the
machine boots up normally (ie, I can log into it via ssh via the wireless
pcmcia card).  If I boot up with the VGA console, the screen is displayed just
fine.  This worked in 2.4.3-ac11.

Also, I initially built ac13 with:

	make mrproper
	make menuconfig

and it doesn't ask whether I want to build the normal USHI USB driver either as
a module or builtin to the kernel, only whether I want to build the alternative
USHI USB dirver (the JE driver).  Make xconfig asks whether you want to build
both drivers.  I'm not sure whether this was a bug in previous versions or
not.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
