Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUBMHyC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 02:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266811AbUBMHyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 02:54:02 -0500
Received: from ns.schottelius.org ([213.146.113.242]:31465 "HELO
	ns.schottelius.org") by vger.kernel.org with SMTP id S266810AbUBMHx7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 02:53:59 -0500
Date: Fri, 13 Feb 2004 08:54:03 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: harddisk or kernel problem?
Message-ID: <20040213075403.GC1881@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux bruehe 2.6.1
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Since yesterday I have the problem that at bootup my cryptoloop (/home) does not
get mounted anymore. These messages are produced by the kernel:

---------------- snip ------------------

Freeing unused kernel memory: 140k freed
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8305458,
sector=8305454
end_request: I/O error, dev hda, sector 8305454
I/O error in filesystem ("hda3") meta-data dev hda3 block 0x776090
("xfs_trans_read_buf") error 5 buf count 8192
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 at 0xd8850e00, 00:0a:e6:ba:f6:c2, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8305458,
sector=8305454
end_request: I/O error, dev hda, sector 8305454
I/O error in filesystem ("hda3") meta-data dev hda3 block 0x776090
("xfs_trans_read_buf") error 5 buf count 8192


---------------- snap ------------------


if I log in as root and issue `mount /home`, it works:

---------------- snip ------------------

XFS mounting filesystem loop0
Ending clean XFS mount for filesystem: loop0

---------------- snap ------------------

Yesterday the errors
 `hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }`
repeated (don't have the dmesg, forgot to dump kernel messages).

Now I am trying the following:
enabling Anticipatory I/O scheduler (additionaly to the Deadline I/O
scheduler) and disabling Vector-based interrupt indexing.

This is just a guess, can someone tell me if that is senseless or if my
harddisk is most likely broken?

Attached dmesg from 'running' system and the new .config (changes see
above) I made.

Help is very much appreciated,

Nico, who just had a hard disk crash some weeks ago
