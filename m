Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315736AbSECWlI>; Fri, 3 May 2002 18:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315738AbSECWlI>; Fri, 3 May 2002 18:41:08 -0400
Received: from hera.cwi.nl ([192.16.191.8]:20701 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315736AbSECWlH>;
	Fri, 3 May 2002 18:41:07 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 4 May 2002 00:40:56 +0200 (MEST)
Message-Id: <UTC200205032240.g43Meuf15031.aeb@smtp.cwi.nl>
To: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org
Subject: IDE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

< Recap >

== I have had problems with 2.5.10 (first few blocks of the root
== filesystem overwritten) and then went back to 2.5.8 that I had
== used for a while already, but then also noticed corruption there.
== Back at 2.4.17 today..

< Optimistic reply >

= It could very well be that the recent changes could have cured this.

< Reality of today >

Booted a vanilla 2.5.12. It did not succeed in mounting the root
filesystem, but instead wrote zeros over the superblock.

	hdb: task_out_intr: error=0x04 { DriveStatusError }

Will try 2.5.13 later.

Andries


[So, 2.5.8 causes very slow corruption, and can be used for
several hours, sometimes days, before something bad happens.
And bad things only happen to disks on HPT366.
On the other hand, 2.5.10 and 2.5.12 fail directly at boot
in precisely the same way and with a disk on the mb.]

% grep _IDE .config | grep -v '#'
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_STROKE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEDMA=y
