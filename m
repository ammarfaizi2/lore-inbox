Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWHGSmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWHGSmU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 14:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWHGSmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 14:42:20 -0400
Received: from tim.rpsys.net ([194.106.48.114]:21895 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932301AbWHGSmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 14:42:20 -0400
Subject: 2.6.18-rc4 jffs2 problems
From: Richard Purdie <rpurdie@rpsys.net>
To: linux-mtd <linux-mtd@lists.infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 19:41:50 +0100
Message-Id: <1154976111.17725.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I previous reported problems with jffs2 on the Zaurus. I tested
2.6.18-rc4 and nothing has changed - I see the following when booting,
both with filesystems that work with 2.6.17 and freshly reflashed
systems:

Linux version 2.6.18-rc4-.dev-snapshot-20060807 (richard@tim) (gcc version 3.4.3) #1 PREEMPT Mon Aug 7 17:47:07 BST 2006
CPU: XScale-PXA250 [69052904] revision 4 (ARMv5TE), cr=0000397f
Machine: SHARP Poodle
[...]
Sharp SL series flash device: 800000 at 0
Using static partision definition
Creating 1 MTD partitions on "sharpsl-flash":
0x00120000-0x007f0000 : "Boot PROM Filesystem"
NAND device: Manufacturer ID: 0x98, Chip ID: 0x76 (Toshiba NAND 64MiB 3,3V 8-bit)
Scanning device for bad blocks
Creating 3 MTD partitions on "sharpsl-nand":
0x00000000-0x00700000 : "System Area"
0x00700000-0x01d00000 : "Root Filesystem"
0x01d00000-0x04000000 : "Home Filesystem"
[...]
Empty flash at 0x0054bc5c ends at 0x0054be00
VFS: Mounted root (jffs2 filesystem) readonly.
Freeing init memory: 100K
JFFS2 error: (472) jffs2_get_inode_nodes: short read at 0x074e84: 68 instead of 380.
JFFS2 error: (472) jffs2_do_read_inode_internal: cannot read nodes for ino 153, returned error is -5

The empty flash warning is probably due to a slightly corrupted image
due to a reboot. The last two messages appear on freshly flashed images
on both this and other Zaurus devices (all using nand/sharpsl.c).

Experience shows I can lock the device up with filesystem corruption if
I use the device :-(.

Does anyone know what the problem is or have an idea of where I should
start debugging this?

Regards,

Richard

