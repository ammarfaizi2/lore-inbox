Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266492AbUHILpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266492AbUHILpU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 07:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266494AbUHILpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 07:45:19 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:2792 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S266534AbUHILot
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 07:44:49 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Mon, 9 Aug 2004 07:44:46 -0400
User-Agent: KMail/1.6.82
Cc: Thomas Richter <thor@math.tu-berlin.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>
References: <200408090813.KAA26594@cleopatra.math.tu-berlin.de>
In-Reply-To: <200408090813.KAA26594@cleopatra.math.tu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200408090744.46407.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.56.17] at Mon, 9 Aug 2004 06:44:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 August 2004 04:13, Thomas Richter wrote:
>Hi Jörg,
>
>> >From the > 20 platforms that libscg provides abstractions from,
>> > _most_
>>
>> platforms do not allow the "UNIX" /dev/something method to work
>> with Generic SCSI:
>>
>> -	AmigaOS
>
>/* snip */
>
>I've been following this discussion for quite a while now, fairly
> interested, mainly as a user of cdrecord and linux, you here you're
> going a bit over the edge. Having had my home at AmigaOs for quite
> a while, I should possibly add my two cents that your above
> argument is pretty much "bogus".
>
>For first, there is nothing like a CAM interface on Amiga, neither
> on MacOs. MacOs implements (or at least, up to Os 9) implemented
> SCSI by its own "scsi-manager" interface which is "all but CAM". It
> is more or less a pretty bad abstraction of a pretty bad
> (hand-rolled) SCSI chipset Apple choose to implement in the early
> Mac's, not much more.
>
>As for AmigaOs, there's also nothing like a standardized SCSI
> interface. Instead, you'd had to talk to the device driver ("kinna
> like /dev/hda") directly using HD_SCSICMD, which is closer to the
> proposed Linux device driver interface than the "dev" setting
> you're putting forward. There's no /dev, and thus there's no
> /dev/hda, but there's possibly a scsi.device or an oktagon.device
> you had to talk to, and that's much closer to the Linux /dev/hdx
> raw device interface than to CAM.
>
>If you'd like to have an internal CAM layer, then this is possibly a
> good idea to integrate cdrecord into various operating systems (if
> you like to count AmigaOs as one), but as user frontend, this is a
> pretty bad idea. One should talk to users in a way that integrates
> into the host environment, and not in some kind of standard
> specified environment. After all, standards are made to make things
> simpler - instead cdrecord makes things harder by trying to follow
> standards that are not the standards of the host.
>
>And please, don't tell that I'm "Linux centric". I've much more
> ideas about the internal wiring of other operating systems than
> Linux.
>
>> These are the platforms where /dev/something could work:
>
>+ AmigaOs, if you prefer to count.
>
>But, as I said, this is a non-argument. The tools should integrate
> into the environment, and keeping things managable for the user
> should be the goal.
>
>Whether Linux should choose CAM as interface is another question -
> with ATAPI much more popular than SCSI nowadays, one might consider
> this of less importance, possibly.
>
>Sorry, just my 0.02 Euro.
>
>So long,
>	Thomas
>
And, FWIW, let me assure you all that Thomas Richter does indeed 
understand what he is talking about.  He almost single-handedly 
brought the still broken AmigaOS3.1 into the modern age of being able 
to use hard drives of any size.  His work on the amiga's long after 
commode door took the money and ran to the bahamas will be forever 
appreciated by the remaining users of this once fine machine.  

Unforch, that leaves me out as a failing hard drive wrecked quite a 
bit of my once awesome system.  And thats when I discovered that the 
backup programs, regardless of what you paid for it, were worthless 
as they were not able to backup any file with an open lock on it, eg 
anything that was running.  Rather hard to restore the system when 
the system itself is missing from the backups.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
