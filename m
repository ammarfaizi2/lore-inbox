Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319182AbSIJO7r>; Tue, 10 Sep 2002 10:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319186AbSIJO7r>; Tue, 10 Sep 2002 10:59:47 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:13822
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319182AbSIJO7q>; Tue, 10 Sep 2002 10:59:46 -0400
Subject: RE: [RFC] Multi-path IO in 2.5/2.6 ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45B36A38D959B44CB032DA427A6E10640167D03B@cceexc18.americas.cpqcorp.net>
References: <45B36A38D959B44CB032DA427A6E10640167D03B@cceexc18.americas.cpqcorp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 10 Sep 2002 16:05:54 +0100
Message-Id: <1031670354.31549.80.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-10 at 15:43, Cameron, Steve wrote:
> Well, the BIOS can do it if it has one working path, right?
> (I think the md information is at the end of the partition,)

Yes. A good PC bios will spot an hda boot fail, and try hdc. Good PC
bioses are alas slightly hard to find nowdays. In that set up raid1
works very well. Multipath is obviously a lot more complicated.

> lilo and grub as they stand today, and anaconda (et al) as it 
> stands today, cannot do it.  They can do RAID1 md devices only.  
> lilo for example will complain if you try to run it with 
> boot=/dev/md0, and /dev/md0 is not a RAID1 device.   At least 

It relies on the BIOS to do the data loading off the md0. In your
scenario you would tell it the boot is on /dev/sdfoo where that is the
primary path. I guess the ugly approach would be to add lilo/grub
entries for booting off either path as two seperate kernel entries.

> bit, but so far, I am unsuccessful.  I think grub cannot even do
> RAID1.

Works for me
 
> I agree in principle, the initrd scripts can insmod multipath.o
> to get things rolling, etc.  The trouble comes from lilo, grub 
> and install time configuration.

Yes. 

