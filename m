Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263967AbTCWWnt>; Sun, 23 Mar 2003 17:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263968AbTCWWnt>; Sun, 23 Mar 2003 17:43:49 -0500
Received: from franka.aracnet.com ([216.99.193.44]:2004 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263967AbTCWWnr>; Sun, 23 Mar 2003 17:43:47 -0500
Date: Sun, 23 Mar 2003 14:54:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: James Bourne <jbourne@mtroyal.ab.ca>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>,
       Alan Cox <alan@redhat.com>, Stephan von Krawczynski <skraw@ithnet.com>,
       szepe@pinerecords.com, arjanv@redhat.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <1240000.1048460079@[10.10.2.4]>
In-Reply-To: <3E7E335C.2050509@pobox.com>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz>
 <200303231938.h2NJcAq14927@devserv.devel.redhat.com>
 <20030323194423.GC14750@atrey.karlin.mff.cuni.cz>
 <1048448838.1486.12.camel@phantasy.awol.org>
 <20030323195606.GA15904@atrey.karlin.mff.cuni.cz>
 <1048450211.1486.19.camel@phantasy.awol.org>
 <402760000.1048451441@[10.10.2.4]>
 <20030323203628.GA16025@atrey.karlin.mff.cuni.cz>
 <Pine.LNX.4.51.0303231410250.17155@skuld.mtroyal.ab.ca>
 <920000.1048456387@[10.10.2.4]> <3E7E335C.2050509@pobox.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> akpm has suggested something like this in the past.  I respectfully
> disagree.
> 
> The 2.4 kernel will not benefit from constant churn of backporting core
> kernel changes like a new scheduler.  We need to let it settle, simply
> get it stable, and concentrate on fixing key problems in 2.6.  Otherwise
> you will never have a stable 2.4 tree, and it will look suspiciously more
> and more like 2.6 as time goes by.  Constantly breaking working
> configurations and changing core behaviors is _not_ the way to go for 2.4.
> 
> I see 2.4 O(1) scheduler and similar features as _pain_ brought on the
> vendors by themselves (and their customers).

O(1) sched may be a bad example ... how about the fact that mainline VM
is totally unstable? Witness, for instance, the buffer_head stuff. Fixes
for that have been around for ages. 

The real philosophical question is "what is mainline 2.4 _for_"?
 
> Surely it is better to concentrate developer time and mindshare on making
> 2.6 sane?

Agreed, but all we're doing now is burning lots of time on backporting
stuff from 2.5 into each separate distro base, and each distro fixing
things independantly in their own tree (eg O(1) scheduler). I don't
see that as constructive ... customers will not stagnate, and I don't
see the point in 2.4 mainline doing that either. 

It's now got to the point where the testing people don't even bother
testing mainline 2.4 because they know it's horribly broken, and is not
getting fixed, so there's no point. I think that's sad. Instead, we test
umpteen different vendor kernels, and try to apply the same fixes to each
of those, which is a pain in the butt, becasue they won't merge cleanly
because the trees are so far diverged. People running non-vendor kernels
are generally running 2.4-aa or 2.4-ac, etc, etc. All burnt thrash time.

Yes, the real answer is to get 2.6 out the door, and move people onto it.
But that will take a little while ... would be nice to get some way to
alleviate the pain in the meantime.

M.

