Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVIDN0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVIDN0t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 09:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVIDN0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 09:26:49 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:46995 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1750815AbVIDN0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 09:26:48 -0400
Date: Sun, 4 Sep 2005 15:26:47 +0200
From: Sander <sander@humilis.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20050904132647.GA30276@favonius>
Reply-To: sander@humilis.net
References: <20050902003915.GI3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050902003915.GI3657@stusta.de>
X-Uptime: 14:54:36 up 29 days, 19 min, 28 users,  load average: 0.02, 0.07, 0.07
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote (ao):
> 4Kb kernel stacks are the future on i386, and it seems the problems it
> initially caused are now sorted out.
> 
> Does anyone knows about any currently unsolved problems?
> 
> I'd like to:
> - get a patch into on of the next -mm kernels that unconditionally 
>   enables 4KSTACKS
> - if there won't be new reports of breakages, send a patch to
>   completely remove !4KSTACKS for 2.6.15
> 
> In -mm, Reiser4 still has a dependency on !4KSTACKS.
> I've mentioned this at least twice to the Reiser4 people, and they 
> should check why this dependency is still there and if there are still 
> stack issues in Reiser4 fix them.
> 
> If not people using Reiser4 on i386 will have to decide whether to 
> switch the filesystem or the architecture...

FWIW: I use Reiser4 for several months now on several i386 systems, and
I always remove the "&& !4STACKS" from fs/reiser4/Kconfig and enable
CONFIG_4KSTACKS:

# zgrep -E 'REISER4|4KSTACKS' /proc/config.gz 
CONFIG_REISER4_FS=y
# CONFIG_REISER4_DEBUG is not set
CONFIG_4KSTACKS=y

Also using lvm2, or raid1, or raid5, on ATA, SATA or SCSI. I haven't
experienced any problems yet, but the systems don't see heavy usage too.

	Kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
