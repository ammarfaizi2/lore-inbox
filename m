Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbVL2TL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbVL2TL4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 14:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVL2TL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 14:11:56 -0500
Received: from mtl.rackplans.net ([65.39.167.249]:28092 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S1750807AbVL2TLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 14:11:55 -0500
Date: Thu, 29 Dec 2005 14:11:52 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: Robert Hancock <hancockr@shaw.ca>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [solved][Re: software raid 5 broken on 2.6.14.4 sparc
In-Reply-To: <43B43020.8080804@shaw.ca>
Message-ID: <Pine.LNX.4.64.0512291410590.16975@innerfire.net>
References: <5paRd-18Z-47@gated-at.bofh.it> <43B43020.8080804@shaw.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2005, Robert Hancock wrote:

> Date: Thu, 29 Dec 2005 12:51:12 -0600
> From: Robert Hancock <hancockr@shaw.ca>
> To: linux-kernel <linux-kernel@vger.kernel.org>
> Cc: gmack@innerfire.net
> Subject: Re: software raid 5 broken on 2.6.14.4 sparc
> 
> Gerhard Mack wrote:
> > Hello,
> > 
> > I had one of 5 drives fail in my raid 5 setup and now many files are
> > unreadable..  Isn't raid 5 supposed to compensate for exactly this
> > happening?
> 
> It looks like you have multiple drives with problems here:
> 
> Here's sde unhappy:
> 
> > Dec 25 18:36:27 localhost kernel: sde: Current: sense key: Recovered Error
> > Dec 25 18:36:27 localhost kernel:     Additional sense: Recovered data -
> > recommend reassignment
> 
> sdb seems to be overheating:
> 
> > Dec 26 11:25:56 localhost kernel: sdb: Current: sense key: Recovered Error
> > Dec 26 11:25:56 localhost kernel:     Additional sense: Warning - specified
> > temperature exceeded
> 
> Now sdf is unhappy..
> 
> > Dec 29 06:26:07 localhost kernel: sdf: Current: sense key: Hardware Error
> > Dec 29 06:26:07 localhost kernel:     Additional sense: Mechanical
> > positioning error
> > Dec 29 06:26:07 localhost kernel: end_request: I/O error, dev sdf, sector
> > 9664
> > Dec 29 06:26:07 localhost kernel: raid5: Disk failure on sdf, disabling
> > device. Operation continuing on 4 devices
> 
> > Dec 29 06:26:07 localhost kernel: RAID5 conf printout:
> > Dec 29 06:26:07 localhost kernel:  --- rd:6 wd:4 fd:2
> > Dec 29 06:26:07 localhost kernel:  disk 0, o:1, dev:sdc
> > Dec 29 06:26:07 localhost kernel:  disk 1, o:1, dev:sdd
> > Dec 29 06:26:07 localhost kernel:  disk 2, o:1, dev:sde
> > Dec 29 06:26:07 localhost kernel:  disk 3, o:0, dev:sdf
> > Dec 29 06:26:07 localhost kernel:  disk 4, o:1, dev:sdg
> > Dec 29 06:26:07 localhost kernel: RAID5 conf printout:
> > Dec 29 06:26:07 localhost kernel:  --- rd:6 wd:4 fd:2
> > Dec 29 06:26:07 localhost kernel:  disk 0, o:1, dev:sdc
> > Dec 29 06:26:07 localhost kernel:  disk 1, o:1, dev:sdd
> > Dec 29 06:26:07 localhost kernel:  disk 2, o:1, dev:sde
> > Dec 29 06:26:07 localhost kernel:  disk 4, o:1, dev:sdg
> > Dec 29 06:26:07 localhost kernel: Buffer I/O error on device md0, logical
> > block 6040
> > Dec 29 06:26:07 localhost kernel: lost page write due to I/O error on md0
> > Dec 29 06:26:07 localhost kernel: REISERFS: abort (device md0): Journal
> > write error in flush_commit_list
> > Dec 29 06:26:07 localhost kernel: REISERFS: Aborting journal for filesystem
> > on md0
> > Dec 29 07:16:56 localhost kernel: ReiserFS: md0: warning: clm-6006: writing
> > inode 2996 on readonly FS
> > Dec 29 07:16:56 localhost kernel: ReiserFS: md0: warning: clm-6006: writing
> > inode 2996 on readonly FS
> > Dec 29 07:17:28 localhost kernel: Buffer I/O error on device md0, logical
> > block 5052984
> > Dec 29 07:17:28 localhost kernel: lost page write due to I/O error on md0
> 
> I don't know if this completely explains the failure, but it seems you have
> bigger problems than one bad drive, and RAID5 cannot handle multiple drive
> failures.
> 
Ahah.. I knew about sdb.. overheating (it's not part of the array) I 
missed sde .. that one explains it.

	Thanks, 
	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
