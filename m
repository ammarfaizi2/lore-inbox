Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262980AbVCMFyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbVCMFyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 00:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262958AbVCMFyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 00:54:09 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:3037 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S262980AbVCMFyA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 00:54:00 -0500
Date: Sat, 12 Mar 2005 21:53:54 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: Andrew Morton <akpm@osdl.org>, <chaffee@bmrc.berkeley.edu>,
       <mc@cs.Stanford.EDU>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] crash + fsck cause file systems to contain loops (msdos
 and vfat, 2.6.11)
In-Reply-To: <87fyz1ey5p.fsf@devron.myhome.or.jp>
Message-ID: <Pine.GSO.4.44.0503122146410.4831-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Interesting.
>
> $ /devel/linux/works/fatfs/fatfstools/dosfstools-2.10/dosfsck/dosfsck -a bug10/crash.img
> dosfsck 2.10, 22 Sep 2003, FAT32, LFN
> /0006
>   Directory does not have any cluster  ("." and "..").
>   Dropping it.
> Reclaimed 3 unused clusters (6144 bytes) in 3 chains.
> Performing changes.
> crash.img: 8 files, 3/8167 clusters
>
> My fixed dosfsck found the above corruption in bug10/crash.img (bug7
> has same corruption). And probably you can see root directory via 0006
> directory, I guess your testing tree didn't have my patches yet (seems
> old behavior).

I'm using dosfsck 2.10, 22 Sep 2003, FAT32, LFN, and yes, I do see root
directory after I run dosfsck on the crashed disk image.  I'm checking
2.6.11.  By "your testing tree didn't have my patches yet", you mean you
have the patch but haven't made it public?  This "testing tree" is the
Linux source tree?  Can you be a little bit more specific?

> BTW, what mount options did you use?

I just used default mount.  mount -t msdos source target
no -o

Thanks,
-Junfeng

