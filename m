Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbTJEJA1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 05:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTJEJA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 05:00:27 -0400
Received: from tartutest.cyber.ee ([193.40.6.70]:28424 "EHLO
	tartutest.cyber.ee") by vger.kernel.org with ESMTP id S262798AbTJEJA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 05:00:26 -0400
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: rfc: test whether a device has a partition table
In-Reply-To: <bkt3qe$imh$1@build.pdx.osdl.net>
User-Agent: tin/1.7.1-20030907 ("Sandray") (UNIX) (Linux/2.4.23-pre5 (i686))
Message-Id: <E1A64kY-0002Qx-Ue@rhn.tartu-labor>
Date: Sun, 05 Oct 2003 12:00:22 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LT> If you have unusual cases (and let's face it, they don't much happen - we
LT> have traditionally had _very_ few problems with getting things partitioned)
LT> then you should be able to override them from user space and have user space
LT> be able to tell the kernel about special partitions. 
LT> 
LT> And hey, surprise surprise, you can do exactly that.
LT> 
LT> Also, surprise surprise, pretty much nobody actually does it. Because the
LT> defaults are so sane.

Well, I have had difficulties with this twice during last year. Both
times it was a partitioned CD. One was a Mac CD (IIRC), the other was an
IRIX 6.2 installation CD with SGI disklabel and EFS partition. I got the
first to work but never had success with the other (probably a user
error). fdisk found the partitions fine but gave hints of a different
blocksize (2048 vs 512). I tried to set up the partition with devmapper
(dmsetup create ...) but I could never mount the resulting partitions.
Perhaps it was a EFS filesystem driver blocksize bug, perhaps something
with my manual setup.

But I would not say the defaults have been sufficient for _me_.

-- 
Meelis Roos (mroos@linux.ee)
