Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137178AbREKRDv>; Fri, 11 May 2001 13:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137177AbREKRDc>; Fri, 11 May 2001 13:03:32 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:22523 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S137176AbREKRDW>; Fri, 11 May 2001 13:03:22 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105111702.f4BH2mal016240@webber.adilger.int>
Subject: Re: LVM 1.0 release decision
In-Reply-To: <E14yDyI-0000yE-00@the-village.bc.nu> "from Alan Cox at May 11,
 2001 03:32:46 pm"
To: Linux LVM Development list <lvm-devel@sistina.com>
Date: Fri, 11 May 2001 11:02:48 -0600 (MDT)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan writes (re LVM):
> Please fix the binary incompatibility in the on disk format between the
> current code and your new release _before_ you do that. The last patches
> I was sent would have screwed every 64bit LVM user.
> 
> A new format is fine but import old ones properly. And if you do a new format
> stop using kdev_t on disk - it will change size soon

Actually, there is no need to store kdev_t on disk at all, nor is there a
need to store device name.  By the time you have located the device, you
don't need that information any more.  I think that stuff is just a hold
over from when in-core and on-disk data was the same, and should be removed.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
