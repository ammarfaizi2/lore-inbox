Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVEDDg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVEDDg4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 23:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVEDDg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 23:36:56 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:24281 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S261989AbVEDDgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 23:36:54 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: Empty partition nodes not created (was device node issues with recent mm's and udev)
To: Joe <joecool1029@gmail.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Reply-To: 7eggert@gmx.de
Date: Wed, 04 May 2005 05:36:45 +0200
References: <3ZVNP-5cq-7@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DTAgo-0002uD-F0@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe <joecool1029@gmail.com> wrote:

> Here is the partition table from fdisk, fdisk does run fine.. its just
> the fact this node is not created that threw me off before.
> 
>    Device Boot      Start         End      Blocks   Id  System
> /dev/sdb1   *           1           2       16033+   0  Empty
> /dev/sdb2   *           6        2431    19486845    b  W95 FAT32
> /dev/sdb3               3           5       24097+  83  Linux
> 
> Notice, /dev/sdb1 is a Empty partition... in /dev I only have sdb,
> sdb2, and sdb3.  No sdb1.  Any help would be appreciated.

Some vendors depend on empty partitions not showing up. That's why this
patch was introduced.

BTW: Is there a special reason you why choose "empty"?
Is this partition showing up in other systems at all?
-- 
Top 100 things you don't want the sysadmin to say:
45. Was that YOUR directory?

