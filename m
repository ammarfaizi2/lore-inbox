Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262811AbTCWWSy>; Sun, 23 Mar 2003 17:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263954AbTCWWSy>; Sun, 23 Mar 2003 17:18:54 -0500
Received: from brynhild.mtroyal.ab.ca ([142.109.10.24]:59056 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S262811AbTCWWSw>; Sun, 23 Mar 2003 17:18:52 -0500
Date: Sun, 23 Mar 2003 15:29:45 -0700 (MST)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: Jeff Garzik <jgarzik@pobox.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>,
       Alan Cox <alan@redhat.com>, Stephan von Krawczynski <skraw@ithnet.com>,
       szepe@pinerecords.com, arjanv@redhat.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: Ptrace hole / Linux 2.2.25
In-Reply-To: <3E7E335C.2050509@pobox.com>
Message-ID: <Pine.LNX.4.51.0303231522150.17155@skuld.mtroyal.ab.ca>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz><200303231938.h2NJcAq14927@devserv.devel.redhat.com><20030323194423.GC14750@atrey.karlin.mff.cuni.cz>
 <1048448838.1486.12.camel@phantasy.awol.org><20030323195606.GA15904@atrey.karlin.mff.cuni.cz>
 <1048450211.1486.19.camel@phantasy.awol.org><402760000.1048451441@[10.10.2.4]>
 <20030323203628.GA16025@atrey.karlin.mff.cuni.cz>
 <Pine.LNX.4.51.0303231410250.17155@skuld.mtroyal.ab.ca> <920000.1048456387@[10.10.2.4]>
 <3E7E335C.2050509@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Mar 2003, Jeff Garzik wrote:

> Martin J. Bligh wrote:
> > I think this would be valuable .. the other thing that really needs to
> > be present is a "common vendor" kernel where changes that are common
> > to most distros are merged (eg O(1) scheduler, etc). Personally, I think 
> > that's what mainline should be doing ... but if other people disagree,
> > then I, at least, would see value in a separate tree to do this.
> 
> akpm has suggested something like this in the past.  I respectfully 
> disagree.

I also disagree.  Although it would be nice, it's not practical.  What
people want is strictly fixes and security related patches, and that
is ALL I propose to want to include.  Perhaps if the vendors
want a "common vendor" patch they could maintain it? ;)

So, to that end, I have made available:
(URL is http://www.hardrock.org/kernel/current-updates/)

linux-2.4.20-updates.patch: Contains all three patches below.  For the 
        primary fixes needed in the current release kernel.

Individual patches:
linux-2.4.20-ext3.patch: Fixes for ext3 data=journal umount patch, sync-fix
        patch, and use-after-free patch from Andrew Morton <akpm@digeo.com>.

linux-2.4.20-ptrace.patch: Alan Cox relased a patch against 2.4.20 which
        did not apply cleanly (perhaps it was his -ac tree).  This will
        apply cleanly and compile under i386 to the clean 2.4.20 source
        tree.

linux-2.4.20-tg3.patch: Jeff Garzik and David S. Millers tg3 1.4c
        driver for 2.4.20.

Enjoy!

Regards
James Bourne


> 	Jeff

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************


"There are only 10 types of people in this world: those who
understand binary and those who don't."

