Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131577AbRCSUeD>; Mon, 19 Mar 2001 15:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131578AbRCSUdo>; Mon, 19 Mar 2001 15:33:44 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:22898 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S131577AbRCSUdh>; Mon, 19 Mar 2001 15:33:37 -0500
Date: Mon, 19 Mar 2001 15:32:31 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <3AB65F14.26628BEF@coplanar.net>
Message-ID: <Pine.LNX.4.10.10103191448010.5246-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I have an IBM DTLA 307030 (ATA 100 / UDMA 5) on an 815e board (Asus CUSL2), which has a PIIX4 controller.
> > > ...
> > > My problem is that (according to hdparm -t), I never get a better transfer rate than approximately 15.8 Mb/sec....
> >
> > 15MB/s for hdparm is about right.

it's definitely not right: this disk sustains around 35 MB/s.

> Yes, since hdparm -t measures *SUSTAINED* transfers... the actual "head rate" of data reads from
> disk surface.  Only if you read *only* data that is alread in harddrive's cache will you get a speed
> close to the UDMA mode of the drive/controller.  The cache is around 1Mbyte, so for a split-second
> re-read of some data....

nonsequitur: the controller and disk are both quite capable of 
sustaining 20-35 MB/s (depending on zone.)  here's hdparm output
for a disk of the same rpm and density as the DTLA's:

 Timing buffer-cache reads:   128 MB in  1.07 seconds =119.63 MB/sec
 Timing buffered disk reads:  64 MB in  2.02 seconds = 31.68 MB/sec

(maxtor dm+45, hpt366 controller)
regards, mark hahn.

