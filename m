Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbTJ1XGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 18:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTJ1XGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 18:06:15 -0500
Received: from smtp2.arnet.com.ar ([200.45.191.5]:32516 "HELO
	smtp2.arnet.com.ar") by vger.kernel.org with SMTP id S261784AbTJ1XGM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 18:06:12 -0500
Date: Tue, 28 Oct 2003 20:05:44 -0300
From: Javier Villavicencio <jvillavicencio@arnet.com.ar>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
Subject: Re: RadeonFB [Re: 2.4.23pre8 - ACPI Kernel Panic on boot]
Message-Id: <20031028200544.4e10cc97.jvillavicencio@arnet.com.ar>
In-Reply-To: <3F9EF0C9.3090507@enterprise.bidmc.harvard.edu>
References: <Pine.LNX.4.44.0310281349210.4639-100000@logos.cnet>
	<3F9EF0C9.3090507@enterprise.bidmc.harvard.edu>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Oct 2003 17:42:17 -0500
"Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu> wrote:

> Marcelo Tosatti wrote:
> 
> >Joachim, 
> >The patch in question has caused other problems and will be removed.
> >  
> >
> 
> Speaking of patches causing problems and needing reversion, can the 
> screen-corrupting RadeonFB patch introduced in 2.4.23-pre3 be reverted 
> until such time as it is fixed?  I know there was a maintainer war going 
> on over who should officially submit RadeonFB patches; somewhere in 
> there, updates and fixes stopped coming.
> 
> As it now stands in current -pre kernels, returning from XFree86 to a 
> RadeonFB console results in total gibberish all over the screen (with my 
> hardware anyway, a standard Built-by-ATI Radeon 8500 LE chipset QL 
> rev0).  There is no workaround, other than to return to X.  Another bug 
> also causes screen corruption when switching VCs (it forgets where in 
> the YPan it is), but this can be easily worked around by setting VYRES = 
> YRES (fbset -match -a).
> 
> The previous version of RadeonFB in 2.4.23-pre2 and earlier works just 
> fine on my Radeon 8500 hardware, albeit without accelerated scrolling.  
> Of course, if people with other Radeon flavors can't use the older 
> driver but the newer one works for them, then short of a 
> CONFIG_OLD_RADEONFB, I guess we should keep the current one...
> 

Just to add some words about this, the older patch doesn't have support
for my Radeon 9600 Pro (RV350 chipset AP), so I tried the new one,
which has support, but only that, the new one is what Kristofer told
here among other things. So I added (just guessing, no idea if that was
right, for fun maybe) the PCI_IDs and RV350 checks in some places
of the old driver (I'm pretty sure they're all wrong), compiled and tried.
The old driver works *just fine* with my Radeon 9600, I only have a little
character distortion when trying to show the default linux logo, it shows 
without problems my customized logo, strange this. I can switch from X
without any trouble and the console looks fine.
I did this for kernel version prior to linux-2.6.0-test9 there are a new fbdev
patch but I added the radeonfb_setup function to it, it wasn't compiling
, not taking arguments from the kernel command line video=...., and 
has the same behaviour as the new driver.


Salu2.

Javier Villavicencio
-----------------------
qué desastre.-
