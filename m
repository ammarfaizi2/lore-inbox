Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270627AbTHAAcE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 20:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270625AbTHAAcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 20:32:04 -0400
Received: from mail.wp-sa.pl ([212.77.102.105]:30361 "EHLO mail.wp-sa.pl")
	by vger.kernel.org with ESMTP id S270627AbTHAAb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 20:31:58 -0400
Date: Fri, 01 Aug 2003 04:31:55 +0200
From: Mariusz Zielinski <mzielinski@wp-sa.pl>
Subject: xfs problems (2.6.0-test2)
To: linux-kernel@vger.kernel.org
Message-id: <200308010431.56108.mzielinski@wp-sa.pl>
Organization: Wirtualna Polska S.A.
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

0x0: 41 42 54 43 00 00 00 3a ff ff ff ff ff ff ff ff
Filesystem "hda3": XFS internal error xfs_da_do_buf(2) at line 2281 of file 
fs/xfs/xfs_da_btree.c.  Caller 0xc02042cc
Call Trace:
 [<c0203e98>] xfs_da_do_buf+0x548/0x900
 [<c02042cc>] xfs_da_read_buf+0x3c/0x40
 [<c02042cc>] xfs_da_read_buf+0x3c/0x40
 [<c02042cc>] xfs_da_read_buf+0x3c/0x40
 [<c0207ab7>] xfs_dir2_block_getdents+0x87/0x2f0
 [<c0207ab7>] xfs_dir2_block_getdents+0x87/0x2f0
 [<c01733c6>] d_splice_alias+0x36/0x120
 [<c0244c00>] linvfs_lookup+0x60/0x90
 [<c01f6f59>] xfs_bmap_last_offset+0xa9/0x120
 [<c0206ea0>] xfs_dir2_put_dirent64_direct+0x0/0xa0
 [<c0206dcd>] xfs_dir2_isblock+0x1d/0x80
 [<c0206ea0>] xfs_dir2_put_dirent64_direct+0x0/0xa0
 [<c0206625>] xfs_dir2_getdents+0x95/0x160
 [<c0206ea0>] xfs_dir2_put_dirent64_direct+0x0/0xa0
 [<c023a662>] xfs_readdir+0x52/0x90
 [<c02414bd>] linvfs_readdir+0xed/0x220
 [<c016d52e>] vfs_readdir+0x5e/0x70
 [<c016d830>] filldir64+0x0/0x130
 [<c016d9e1>] sys_getdents64+0x81/0xbb
 [<c016d830>] filldir64+0x0/0x130
 [<c0109297>] syscall_call+0x7/0xb

I lost some files; even those not used for a long time.
It is possible that last shutdown was unclear.
After xfs_repair I got lost+found full of files deleted some time ago.
I actually had to run xfs_repair (2.5.3)  few times because it was 
'segfaulting'.

>From dmesg:
...
CPU0: Centaur VIA Ezra stepping 08
...
Local APIC not detected. Using dummy APIC emulation.
...
SGI XFS for Linux 2.6.0-test2 with ACLs, realtime, no debug enabled
SGI XFS Quota Management subsystem
...
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8231 (rev 10) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 4G160J8, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 1024KiB
hda: host protected area => 1
hda: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, 
UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3

-- 
Mariusz Zielinski

