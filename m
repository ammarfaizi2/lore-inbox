Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129786AbRAXUJM>; Wed, 24 Jan 2001 15:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131212AbRAXUJC>; Wed, 24 Jan 2001 15:09:02 -0500
Received: from [63.95.13.242] ([63.95.13.242]:24595 "EHLO
	zso-powerapp-01.zeusinc.com") by vger.kernel.org with ESMTP
	id <S129786AbRAXUIs>; Wed, 24 Jan 2001 15:08:48 -0500
Message-ID: <004901c08641$54d86d40$1a040a0a@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: <mjacob@feral.com>, <Matt_Domsch@dell.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.BSF.4.21.0101232041310.5712-100000@beppo.feral.com>
Subject: Re: No SCSI Ultra 160 with Adaptec Controller
Date: Wed, 24 Jan 2001 15:07:50 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
