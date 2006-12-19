Return-Path: <linux-kernel-owner+w=401wt.eu-S1752863AbWLSPlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbWLSPlb (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 10:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbWLSPla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 10:41:30 -0500
Received: from main.gmane.org ([80.91.229.2]:45096 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752749AbWLSPla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 10:41:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Wiebe Cazemier <halfgaar@gmx.net>
Subject: Re: Software RAID1 (with non-identical discs) performance
Date: Tue, 19 Dec 2006 16:40:46 +0100
Message-ID: <em915v$7h6$1@sea.gmane.org>
References: <em0pdq$r7o$2@sea.gmane.org> <4586DF1D.6040501@cfl.rr.com> <3960.4587f434.9e684@altium.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cc503261-a.eelde1.dr.home.nl
User-Agent: KNode/0.10.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 December 2006 15:16, Dick Streefland wrote:

> An easy way to clone a partition table is:
> 
>   sfdisk -d /dev/sdX | sfdisk /dev/sdY
> 

And with one Maxtor 250 GB and one Seagate 250 GB, will that work? It can go
wrong on two accounts; the geometry issue I desbribed (which, I understand,
shouldn't be an issue at all), and if you're trying to clone the partition
table on a smaller disk. The latter would be fixed by leaving some unpartioned
space available.

This is something I'm going to experiment with on several disks I have.

On a sidenote, can you use this command, along with "dd if=oldpartition
of=newpartition" to clone an old disk to a new one (including NTFS/FAT
partitions for example), like Seagate disk wizzard does, and have a working
bootable system on the new disk? Or, can that even be done by dd-ing the
entire disk, and not individual partitions? I can remember G4u being
uncomfortable with that.

