Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263492AbTDCTJp 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 14:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263489AbTDCTJH 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 14:09:07 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:16778 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id S263485AbTDCTIm 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 14:08:42 -0500
Date: Thu, 3 Apr 2003 21:20:29 +0200 (CEST)
From: Stephan van Hienen <raid@a2000.nu>
To: "Peter L. Ashford" <ashford@sdsc.edu>
cc: Jonathan Vardy <jonathan@explainerdc.com>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: RAID 5 performance problems
In-Reply-To: <Pine.GSO.4.30.0304030858080.20118-100000@multivac.sdsc.edu>
Message-ID: <Pine.LNX.4.53.0304032104070.3085@ddx.a2000.nu>
References: <Pine.GSO.4.30.0304030858080.20118-100000@multivac.sdsc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Apr 2003, Peter L. Ashford wrote:

> 1.  Disk controllers (get off the motherboard IDE, dump the FastTrak, use
> 	Master only)
fasttrak is nothing more than an ultra version with an special bios
if you don't use this raid bios, there is no difference (for linux)

> 2.  I/O bandwidth (multiple PCI buses)
sure this helps, but he is not even getting near the pci bus
limitations...

> 3.  Memory bandwidth (switch to something like a P4)
my old dual p2-500 had didn't have this problem
(i'm 'the friend' look at the last benchmark (5*80gb raid5)

> 4.  Disks (this is where your friend's dual Xeon system is)
eh, disks are not really his problem
(he is getting 30mb/sec with hdparm for each disk, but getting same result
for his /dev/md0)

>
> Your network probably belongs in this list somewhere, but you didn't
he didn't test any network performance yet, this is just plain disk
benchmarking...


> 26MB/S (there should be almost no difference for the BB drives).  My
> suggestion would be to remove the FastTrak, and get two Ultra-100s and an
> Ultra-133 (or one Ultra-100 and two Ultra-133s).  Use one disk per channel
there is absolutly no performance difference between an fasttrak-100 and
an ultra-100

here benchmark from my system with an fasttrak-tx4 (same card jonathan
has) with WD1800BB :

/dev/hde:
 Timing buffer-cache reads:   128 MB in  0.28 seconds =457.14 MB/sec
 Timing buffered disk reads:  64 MB in  1.37 seconds = 46.72 MB/sec

WD1800BB on onboard ultra100 controller :

/dev/hdo:
 Timing buffer-cache reads:   128 MB in  0.28 seconds =457.14 MB/sec
 Timing buffered disk reads:  64 MB in  1.58 seconds = 40.51 MB/sec

WD1800BB on onboard ultra33 controller :

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.28 seconds =457.14 MB/sec
 Timing buffered disk reads:  64 MB in  2.55 seconds = 25.10 MB/sec

> > His raid:
>
> <SNIP>
>
> 99MB/S block write, 178MB/S block read
>
> This MUST have had a better disk controller system AND multiple PCI buses.
> The limit of one PCI bus (32-bit/33MHz, as used by the Promise
> controllers) is 133MB/S, and they are exceeding that.
correct, 3 pci busses

but my old system was only 1 pci bus (same mainbord Jonathan is using)
but was getting way higher performance (his raid is getting lower
performance than an single disk)
with only 150mhz more per cpu


