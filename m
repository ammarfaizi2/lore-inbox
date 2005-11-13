Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVKMKcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVKMKcJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 05:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVKMKcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 05:32:09 -0500
Received: from netzweb.gamper-media.ch ([157.161.128.137]:51216 "EHLO
	ns1.netzweb.ch") by vger.kernel.org with ESMTP id S932182AbVKMKcI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 05:32:08 -0500
From: "Miro Dietiker, MD Systems" <info@md-systems.ch>
To: <linux-kernel@vger.kernel.org>
Subject: Locking md device and system for several seconds
Date: Sun, 13 Nov 2005 11:31:50 +0100
Organization: MD Systems
Message-ID: <014101c5e83d$759c3df0$4001a8c0@MDSYSPORT>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm using kernel 2.6.14.2 with md (RAID1 static) as bootable.

While md synching (initial creation or after marked one as failed,
removed and re-added) there are some locking problems with the
complete system/kernel.

Sometimes the system hangs (looks like a file/disk-access-lock)
while other tty's still work (until they access also to the disk).

This "hang" is some seconds (most from 10s up to 1 minute, seldom
more) and surprisedly the system continues working.

If md is in correct state (all partitions synced) this issue
doesn't seem to appear.

Configuration
4 Partitions (/boot 1GB, / 32GB, swap 16GB, /home 250GB) on
MaxLine III SATA 300GB Disks. Each of them (including swap)
is a RAID 1 device in the listed order.
This system has a Opteron 270 with nVidia Professional Chipset.

There are NO log entries found anywhere and no console warning/error.

These are 4 systems with she same behaviour.

Did anybody ever reported such an issue or has an idea?

Miro Dietiker

