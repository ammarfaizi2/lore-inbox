Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129072AbRBABPB>; Wed, 31 Jan 2001 20:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129079AbRBABOv>; Wed, 31 Jan 2001 20:14:51 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:36851 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129072AbRBABOn>; Wed, 31 Jan 2001 20:14:43 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102010114.f111E4213892@webber.adilger.net>
Subject: Re: Any reason why we can't auto-start LVM (vg's) in the kernel?
In-Reply-To: <033201c08be7$d8e22760$160912ac@stcostlnds2zxj> from List User at
 "Jan 31, 2001 06:42:20 pm"
To: List User <lists@chaven.com>
Date: Wed, 31 Jan 2001 18:14:04 -0700 (MST)
CC: Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve, writes:
> Is there any reason why we can't auto-detect/bring up volume-groups in the
> kernel instead of creating a ramdisk volume to do a vgscan and then mount a
> rootlv?

Um, yes, because it won't work.  The user tools do the I/O of LVM state
information to the disk.  The kernel LVM module has no concept of how
LVM information is stored on disk.

> Just trying to see if there is a way (or would make sense) to skip the
> ramdisk stage in mounting a root logical volume.

Need to re-write (or at least seriously enhance) the LVM kernel code to do
this.  Sorry.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
