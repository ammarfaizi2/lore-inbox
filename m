Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129500AbRBMWzV>; Tue, 13 Feb 2001 17:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129496AbRBMWzL>; Tue, 13 Feb 2001 17:55:11 -0500
Received: from hera.cwi.nl ([192.16.191.8]:14495 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129246AbRBMWzC>;
	Tue, 13 Feb 2001 17:55:02 -0500
Date: Tue, 13 Feb 2001 23:54:34 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200102132254.XAA98078.aeb@vlet.cwi.nl>
To: michael_e_brown@dell.com
Subject: Re: block ioctl to read/write last sector
Cc: Matt_Domsch@exchange.dell.com, freitag@alancoxonachip.com,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   The block device uses 1K blocksize, and will prevent userspace from
> seeing the odd-block at the end of the disk, if the disk is odd-size.
>
>   IA-64 architecture defines a new partitioning scheme where there is a
> backup of the partition table header in the last sector of the disk. While
> we can read and write to this sector in the kernel partition code, we have
> no way for userspace to update this partition block.

Are you sure?

There may be no easy, convenient way right now, but
(without having checked anything) it seems to me
that you can, also today.
Look at the addpart utility in the util-linux package.
It will allow you to add a partition disjoint from
previously existing partitions.
And since a partition can start on an odd sector,
this should allow you to also read the last sector.

Do I overlook something?

Anyway, an ioctl just to read the last sector is too silly.
An ioctl to change the blocksize is more reasonable.
And I expect that this fixed blocksize will go soon.

Andries

[Sorry if precisely the same discussion has happened earlier -
I have no memory.]
