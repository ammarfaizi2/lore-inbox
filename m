Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbUCSPh3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 10:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbUCSPh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 10:37:28 -0500
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:28503 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S263023AbUCSPg7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 10:36:59 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: 2.6.3 loop mount kernel panic
Date: Fri, 19 Mar 2004 14:27:24 +0000
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200403191427.24378.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


USB 2 hard drive mounted as /mnt/removable.
Tried to mount an iso on said drive as /mnt/cd1 -o loop

Mount didn't return and I found this in dmesg: (Tainting is nVidia driver)

loop: loaded (max 8 devices)
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Tainted: PF  VLI
EFLAGS: 00010296
EIP is at 0x0
eax: e7b8bf5c   ebx: f89a2ac0   ecx: f7fb3d50   edx: f23f19e0
esi: 00000000   edi: f7fb3d50   ebp: e7b8bf78   esp: e7b8bf44
ds: 007b   es: 007b   ss: 0068
Process loop0 (pid: 24723, threadinfo=e7b8a000 task=ea24d350)
Stack: f8bb374a f23f19e0 e7b8bf5c 00000800 f8bb3610 e7b8bf64 00000000 00000000
       ecdf1000 c16477b0 00000000 00004000 00000000 e7b8bfa8 f8bb37be ecdf1000
       f7fb3d50 00004000 00000000 00000000 00000000 00000000 f7fb61a0 ecdf1000
Call Trace:
 [<f8bb374a>] __crc_loop_unregister_transfer+0x38ccfc75/0x38cd1215 [loop]
 [<f8bb3610>] __crc_loop_unregister_transfer+0x38ccfb3b/0x38cd1215 [loop]
 [<f8bb37be>] __crc_loop_unregister_transfer+0x38ccfce9/0x38cd1215 [loop]
 [<f8bb383b>] __crc_loop_unregister_transfer+0x38ccfd66/0x38cd1215 [loop]
 [<f8bb3a95>] __crc_loop_unregister_transfer+0x38ccffc0/0x38cd1215 [loop]
 [<f8bb39f0>] __crc_loop_unregister_transfer+0x38ccff1b/0x38cd1215 [loop]
 [<c01092cd>] kernel_thread_helper+0x5/0x18

Code:  Bad EIP value.





System is Dual Opteron running in i686 mode.

As an aside, does USB2 actually work properly on this board (Tyan S2875) ? It 
seems to only be running at USB1 speeds.

$ lspci
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-8151 System Controller 
(rev 13)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8151 AGP Bridge (rev 13)
00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
00:07.5 Multimedia audio controller: Advanced Micro Devices [AMD] AMD-8111 
AC97 Audio (rev 03)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
01:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
01:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
01:03.0 Ethernet controller: Intel Corp.: Unknown device 1013
01:08.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
01:0a.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller 
(rev 80)
01:0b.0 USB Controller: VIA Technologies, Inc. USB (rev 61)
01:0b.1 USB Controller: VIA Technologies, Inc. USB (rev 61)
01:0b.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 62)
02:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0342 
(rev a1)


Cheers,

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAWwNMBn4EFUVUIO0RAsrSAKDlDK/pnh61IglmGAepUO3nCF4GjgCfZLrQ
pL5CbL00tda+9tGkgUY/p4E=
=1NUX
-----END PGP SIGNATURE-----

