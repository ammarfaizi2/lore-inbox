Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRBNPoa>; Wed, 14 Feb 2001 10:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbRBNPoU>; Wed, 14 Feb 2001 10:44:20 -0500
Received: from hera.cwi.nl ([192.16.191.8]:34696 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129055AbRBNPoJ>;
	Wed, 14 Feb 2001 10:44:09 -0500
Date: Wed, 14 Feb 2001 16:43:59 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200102141543.QAA79054.aeb@vlet.cwi.nl>
To: michael_e_brown@dell.com
Subject: Re: block ioctl to read/write last sector
Cc: Matt_Domsch@exchange.dell.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My patch has nothing to do with partitioning.

Yes, you already said that, and I understand you very well.
My suggestion, and I have not checked the code to make sure,
but off-hand it seems to me that it should work,
is to use a partition.

> Disk with 1001 blocks. Hardware 512-byte sector size.
> The block layer uses 1024-byte soft blocksize.
> This means that, at the _end_ of the disk there is a single sector
> that represents half of a software sector.

Maybe. I think that you'll find that these blocks are
relative to the start of the partition, not relative
to the start of the disk.

So if you add a 1-block partition that contains the last
sector of the disk, all should be fine.

Andries


