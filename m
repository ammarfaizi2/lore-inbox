Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAXUSN>; Wed, 24 Jan 2001 15:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAXUSD>; Wed, 24 Jan 2001 15:18:03 -0500
Received: from md.aacisd.com ([64.23.207.34]:62738 "HELO md.aacisd.com")
	by vger.kernel.org with SMTP id <S129383AbRAXURv>;
	Wed, 24 Jan 2001 15:17:51 -0500
Message-ID: <8FED3D71D1D2D411992A009027711D67184D@md>
From: Nathan Black <NBlack@md.aacisd.com>
To: "'Tom Sightler'" <ttsig@tuxyturvy.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: No SCSI Ultra 160 with Adaptec Controller
Date: Wed, 24 Jan 2001 15:13:26 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What problem are you trying to solve, I just joined the group in hopes of
finding a solution to a problem of mine.

It sounds like they may be related.
I am trying to write to a drive(raw, blank, whatever you want to call it) on
kernel 2.4.1-pre10. I get great throughput at first, but then it slows to
about 25 MB/sec. This isn't a problem except after writing a large amount of
data, the system becomes unusable. I did not say it halts, oops, or anything
like that, just extremely slow. ps takes about 10 minutes or more to
complete.(4 tasks).

I have a compaq smart array controller 2. 

Before I upgraded the kernel( I was at 2.4.0 released). I would get an oops.
and a kernel panic/halt.
I did see that running in uniprocessor mode with NMIs turned off would let
me write without problems, but I was never sure how to fix it.

Any ideas?

-----Original Message-----
From: Tom Sightler [mailto:ttsig@tuxyturvy.com]
Sent: Wednesday, January 24, 2001 3:08 PM
To: mjacob@feral.com; Matt_Domsch@dell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: No SCSI Ultra 160 with Adaptec Controller


> Actually, aren't a number of newer drives getting upwards of 30MB/s?
>

Well, at 80MB/sec these drives are able to come in at an average of about
34MB/s across the board.

> > Therefore, you only exceed the 80MB/sec bus speed if you
> > have more than 4 disks all doing maximum I/O at the same time.  Since
the
> > PowerApp.web 100 has at most 2 disks internally, you really shouldn't
see
> > any significant performance difference.

I wouldn't dare argue that I'd get some huge performance boost, but I am
running software raid1 on multiple spindles (we have some drives attached
externally) so it should help some.
Also, this unit is doing heavy read/write of small files and the lower
latency, and
burstable transfers do help some.  I temporarily disabled that code and the
increase in IO's per second is measurable, though not earth shattering, but
I
was afraid to leave it that way because fast corrupted data is worth much
less
that only slightly slower good data.

It was really just an issue of if the code still needed to be there.
Workarounds that are put in as temporary have a tendency to never get
revisited
until someone brings them up, and on top of that they make Linux look sloppy
to
me (the same drives work correctly at Ultra160 under that other OS, or at
least appear to).  I know it
won't make a huge difference to me, but if some user has a 12 disk RAID
array
full of Quantum disks it will make a big difference to them.

Later,
Tom



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
