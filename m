Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267219AbSK3GxQ>; Sat, 30 Nov 2002 01:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267220AbSK3GxQ>; Sat, 30 Nov 2002 01:53:16 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:63164 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S267219AbSK3GxP>; Sat, 30 Nov 2002 01:53:15 -0500
Date: Fri, 29 Nov 2002 23:00:53 -0800
From: Joshua Kwan <joshk@mspencer.net>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.4.20-ac1
Message-Id: <20021129230053.0db0a8fa.joshk@mspencer.net>
In-Reply-To: <200211292324.gATNOQO26672@devserv.devel.redhat.com>
References: <200211292324.gATNOQO26672@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.8.6cvs7 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the record (more of a recap of previous messages over the last few days), DRM is still kinda broken, at least for my Radeon card.

Arjan's fixes seemed to have fixed the Rage 128 DRM but Radeon DRM is still mighty sketchy. I'm scared to let my GL-based screensaver kick in lest it lock my system up. His fixes supressed the kernel oops that occurred when starting XFree and the unavailability of hardware acceleration in DRI games, but the end result is still that no DRI applications will run correctly in 2.4.20-ac1, or anything past -rc2-ac3 for that matter (which as you can see below is when the DRM updates were made in foresight of the new xfree 4.3 drm interface.

I was unable to catch any kernel messages after starting GL-based apps, but it has just occurred to me that remote access might still work and I could dump any kernel messages from there. I will write some more later...

Regards
Josh

Rabid cheeseburgers forced Alan Cox <alan@redhat.com> to write this on Fri, 29 Nov 2002 18:24:26 -0500 (EST):	

> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out, - indicates stuff not relevant to the main tree]
> 
> This is the initial 2.4.20-ac merge up. This one may still have a few
> small funnies to shake out especially in the DRM updates.
> 
> Linux 2.4.20-ac1
> 	Merge with Marcelo 2.4.20
> o	Fix CIA revision 1 Alcor initialization		(Bjoern Brauel)
> o	VIA KT400 AGP support				(Nicolas Mailhot)
> o	ns83820 oops fix				(Ruger Luethi)
> o	Fix bmac missing timer setup			(Jeff Garzik)
> o	NUMAQ compile fixes				(Adrian Bunk)
> o	Fix midi byte loss on fifo full			(Clemens Ladisch)
> o	Fix mptlan compile				(Adriank Bunk)
> o	Update ewrk3 to support setting MAC address	(Adam Kropelin)
> o	Merge most of the parisc patch submission	(Matthew Wilcox)
> o	Fixes for the drm updates			(Arjan van de Ven)
> o	Fix AGP GART casting errors			(me)
> 
> Linux 2.4.20-rc4-ac1
> 	Merge with Marcelo 2.4.20-rc4
> o	Fix serverworks BUG with UDMA CD-ROM		(me)
> o	Revert pc keyb changes causing hangs on VIA	(me)
> 	boxes without a PS/2 mouse
> o	Fix out of date examples of misc_register	(Chris Wilson)
> 	and check_region in mousedriver docs
> o	Fix hang and carrier handling on lanstreamer	(Kent Yoder)
> o	Fix ac97 codec name printing			(Paul)
> o	Fix off by one buffer copy on advansys		(Rik van Riel)
> o	Fix division by zero in tigl usb		(Randy Dunlap)
<snip>

> Linux 2.4.20-rc2-ac3
> o	Add handling for video capture hang on ALi	(me)
> 	Magik, when using BT848/BT878 devices
> o	Signal handling performance fixes		(Andrew Morton)
> o	Add VIA KT400 to the AGP tables			(Dave Jones)
> o	Update direct rendering manager to support	(Arjan van de Ven)
> 	upcoming XFree 4.3
> 	| XFree86 release with the Linux bug fixes
> 	| restored and a lot of noise/junk removed

<snip>

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
