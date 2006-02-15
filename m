Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWBOTum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWBOTum (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 14:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWBOTum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 14:50:42 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:14236 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750992AbWBOTul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 14:50:41 -0500
Date: Wed, 15 Feb 2006 14:50:39 -0500
To: Rob Landley <rob@landley.net>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060215195039.GS29938@csclub.uwaterloo.ca>
References: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com> <200602142155.03407.rob@landley.net> <20060215183115.GE29940@csclub.uwaterloo.ca> <200602151409.41523.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602151409.41523.rob@landley.net>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 02:09:41PM -0500, Rob Landley wrote:
> This is a good thing?

If you need the added features, then I suppose so.  I certainly don't
have a need for scsi on my machine at home.  Nor do I need SAS.  SATA on
the other hand suits me just fine.

> Yup.  Apparently with SAS, the controllers are far more likely to fail than 
> the drives.

Don't know, but it sure is easier to setup two complete systems sharing
drives if they have two ports.  And cables can fail too.  That is not
that unusual.  And just because drives are more likely to fail doesn't
mean you shouldn't consider that a controller can fail.

> Or you could use raid and get complete redundancy rather than two paths to the 
> same single point of failure.  Your choice.

How do you share a raid between two systems?  I know you probably can't
make every redundant, but you can try. :)

I would expect a raid of drives handled by different systems being a
possible setup.  I remember systems setup that way with scsi in the
past, although they had the major flaw that the raid had a single scsi
bus connected to two machines at once.  If the bus went wrong you still
lost everything.  With SAS that isn't a problem anymore.

> If it uses a PHY then it's gig ethernet under the covers.  Each hop is a point 
> to point connection, but throwing switches in there isn't exactly a new 
> problem.  When demand arrives, I expect supply will catch up.

So they are 1.5 and 3 Gbit ethernet?  Well I guess if you consider
anything that runs a serial stream at a certain speed to be gigabit.  Of
course gigabit ethernet on twisted pair runs much lower clock rates and
uses 4 parallel streams.

> I still don't see why drives are expected to be more reliable than 
> controllers.

They are not, that is why you have raid.  But controllers can fail too,
as can cables.  So you want two cables per drive and two controllers
too.

> I think the most paranoid setup I've seen was six disks holding two disks 
> worth of information.  A three way raid-5, mirrored.  It could lose any three 
> disks out of the group, and several 4 disk combinations.  If six SATA drives 
> are cheaper than two SAS drives.  (Yeah, the CRC calculation eats CPU and 
> flushes your cache.  So what?)
> 
> I keep thinking there should be something more useful you could do than "hot 
> spare" with extra disks in simple RAID 5, some way of dynamically scaling 
> more parity info.  But it's not an area I play in much...

It is not an alternative to raid.  It is redundancy for different parts
of the system.

> Only because the firmware doesn't support it.  (I.E. It's an intentional lack 
> of support.)

Well maybe you can convince the sata controller makers to add whatever
they are missing.  Although then it would be an SAS controller I guess.
And sure I guess you could dumb down the firmware on the SAS drive, but
why pay more for it to use it as SATA?

> I was under the impression that SATA came first and SAS surrounded it with 
> unnecessary extensions so they could charge more money.  But then I've 
> largely ignored SAS (as has everyone else I know outside of Dell), so I can't 
> claim to be an expert here...

Looks like adaptec, LSI, buslogic, and a few others are taking SAS
seriously.  Even just having a standard for external connections is
something large raid setups require that SATA doesn't have.

Len Sorensen
