Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263662AbTLDWvy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 17:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbTLDWvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 17:51:52 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:50572 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S263662AbTLDWvk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 17:51:40 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: "Rahsheen Porter Sr." <microrahsheen@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: HPT366 not booting with 2.6.0tests
Date: Thu, 4 Dec 2003 17:51:35 -0500
User-Agent: KMail/1.5.1
References: <20031204160753.3bd3879a.microrahsheen@comcast.net>
In-Reply-To: <20031204160753.3bd3879a.microrahsheen@comcast.net>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312041751.35707.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.10.15] at Thu, 4 Dec 2003 16:51:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 December 2003 16:07, Rahsheen Porter Sr. wrote:
>I've been trying to get one of the 2.6.0-test kernels to work for a
>while now and have been having no luck.
>
>Latest attempt was that I compiled 2.6.0-test11. I compiled in
>ext3 and HPT366/37. My root partition is /dev/hde1 and is ext3. The
>kernel boots and recognizes the HPT366 controller just fine, but it
>doesn't actually ackknowledge ide2 and ide3 as it should. It only
> sees ide0 and ide1. This results in a kernel panic:
>
>Kernel panic: VFS: Unable to mount root fs on unknown-block(33,1)

Been there, done that, even bought the T-shirt...

That error here has historically been a typu in the lilo.conf or 
grub.conf, wrong pointer to the / filesystems partition.
So check your root(hd0:0) line.  Compare it with a good boots setting.

>This has been working fine with 2.4.20. I tried coping the .config
>directly and doing "make oldconfig". I've started from scratch. I've
>toyed with booting off-board chipsets first (which doesn't seem to
> apply anyway), and I'm just stumped at this point. Any ideas?
>
>this is an Abit BP6 dual Celeron system.
>/dev/hda is ide-cdrom (seen at boot)
>/dev/hdb is ide-scsi zip-drive
>/dev/hdc is ide-scsi cdwriter (seen at boot)
>/dev/hdd is an ide-disk
>/dev/hde is an ide-disk
>
>(attached is my .config)
>
>Thanks in advance for any help. :)

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

