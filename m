Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266692AbUGLDg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266692AbUGLDg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 23:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266702AbUGLDg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 23:36:56 -0400
Received: from 142.13.111.219.st.bbexcite.jp ([219.111.13.142]:37564 "EHLO
	tiger.gg3.net") by vger.kernel.org with ESMTP id S266692AbUGLDgy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 23:36:54 -0400
Date: Mon, 12 Jul 2004 12:36:50 +0900
From: Georgi Georgiev <chutz@gg3.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: partitionable md devices and partition detection
Message-ID: <20040712033647.GA20240@lion.gg3.net>
References: <20040707045939.GA20516@ols-dell.iic.hokudai.ac.jp> <16619.35060.821865.570842@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccgq1q$sht$1@news.cistron.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So the fact that it works for me is a freak accident?
> 
> I have this in lilo.conf:
> 
> append="md=d0,/dev/sda,/dev/sdb root=/dev/md_d0p1 "
> 
> and this is dmesg:
> 
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> md: Loading md_d0: /dev/sda
> md: bind<sda>
> md: bind<sdb>
> raid1: raid set md_d0 active with 2 out of 2 mirrors
>  md_d0: p1 p2 p3 < p5 p6 p7 p8 p9 p10 >
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.

I guess my problem (and not only mine it seems) is here:

md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
md: Loading md_d0: /dev/hda
md: bind<hda>
md: bind<sda>
raid1: raid set md_d0 active with 2 out of 2 mirrors
 md_d0: unknown partition table

Why the unknown partition table? It does work fine once I complete booting.
This is with 2.6.7.

Don't pay attention to the hda,sda -- I was using vmware for the tests.

Sorry if I break the thread, but I had trouble finding the proper message to
reply to.

-- 
|    Georgi Georgiev   |  When you have eliminated the impossible,     |
|     chutz@gg3.net    |  whatever remains, however improbable, must   |
|   +81(90)6266-1163   |  be the truth. -- Sherlock Holmes, "The       |
|  ------------------- |  Sign of Four"                                |
