Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVADPue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVADPue (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 10:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVADPue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 10:50:34 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:4571 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S261692AbVADPts convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 10:49:48 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-7.tower-45.messagelabs.com!1104853785!9001879!1
X-StarScan-Version: 5.4.5; banners=-,-,-
X-Originating-IP: [66.10.26.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: FW: Linux 2.6.10 under VMware - NULL pointer.
Date: Tue, 4 Jan 2005 10:49:44 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC4215@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux 2.6.10 under VMware - NULL pointer.
Thread-Index: AcTyc+Kb03K7BYJ9TIOsdn9jHdcJuwAARQ4w
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At first, I thought these problems may have been related to XFS; however, I am now using ext2 and they still persist.

Under the same Virtual Machine, Slackware-9.1, 10 & -current worked OK with kernels 2.6.5-2.6.9.

The current distribution I am running is Debian Sarge 3.1rc2 with 2.6.10.

Any ideas?


hda: 41943040 sectors (21474 MB) w/32KiB Cache, CHS=44384/15/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2
hdc: ATAPI 1X CD-ROM drive, 32kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
input: PC Speaker
es1371: version v0.32 time 09:23:52 Jan  4 2005
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 9 (level, low) -> IRQ 9
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x02
es1371: found es1371 rev 2 at io 0x1400 irq 9 joystick 0x0
ac97_codec: AC97  codec, id: CRY19 (Cirrus Logic CS4297A rev A)
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
ip_conntrack version 2.1 (4096 buckets, 32768 max) - 336 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/proje
cts/ipt_recent/
ClusterIP Version 0.6 loaded successfully
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 380k freed
Adding 1171760k swap on /dev/hda1.  Priority:-1 extents:1
mtrr: your processor doesn't support write-combining
Unable to handle kernel NULL pointer dereference at virtual address 0000003c
 printing eip:
c014bb70
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c014bb70>]    Not tainted VLI
EFLAGS: 00010286   (2.6.10)
EIP is at vfs_getattr+0x20/0xb0
eax: db712054   ebx: db026e60   ecx: 00000000   edx: 00000000
esi: dacdff6c   edi: 00000003   ebp: dacde000   esp: dacdfef0
ds: 007b   es: 007b   ss: 0068
Process artsd (pid: 895, threadinfo=dacde000 task=dac600a0)
Stack: dfee7c80 df837000 dacdff6c 00000000 dacdff18 00000003 c014bc4f dfee4300
       db712054 dacdff6c db712054 dfee4300 00000000 dacde000 b7fe9000 00000001
       00000001 00000000 00000296 b7fe9000 b7fe8000 00000000 dac63414 dac63414
Call Trace:
 [<c014bc4f>] vfs_stat+0x4f/0x60
 [<c013660e>] remove_vm_struct+0x5e/0x80
 [<c014c36b>] sys_stat64+0x1b/0x40
 [<c01381ee>] do_munmap+0x11e/0x160
 [<c0138274>] sys_munmap+0x44/0x70
 [<c01022e3>] syscall_call+0x7/0xb
Code: 3c 5b c3 90 8d b4 26 00 00 00 00 83 ec 18 8b 44 24 20 89 74 24 10 8b 74 24
 24 89 5c 24 0c 89 7c 24 14 8b 58 08 8b 93 84 00 00 00 <8b> 4a 3c 85 c9 74 29 89
 44 24 04 8b 44 24 1c 89 74 24 08 89 04
