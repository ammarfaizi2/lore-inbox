Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUE0JcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUE0JcI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 05:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUE0JcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 05:32:08 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:47050 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261857AbUE0JcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 05:32:05 -0400
Date: Thu, 27 May 2004 18:33:18 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH]Diskdump - yet another crash dump function
To: linux-kernel@vger.kernel.org
Message-id: <1CC443CDA50AF2indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although I know about LKCD and netdump, I'm developing yet another crash
dump, which is a polling-based disk dump as netdump do. Because it
disables any interrupts during doing dump, it can avoid lots of problems
LKCD has.

Main Feature
- Reliability
   Diskdump disables interrupts, stops other cpus and writes to the 
   disk with polling mode. Therefore, unnecessary functions(like
   interrupt handler) don't disturb dumping.
- Safety
   Before writing to the disk, diskdump checks its disk partition to 
   confirm whether it is a really dump device. Therefore, diskdump
   doesn't overwrite filesystems by mistake.

Currently, diskdump supports only scsi disk(aic7xxx/aic79xx), but, I'm
planning to support IDE disk in the near future.

Diskdump can be downloaded from here.
   http://sourceforge.net/projects/lkdump
Please see readme.txt which can be downloaded from this site.

Any comments?

Best Regards,
Takao Indoh
