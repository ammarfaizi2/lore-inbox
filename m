Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWBCLgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWBCLgA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 06:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWBCLgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 06:36:00 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12167 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964776AbWBCLgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 06:36:00 -0500
Date: Fri, 3 Feb 2006 12:35:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       nigel@suspend2.net, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060203113543.GA3056@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022131.59928.nigel@suspend2.net> <20060202115907.GH1884@elf.ucw.cz> <200602022214.52752.nigel@suspend2.net> <20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org> <1138916079.15691.130.camel@mindpipe> <20060202142323.088a585c.akpm@osdl.org> <20060203105100.GD2830@elf.ucw.cz> <58cb370e0602030322u4c2c9f9bm21a38be6d35d2ea6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0602030322u4c2c9f9bm21a38be6d35d2ea6@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Video problems seem to be broken for suspend2ram, not swsusp.
> >
> > Not that we don't have swsusp drivers problems, but they tend to be
> > randomly, all over the map, mostly over drivers I never heard about.
> >
> > suspend2ram is different fish, video and ATA are real problems
> > there. At least there are solutions on ATA being worked on.
> 
> What PATA problems are you talking about?
> 
> In kernel bugzilla there are 2 bugs related to suspend/resume:
> 
> * #5257 for 2.6.13.1 (seem to be fixed in 2.6.15.2)
> * #5673 for 2.6.14.3 (not enough information to start debugging)
> 
> and I don't recall any problems being reported to linux-ide ML
> or linux-kernel ML recently.

We were not calling some ACPI methods to awake IDE correctly. It did
not properly work with disk passwords or something like that. 

...ahha, have it (should be reachable from outside...):

https://bugzilla.novell.com/show_bug.cgi?id=145591

(and linked:

http://bugzilla.kernel.org/show_bug.cgi?id=2039 and
http://bugzilla.kernel.org/show_bug.cgi?id=5604

)

> Most bugreports I've seen was caused by:
> * using ide-generic instead of proper host driver
>   (no wonder that it fails)
> * playing with hdparm when not needed (don't do it)
> 
> Also IIRC SATA suspend/resume support was merged into
> mainline (?) so things should work better now.

I think SATA had similar problems with ACPI methods. Patches for SATA
seem to be in better shape in PATA side, but I don't think they are in. 

But I do not have affected hardware here...
							Pavel
-- 
Thanks, Sharp!
