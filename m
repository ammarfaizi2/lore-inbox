Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTLPVLD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 16:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTLPVLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 16:11:02 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:13837
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262344AbTLPVK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 16:10:58 -0500
Date: Tue, 16 Dec 2003 13:04:12 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: jw schultz <jw@pegasys.ws>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: raid0 slower than devices it is assembled of?
In-Reply-To: <Pine.LNX.4.10.10312161246340.2113-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.10.10312161303140.2113-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/secd . -T

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     2018   4096    1  244.7 53.6% 8.847 2.26% 88.04 41.7% 5.594 7.16%
   .     2018   4096    2  281.6 65.6% 11.04 3.53% 89.86 69.5% 6.645 9.78%
   .     2018   4096    4  235.6 64.3% 13.91 4.45% 88.26 96.2% 7.647 12.7%
   .     2018   4096    8  231.2 68.0% 15.91 5.34% 85.59 105.% 7.557 10.3%

Two channel, Six drives, three per channel.

U320 with 15K U160 drives in a soft Raid 0.

Andre Hedrick
LAD Storage Consulting Group

On Tue, 16 Dec 2003, Andre Hedrick wrote:

> 
> Helge,
> 
> Reads you may gain on writes only if all devices are on single ended mode.
> Both pATA and pSCSI suck wind in writes, pSCSI should smoke pATA on reads.
> It is all a matter of the physical protocol on the wire.
> 
> Only in SATA/SAS will you even reach close to ideal world.
> 
> Cheers,
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> On Tue, 16 Dec 2003, Helge Hafting wrote:
> 
> > jw schultz wrote:
> > 
> > > No Linux [R]AID improves sequential performance.  How would
> > > reading 65KB from two disks in alternation be faster than
> > > reading continuously from one disk?
> > > 
> > Raid-0 is ideally N times faster than a single disk, when
> > you have N disks.  Because you can read continuously from N
> > disks instead of from 1, thereby N-doubling the bandwith.
> > 
> > Wether the current drivers manages that is of course another story.
> > 
> > Helge Hafting
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

