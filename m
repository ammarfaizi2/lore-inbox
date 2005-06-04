Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVFDQeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVFDQeK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 12:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVFDQeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 12:34:10 -0400
Received: from cfa.harvard.edu ([131.142.10.1]:43141 "EHLO cfa.harvard.edu")
	by vger.kernel.org with ESMTP id S261384AbVFDQdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 12:33:52 -0400
Date: Sat, 4 Jun 2005 12:33:50 -0400 (EDT)
From: Gaspar Bakos <gbakos@cfa.harvard.edu>
Reply-To: gbakos@cfa.harvard.edu
To: linux-kernel@vger.kernel.org
Subject: kswapd causing giant load
Message-ID: <Pine.SOL.4.58.0506041232030.14011@titan.cfa.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I encounter a giant load (up to 10.0) when I copy files, either from a
remote server to the local machine, or even locally. Because I see
kswapd causing the high load, I decided to forward my email to the
kernel list; maybe anyone has a clue.

The setup is:
OS: Redhat FC3 with 2.6.11-1.14_FC3smp (redhat distro) kernel, XFS filesystem
HW: Dual opteron 2.0GHz on Tyan motherboard, 4Gb RAM

The partition i am using is:
2.1Tb hardware RAID-5 unit served by 3ware controller (8 x 300Gb)
OR
300Gb simple SATA disk, also served by a 3ware controller.

I have no clue where to start combatting this problem.
- Kernel specific?
- Due to improper setup of the 3ware controllers?
- XFS filesystem specific?

10715 hatuser   15   0 35432 2792 2020 R 28.3  0.1   1:45.06 sshd
10724 hatuser   16   0 17504  11m  664 R  8.3  0.3   0:33.56 rsync
  175 root      15   0     0    0    0 S 19.7  0.0 136:25.58 kswapd0
  172 root      15   0     0    0    0 S  0.3  0.0   1:23.59 pdflush
  174 root      15   0     0    0    0 S  0.3  0.0  99:18.93 kswapd1

Before I start extensive experimenting, maybe someone knows right away
what causes high loads due to "kswapd* and pdflush".

Cheers
Gaspar
