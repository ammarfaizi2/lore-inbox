Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268232AbUIGQwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268232AbUIGQwy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268231AbUIGQud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:50:33 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:28294 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S268146AbUIGQrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:47:04 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: 2.6.9-rc1-mm4
Date: Tue, 7 Sep 2004 16:46:59 +0000 (UTC)
Organization: Cistron
Message-ID: <chkom3$hf4$1@news.cistron.nl>
References: <20040907020831.62390588.akpm@osdl.org>
X-Trace: ncc1701.cistron.net 1094575619 17892 62.216.30.38 (7 Sep 2004 16:46:59 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton  <akpm@osdl.org> wrote:
>2.6.9-rc1-mm4


>md-add-interface-for-userspace-monitoring-of-events.patch
>  md: add interface for userspace monitoring of events.
>
>md-correct-working_disk-counts-for-raid5-and-raid6.patch
>  md: correct "working_disk" counts for raid5 and raid6


My machine is/was running -mm3 on a software raid1 setup.
After the upgrade to -mm4 it boots to the point where it says:

md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
md: Loading md_d0: /dev/sda
md: bind<sda>
md: bind<sdb>
raid1: raid set md_d0 active with 2 out of 2 mirrors
md_d0: p1 p2 p3 < p5 p6 p7 p8 p9 >
CacheFS: filesystem mounted read-only
VFS: Cannot open root device "md_d0p1" or unknown_block (254,1)
Please append a correct "root=" boot option


lilo config:

image=/boot/vmlinuz-2.6.9-rc1-mm4
        label=2.6.9-rc1-mm4
        append="md=d0,/dev/sda,/dev/sdb root=/dev/md_d0p1"
        read-only

image=/boot/vmlinuz-2.6.9-rc1-mm3
        label=2.6.9-rc1-mm3
        append="md=d0,/dev/sda,/dev/sdb root=/dev/md_d0p1"
        read-only


dotconfig's & dmesg output of -mm3 at 

http://dth.net/kernel/


Danny
-- 
Be nice to people on your way up because you meet them on your way down. 
 - Jimmy Durante

