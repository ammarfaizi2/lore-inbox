Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266246AbUHBERp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266246AbUHBERp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 00:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUHBERp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 00:17:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37333 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266246AbUHBER1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 00:17:27 -0400
Date: Mon, 2 Aug 2004 15:13:36 +1000
From: Nathan Scott <nathans@sgi.com>
To: Stormy Waters <stormy420waters@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.4.26 XFS file space reporting bug
Message-ID: <20040802051336.GC21646@frodo>
References: <20040730224245.56872.qmail@web61207.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730224245.56872.qmail@web61207.mail.yahoo.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 03:42:45PM -0700, Stormy Waters wrote:
> Hi people,
> 
> I think I found a bug in the 2.4.26 kernel,  I have a

I suspect this may be pilot error...

> logical partition (see below) that is partitioned for
> 20 gig's.  when i use df it reports it as 278MB. 
> Which is not even close to 20gb.  This Machine is

Did you run mkfs.xfs on this device right after it was
partitioned?  mkfs.xfs is only going to use as much as
the block layer says it can, so if the kernels in-core
partition table was out of whack, mkfs will be told an
out-of-date device size.

If this may be the case, try rebooting and then see if
mkfs.xfs sees the updated device size.  Also xfs_info /
"mkfs.xfs -fN" output would be useful here, along with
the contents of /proc/partitions.

cheers.

-- 
Nathan
