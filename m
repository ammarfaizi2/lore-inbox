Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTIYRGE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTIYRGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:06:04 -0400
Received: from [170.180.5.203] ([170.180.5.203]:3081 "EHLO
	e151000n0.edmonson.k12.ky.us") by vger.kernel.org with ESMTP
	id S261686AbTIYRGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:06:02 -0400
Message-ID: <9A8F8D67DC8ED311BF3E0008C7B9A0ADBAA877@E151000N0>
From: "Norris, Brent" <bnorris@Edmonson.k12.ky.us>
To: "'Andreas Dilger'" <adilger@clusterfs.com>,
       "Norris, Brent" <bnorris@Edmonson.k12.ky.us>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: 128G Limit in Reiserfs? Or the Kernel? Or something else?
Date: Thu, 25 Sep 2003 12:02:21 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just FYI, we have lots of ext3 filesystems that are 2TB in 
> size, so I don't think it is an ext3 problem.  What could be 
> happening though is that when you mke2fs the filesystem with 
> your IDE problem it wraps writes over 128GB back to zero and 
> overwrites the superblock so mount doesn't see the ext3 
> superblock anymore.

Great!!! Nice info.  That goes a long way toward explaining why it wouldn't
mount.  It was so weird since mkfs.ext3 didn't error or anything, it just
finished normally, but then nothing would mount the drive.  Thanks again.

Brent
