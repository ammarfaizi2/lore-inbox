Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268701AbUIGWNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268701AbUIGWNH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 18:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268702AbUIGWNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 18:13:06 -0400
Received: from smtp08.auna.com ([62.81.186.18]:4260 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S268701AbUIGWMp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:12:45 -0400
Date: Tue, 07 Sep 2004 22:12:39 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Killer CacheFS [was Re: 2.6.9-rc1-mm4]
To: Danny ter Haar <dth@ncc1701.cistron.net>
Cc: linux-kernel@vger.kernel.org
References: <20040907020831.62390588.akpm@osdl.org>
	<chkom3$hf4$1@news.cistron.nl>
In-Reply-To: <chkom3$hf4$1@news.cistron.nl> (from dth@ncc1701.cistron.net on
	Tue Sep  7 18:46:59 2004)
X-Mailer: Balsa 2.2.4
Message-Id: <1094595159l.7322l.0l@werewolf.able.es>
X-Balsa-Fcc: file:///home/magallon/mail/sentbox
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.09.07, Danny ter Haar wrote:
> Andrew Morton  <akpm@osdl.org> wrote:
> >2.6.9-rc1-mm4
> 
> 
> >md-add-interface-for-userspace-monitoring-of-events.patch
> >  md: add interface for userspace monitoring of events.
> >
> >md-correct-working_disk-counts-for-raid5-and-raid6.patch
> >  md: correct "working_disk" counts for raid5 and raid6
> 
> 
> My machine is/was running -mm3 on a software raid1 setup.
> After the upgrade to -mm4 it boots to the point where it says:
> 
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> md: Loading md_d0: /dev/sda
> md: bind<sda>
> md: bind<sdb>
> raid1: raid set md_d0 active with 2 out of 2 mirrors
> md_d0: p1 p2 p3 < p5 p6 p7 p8 p9 >
> CacheFS: filesystem mounted read-only

LOOK HERE ^^^^^^^^^ ^^^^^^^^^^^^^^^^^^^
> VFS: Cannot open root device "md_d0p1" or unknown_block (254,1)
> Please append a correct "root=" boot option
> 

Me too, and I boot from a normal ide drive. Disable CacheFS and
you will boot.

In my case, the block was (33,1), drive was hde1.
It looks like cachefs is doing something strange....

I swear, I just disabled CacheFS and the same kernel booted.

Hope this helps.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (RC 1) for i586
Linux 2.6.9-rc1-mm3 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #1


