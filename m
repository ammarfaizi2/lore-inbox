Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131509AbRCNTfh>; Wed, 14 Mar 2001 14:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131510AbRCNTf1>; Wed, 14 Mar 2001 14:35:27 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:18941 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131509AbRCNTfR>; Wed, 14 Mar 2001 14:35:17 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103141934.f2EJY6Z10216@webber.adilger.int>
Subject: Re: magic device renumbering was -- Re: Linux 2.4.2ac20
In-Reply-To: <Pine.LNX.4.30.0103141410360.2004-100000@flowers.house.larsshack.org>
 from Lars Kellogg-Stedman at "Mar 14, 2001 02:11:57 pm"
To: Lars Kellogg-Stedman <lars@larsshack.org>
Date: Wed, 14 Mar 2001 12:34:06 -0700 (MST)
CC: Christoph Hellwig <hch@caldera.de>, John Jasen <jjasen1@umbc.edu>,
        linux-kernel@vger.kernel.org, AmNet Computers <amnet@amnet-comp.com>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars writes:
> > Put LABEL=<label set with e2label> in you fstab in place of the device name.
> 
> Which is great, for filesystems that support labels.  Unfortunately,
> this isn't universally available -- for instance, you cannot mount
> a swap partition by label or uuid, so it is not possible to completely
> isolate yourself from the problems of disk device renumbering.

There is room for a LABEL and/or UUID in the swap superblock, if you
would want to implement support for this.  I took a look once, and it
should be possible to add in a compatible way.  Of course, you can
always put swap into LVM, which also makes it (along with filesystems
other than ext2) immune from the nasty device name changes.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
