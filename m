Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbSLCJqL>; Tue, 3 Dec 2002 04:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266183AbSLCJqL>; Tue, 3 Dec 2002 04:46:11 -0500
Received: from users.linvision.com ([62.58.92.114]:20357 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S266175AbSLCJqL>; Tue, 3 Dec 2002 04:46:11 -0500
Date: Tue, 3 Dec 2002 10:53:28 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Stian Jordet <liste@jordet.nu>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Unsupported AGP-bridge on VIA VT8633
Message-ID: <20021203105328.A27071@bitwizard.nl>
References: <1037916067.813.7.camel@chevrolet.hybel> <20021121221134.GA25741@suse.de> <1037917231.3ddd5c2f5d98a@webmail.jordet.nu> <20021121224035.GA28094@suse.de> <1037919383.856.3.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037919383.856.3.camel@chevrolet.hybel>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 11:56:23PM +0100, Stian Jordet wrote:
> tor, 2002-11-21 kl. 23:40 skrev Dave Jones:
> > On Thu, Nov 21, 2002 at 11:20:31PM +0100, Stian Jordet wrote:
> > 
> >  > You were not really clear here. I tried it as a boot-time argument, because I
> >  > have agp-support compiled in. But I guess I could and should try it as a module.
> > 
> > Yup. Then do a `modprobe agpgart agp_try_unsupported=1'
> > 
> >  > I'll do that now. But why do I have to use agp_try_unsupported=1?
> > 
> > Because if it works, we can then add it to the ID table.
> 
> It works, i think. I get this message when I load it:
> 
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 439M
> agpgart: Trying generic Via routines for device id: 3091
> agpgart: AGP aperture is 64M @ 0xf8000000

Hi Dave, Stian,

"Same here": The module loads...

However, I have the impression that it doesn't work.  I first noticed 
that my Xserver was taking 50% of my CPU while playing videos. This
is much less on all other computers that I tried that on. 

Turns out that "write bandwidth" to video memory is less than 40Mb
per second. On another system with the same video card, but with a 
supported AGP bridge, I get almost 200Mbyte per second. I'll go and
dig for "testgart" and see what that proves.... 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
