Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263673AbTEEQb5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263674AbTEEQbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:31:25 -0400
Received: from popmail.goshen.edu ([199.8.232.22]:47811 "EHLO mail.goshen.edu")
	by vger.kernel.org with ESMTP id S263673AbTEEQad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:30:33 -0400
Subject: Re: partitions in meta devices
From: Ezra Nugroho <ezran@goshen.edu>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3EB693B1.9020505@gmx.net>
References: <1052153060.29588.196.camel@ezran.goshen.edu> 
	<3EB693B1.9020505@gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 05 May 2003 11:57:14 -0500
Message-Id: <1052153834.29676.219.camel@ezran.goshen.edu>
Mime-Version: 1.0
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2003-05-05 at 11:39, Carl-Daniel Hailfinger wrote:
> Ezra Nugroho wrote:
> > I am curious if partitioning meta devices is allowed or not.
> > 
> > I just created a software raid array, md0 with 240G logical size.
> > I want to partition that into two, 100G and the rest.
> > 
> > I used fdisk to create the partitions, and it worked, result:
> > 
> > bangalore exports # fdisk /dev/md0
> > 
> > Command (m for help): p
> > 
> > Disk /dev/md0: 247.0 GB, 247044636672 bytes
> > 2 heads, 4 sectors/track, 60313632 cylinders
> > Units = cylinders of 8 * 512 = 4096 bytes
> > 
> >     Device Boot    Start       End    Blocks   Id  System
> > /dev/md0p1             1  24414064  97656254   83  Linux
> > /dev/md0p2      24414065  60313632 143598272   83  Linux
> > 
> > 
> > however, I couldn't create any file system for them, or mount them.
> > /dev/md0px just don't exist.
> > 
> > Do I need to partition the drives first before creating the raids?
> > I use devfs instead of file based /dev
> 
> Please reboot after partitioning.

I did. Nothing changed. fdisk reported the changes still.


