Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbTJJOxc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 10:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbTJJOxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 10:53:32 -0400
Received: from wiggis.ethz.ch ([129.132.86.197]:49348 "EHLO wiggis.ethz.ch")
	by vger.kernel.org with ESMTP id S262851AbTJJOw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 10:52:59 -0400
From: Thom Borton <borton@phys.ethz.ch>
To: linux-kernel@vger.kernel.org
Subject: PCMCIA CD-ROM does not work
Date: Fri, 10 Oct 2003 16:52:50 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Cfsh/czwra065OH"
Message-Id: <200310101652.53796.borton@phys.ethz.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Cfsh/czwra065OH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hello everybody

I have a Sony Vaio PCG-Z600NE with an external PCMCIA 4x CD-ROM drive, 
which used to work perfectly until around 2.4.18. With later kernels 
I did not succeed to get it running. I tried extensively with 2.4.22. 
As far as I remember, 2.4.19-21 did not work either.

I have attached the syslogs for 2.4.18, 2.4.22 and 2.6.0-test7.

Any idea what's wrong? Thanks for the help.

Thom

-- 
Thom Borton
Switzerland

--Boundary-00=_Cfsh/czwra065OH
Content-Type: text/plain;
  charset="us-ascii";
  name="syslog-2.4.22-fail.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="syslog-2.4.22-fail.txt"

Oct 10 09:35:49 grisu kernel: Yenta IRQ list 00b8, PCI irq9
Oct 10 09:35:49 grisu kernel: Socket status: 30000086
Oct 10 09:35:49 grisu cardmgr[378]: watching 1 socket
Oct 10 09:35:49 grisu cardmgr[379]: starting, version is 3.2.5
Oct 10 09:36:09 grisu cardmgr[379]: socket 0: Ninja ATA
Oct 10 09:36:09 grisu kernel: cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff 0xdc000-0xdffff 0xe8000-0xfffff
Oct 10 09:36:09 grisu cardmgr[379]: executing: 'modprobe ide-cs'
Oct 10 09:36:12 grisu kernel: hde: TOSHIBA CD-ROM XM-7002Bc, ATAPI CD/DVD-ROM drive
Oct 10 09:36:12 grisu kernel: hde: IRQ probe failed (0xb4f8)
Oct 10 09:36:12 grisu kernel: hdf: IRQ probe failed (0xb4f8)
Oct 10 09:36:12 grisu kernel: hdf: IRQ probe failed (0xb4f8)
Oct 10 09:36:12 grisu kernel: ide2: DISABLED, NO IRQ
Oct 10 09:36:15 grisu kernel: ide2: ports already in use, skipping probe
Oct 10 09:36:31 grisu last message repeated 8 times
Oct 10 09:36:31 grisu kernel: ide_cs: ide_register() at 0x180 & 0x386, irq 0 failed
Oct 10 09:36:32 grisu cardmgr[379]: get dev info on socket 0 failed: Resource temporarily unavailable
Oct 10 09:36:36 grisu cardmgr[379]: executing: 'modprobe -r ide-cs'

--Boundary-00=_Cfsh/czwra065OH
Content-Type: text/plain;
  charset="us-ascii";
  name="syslog-2.4.18-success.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="syslog-2.4.18-success.txt"

Oct 10 09:31:46 grisu kernel: Yenta IRQ list 00b8, PCI irq9
Oct 10 09:31:46 grisu kernel: Socket status: 30000416
Oct 10 09:31:46 grisu cardmgr[381]: watching 1 socket
Oct 10 09:31:46 grisu kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Oct 10 09:31:46 grisu kernel: cs: IO port probe 0x0800-0x08ff: clean.
Oct 10 09:31:46 grisu kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x220-0x22f 0x330-0x33f 0x370-0x37f 0x388-0x38f 0x398-0x39f 0x3f8-0x3ff 0x4d0-0x4d7
Oct 10 09:31:46 grisu kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Oct 10 09:31:46 grisu cardmgr[382]: starting, version is 3.2.5
Oct 10 09:32:09 grisu cardmgr[382]: socket 0: Ninja ATA
Oct 10 09:32:09 grisu kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Oct 10 09:32:09 grisu cardmgr[382]: executing: 'modprobe ide-cs'
Oct 10 09:32:12 grisu kernel: hde: TOSHIBA CD-ROM XM-7002Bc, ATAPI CD/DVD-ROM drive
Oct 10 09:32:12 grisu kernel: ide2 at 0x180-0x187,0x386 on irq 3
Oct 10 09:32:12 grisu kernel: ide_cs: hde: Vcc = 5.0, Vpp = 0.0
Oct 10 09:32:12 grisu cardmgr[382]: executing: './ide start hde'
Oct 10 09:32:12 grisu kernel: hde: bad special flag: 0x03
Oct 10 09:32:28 grisu kernel: hde: ATAPI 16X CD-ROM drive, 128kB Cache
Oct 10 09:32:28 grisu kernel: Uniform CD-ROM driver Revision: 3.12
Oct 10 09:32:29 grisu kernel: VFS: Disk change detected on device ide2(33,0)
Oct 10 09:32:29 grisu kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
Oct 10 09:32:29 grisu kernel: ISOFS: changing to secondary root
Oct 10 09:32:38 grisu kernel: ide2: unexpected interrupt, status=0xff, count=1
Oct 10 09:32:39 grisu cardmgr[382]: executing: './ide stop hde'
Oct 10 09:32:39 grisu modprobe: modprobe: Can't locate module block-major-33
Oct 10 09:32:39 grisu cardmgr[382]: + open() failed: No such device or address
Oct 10 09:32:39 grisu cardmgr[382]: executing: 'modprobe -r ide-cs'

--Boundary-00=_Cfsh/czwra065OH
Content-Type: text/plain;
  charset="us-ascii";
  name="syslog-2.6.0-test7-fail.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="syslog-2.6.0-test7-fail.txt"

Oct 10 09:38:57 grisu kernel: Yenta: CardBus bridge found at 0000:00:0c.0 [104d:8082]
Oct 10 09:38:57 grisu kernel: Yenta: ISA IRQ list 00b8, PCI irq9
Oct 10 09:38:57 grisu kernel: Socket status: 30000086
Oct 10 09:38:58 grisu cardmgr[411]: watching 1 socket
Oct 10 09:38:58 grisu cardmgr[412]: starting, version is 3.2.5
Oct 10 09:39:15 grisu cardmgr[412]: socket 0: Ninja ATA
Oct 10 09:39:15 grisu kernel: cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff 0xdc000-0xdffff 0xe8000-0xfffff
Oct 10 09:39:15 grisu cardmgr[412]: executing: 'modprobe ide-cs'
Oct 10 09:39:15 grisu kernel: ide-cs: RequestIRQ: Unsupported mode
Oct 10 09:39:15 grisu cardmgr[412]: get dev info on socket 0 failed: No such device
Oct 10 09:39:31 grisu cardmgr[412]: executing: 'modprobe -r ide-cs'
Oct 10 09:39:31 grisu cardmgr[412]: + FATAL: Error removing ide_cs (/lib/modules/2.6.0-test6/kernel/drivers/ide/legacy/ide-cs.ko): Kernel does not have module unloading support
Oct 10 09:39:31 grisu cardmgr[412]: modprobe exited with status 1

--Boundary-00=_Cfsh/czwra065OH--

