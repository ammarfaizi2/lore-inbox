Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRAWEst>; Mon, 22 Jan 2001 23:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129835AbRAWEsj>; Mon, 22 Jan 2001 23:48:39 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:35833 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129444AbRAWEsc>; Mon, 22 Jan 2001 23:48:32 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101230447.f0N4lpf23686@webber.adilger.net>
Subject: Re: Partition IDs in the New World TM
In-Reply-To: <94ig3i$4lg$1@cesium.transmeta.com> "from H. Peter Anvin at Jan
 22, 2001 03:35:14 pm"
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 22 Jan 2001 21:47:51 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> We have:
> 
>    0x82 - Linux swap
>    0x83 - Linux filesystem
>    0x85 - Linux extended partition (yes, this one does matter!)
> 
> There seems to be some value in having a different value for swap.  It
> lets an automatic program find a partition that does not contain data.

What would be wrong with changing the kernel to skip the first page of
swap, and allowing us to put a signature there?  This would be really
useful for systems that mount ext2 filesystems by LABEL or UUID.  With
the exception of swap, you currently don't need to care about what disk
a filesystem is on.  Of course, LVM also fixes this, but not everyone
runs LVM.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
