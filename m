Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWBOTJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWBOTJr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 14:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWBOTJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 14:09:47 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:52928
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751269AbWBOTJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 14:09:47 -0500
From: Rob Landley <rob@landley.net>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Wed, 15 Feb 2006 14:09:41 -0500
User-Agent: KMail/1.8.3
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com> <200602142155.03407.rob@landley.net> <20060215183115.GE29940@csclub.uwaterloo.ca>
In-Reply-To: <20060215183115.GE29940@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602151409.41523.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 February 2006 1:31 pm, Lennart Sorensen wrote:
> On Tue, Feb 14, 2006 at 09:55:03PM -0500, Rob Landley wrote:
> > The last gasp of the SCSI bigots is Serial Attached Scsi.  It's
> > hilarious. Electrically it's identical (they just gold-plate the
> > connectors and such so they can charge more for it).  The giveaway is
> > that you can plug a SATA drive into a SAS controller and it works on
> > "dual standard" controller firmware. Which one's going to have the unit
> > volume to be cheap and sell through its inventory to bring out new
> > generations faster?  And which one is exactly the same technology with
> > buckets of hype, slightly different firmware, and a huge markup for the
> > people who still think that because ISA sucked, its designated successor
> > PCI can't be trusted?
>
> SAS is actually a lot more complex than SATA.

This is a good thing?

> SAS drives are dual ported, so you can connect them to two controllers at
> once.

Yup.  Apparently with SAS, the controllers are far more likely to fail than 
the drives.

> Makes  
> redundant systems much simpler to build if you can connect each physical
> drive to two places at once.

Or you could use raid and get complete redundancy rather than two paths to the 
same single point of failure.  Your choice.

> They support port expanders (which SATA 
> seems to be starting to support although more limited).

If it uses a PHY then it's gig ethernet under the covers.  Each hop is a point 
to point connection, but throwing switches in there isn't exactly a new 
problem.  When demand arrives, I expect supply will catch up.

> You can run SATA drives on an SAS controller, but of course you don't get
> dual port.

I still don't see why drives are expected to be more reliable than 
controllers.

I think the most paranoid setup I've seen was six disks holding two disks 
worth of information.  A three way raid-5, mirrored.  It could lose any three 
disks out of the group, and several 4 disk combinations.  If six SATA drives 
are cheaper than two SAS drives.  (Yeah, the CRC calculation eats CPU and 
flushes your cache.  So what?)

I keep thinking there should be something more useful you could do than "hot 
spare" with extra disks in simple RAID 5, some way of dynamically scaling 
more parity info.  But it's not an area I play in much...

> You can not run SAS drives on an SATA controller however.

Only because the firmware doesn't support it.  (I.E. It's an intentional lack 
of support.)

> SATA is essentially a subset of SAS.

I was under the impression that SATA came first and SAS surrounded it with 
unnecessary extensions so they could charge more money.  But then I've 
largely ignored SAS (as has everyone else I know outside of Dell), so I can't 
claim to be an expert here...

> Len Sorensen

Rob
-- 
Never bet against the cheap plastic solution.
