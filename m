Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWHKSAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWHKSAd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 14:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWHKSAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 14:00:32 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:53150 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750910AbWHKSAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 14:00:32 -0400
Date: Fri, 11 Aug 2006 20:00:08 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: xfs@oss.sgi.com
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Directory corruption
Message-ID: <Pine.LNX.4.61.0608111955530.23379@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I was about to (finally!) fix my on-disk corruptions using a new xfsprogs, 
and this is what I got:

# xfs_check /dev/hda2
bad free block nused 1 should be 40 for dir ino 17332222 block 16777216
bad nblocks 907 for inode 109663513, counted 922
bad nblocks 849 for inode 109663521, counted 859
sb_ifree 26084, counted 26080
sb_fdblocks 1712799, counted 1712761
user quota id 0, have/exp bc 796381/796369
group quota id 0, have/exp bc 794376/794364 ic 88214/88212
group quota id 5, have/exp ic 651/653

But before I wanted to fix that, I checked which objects were affected

# find /mnt/hda2ro -inum 109663513 -o -inum 109663521
/mnt/hda2ro/var/log/kernel
/mnt/hda2ro/var/log/messages
Ok so far, but

# find /mnt/hda2ro -inum 17332222

Did not turn up anything. Is it an object that is invisible?

Jan Engelhardt
-- 
