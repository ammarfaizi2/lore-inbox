Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314366AbSDRSL7>; Thu, 18 Apr 2002 14:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314367AbSDRSL6>; Thu, 18 Apr 2002 14:11:58 -0400
Received: from ip68-7-112-74.sd.sd.cox.net ([68.7.112.74]:50445 "EHLO
	clpanic.kennet.coplanar.net") by vger.kernel.org with ESMTP
	id <S314366AbSDRSL5>; Thu, 18 Apr 2002 14:11:57 -0400
Message-ID: <006e01c1e704$805e1760$7e0aa8c0@bridge>
From: "Jeremy Jackson" <jerj@coplanar.net>
To: "Kent Borg" <kentborg@borg.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20020418110558.A16135@borg.org>
Subject: Re: Versioning File Systems?
Date: Thu, 18 Apr 2002 11:11:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the RPM case, where the RPM db can be out of sync
with the filesystem if the rpm command is interrupted
(not to mention db corruption), simply use LVM or EVMS
snapshot of fs before doing anything.  Haven't tried yet, but
working towards this:

eg:

init 1 ; go to single user mode
; initiate snapshot of /, /usr, /var etc - everything rpm touches
rpm -Fvh * ;
; oops power cable came out in middle
; restore snapshot to be live version (how?)
init 3 ; go back about your business, nothing to see here.

Jeremy

----- Original Message -----
From: "Kent Borg" <kentborg@borg.org>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, April 18, 2002 8:05 AM
Subject: Versioning File Systems?


> I just read an article mentioned on Slashdot,
> <http://www.sigmaxi.org/amsci/Issues/Comsci02/Compsci2002-05.html>.
>
> It is a fascinating short summary of the history of hard disks (they
> still use the same fundamental design as the very first one) and an
> update on current technology (disks are no longer aluminum).  It also
> looks at today's 120 gigabyte disk and muses over the question of how
> we might ever put an imagined 120 terabyte disk to use.  And the got
> me thinking various thoughts, one turns into a question for this list:
> It there any work going on to make a versioning file system?
>
> I remember in VMS that I could accumulate "myfile.txt;1",
> "myfilw.txt;2", etc., until the local admin got pissed at me for using
> up all the disk space with my several megabytes of redundant files.
>
> It is time for Linux to start figuring out ways to use all the disk
> space that is on the horizon!  In a few weeks the sweet spot will be
> to buy a pair of 80 GB disks.  Disks are outpacing even Red Hat's
> "everything" install.
>
> Seriously, I have a server in the basement with a pair of 60 GB RAID 1
> disks the protect me against likely hardware failure, but they don't
> protect me against: "# rm rf /*".  They don't even let me easily back
> out a bad RPM from Red Hat.
>
> I guess I am suggesting the (more constructive) discussions over
> desirable Bitkeeper and CVS features consider what it would mean for a
> filesystem to absorb some of the key underlying features of each.
>
> As a first crack, I am imagining a file system that records every (or
> nearly every) change to every file with time stamps and sequence
> numbering.  I don't know what all the primitives would be.  It
> obviously seems much of making sense of it all would have to happen in
> userland.  Making this too powerful almost brings up some science
> fiction problems of time travel through parallel universes, but I
> think it could be kept grounded by looking at it as a powerful version
> of existing backup systems: they don't have such problems because they
> are too cumbersome for them to arise very often.
>
>
> -kb, the Kent who thinks his journaled filesystem on redundant disks
> next needs a better memory.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

