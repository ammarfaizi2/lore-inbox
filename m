Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbTEETDg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 15:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbTEETDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 15:03:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35782 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261222AbTEETDf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 15:03:35 -0400
Date: Mon, 5 May 2003 20:16:04 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Ezra Nugroho <ezran@goshen.edu>, linux-kernel@vger.kernel.org
Subject: Re: partitions in meta devices
Message-ID: <20030505191604.GC10374@parcelfarce.linux.theplanet.co.uk>
References: <1052153060.29588.196.camel@ezran.goshen.edu> <3EB693B1.9020505@gmx.net> <1052153834.29676.219.camel@ezran.goshen.edu> <3EB69883.8090609@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB69883.8090609@gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 06:59:47PM +0200, Carl-Daniel Hailfinger wrote:
 
> OK. Maybe I wasn't clear enough.
> 1. Partition a drive
> 2. Reboot
> 3. Now the kernel should see the partitions and let you create file
> systems on them.
> 
> You rebooted and fdisk sees the partitions now. Fine. Please try to
> mke2fs /dev/md0p1
> That should work. If it doesn't, devfs could be the problem.

	No, it should not.  And devfs, for once, has nothing to do with it.
RAID devices (md*) have _one_ (1) minor allocated to each.  Consequently,
they could not be partitioned by any kernel - there is no device numbers
to be assigned to their partitions.
 
> Could you please tell us which kernel version you're using?

	What would be much more interesting, which kernel are _you_ using
and what device numbers, in your experience, do these partitions get?
