Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbTASC1t>; Sat, 18 Jan 2003 21:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265355AbTASC1t>; Sat, 18 Jan 2003 21:27:49 -0500
Received: from services.erkkila.org ([24.97.94.217]:16269 "EHLO erkkila.org")
	by vger.kernel.org with ESMTP id <S265351AbTASC1n>;
	Sat, 18 Jan 2003 21:27:43 -0500
Message-ID: <3E2A0DFC.6000508@erkkila.org>
Date: Sun, 19 Jan 2003 02:31:24 +0000
From: "Paul E. Erkkila" <pee@erkkila.org>
Reply-To: pee@erkkila.org
Organization: ErkkilaDotOrg
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030108
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_services-9882-1042943804-0001-2"
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: oops - 2.5.59 fdisk USB 2.0 disk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_services-9882-1042943804-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Got this (forced) oops putting together a new pc this weekend.

This is from and fdisk of /dev/sda. Attached to an intel 845
based motherboard. No preempt, acpi, config attached.

devfs_put(cee1ca00): poisoned pointer
Forcing Oops
------------[ cut here ]------------
kernel BUG at fs/devfs/base.c:932!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c019342c>]    Not tainted
EFLAGS: 00010286
EIP is at devfs_put+0x12d/0x13a
eax: 0000000d   ebx: cee1ca00   ecx: 00000001   edx: c03f037c
esi: 0df93782   edi: cf9af580   ebp: cecf5ef8   esp: cecf5ee8
ds: 007b   es: 007b   ss: 0068
Process fdisk (pid: 3968, threadinfo=cecf4000 task=cf204180)
Stack: c0393192 c037cb80 cee1ca00 cefc4054 cecf5f0c c016dbc3 cee1ca00 
00000002
       cf9af580 cecf5f4c c016dfe2 cf9af580 00000001 cf204180 c03ee440 
00000000
       c0471fc4 c0117b59 cecf5f58 cfaea080 00000000 00000082 cf5b2100 
cf5b2118
Call Trace:
 [<c016dbc3>] delete_partition+0x72/0x86
 [<c016dfe2>] rescan_partitions+0x16e/0x178
 [<c0117b59>] schedule+0x176/0x2a4
 [<c025a31a>] blkdev_reread_part+0x80/0x93
 [<c025a5e1>] blkdev_ioctl+0x137/0x464
 [<c0121478>] process_timeout+0x0/0xc
 [<c01527a5>] sys_ioctl+0xac/0x224
 [<c010b013>] syscall_call+0x7/0xb

Code: 0f 0b a4 03 a0 31 39 c0 e9 e7 fe ff ff 55 89 e5 57 56 53 83


lspci:
00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host 
Bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP 
Bridge (rev 03)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02)
00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3 
Ti500] (rev a3)
02:01.0 Multimedia audio controller: Creative Labs SB Audigy (rev 03)
02:01.1 Input device controller: Creative Labs SB Audigy MIDI/Game port 
(rev 03)
02:01.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port
02:05.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet 
Controller (rev 02)

lsusb
Unknown line at line 1809
Duplicate HUT Usage Spec at line 2650
Bus 004 Device 001: ID 0000:0000 Virtual Hub
Bus 003 Device 002: ID 0bc7:0004 
Bus 003 Device 001: ID 0000:0000 Virtual Hub
Bus 002 Device 001: ID 0000:0000 Virtual Hub
Bus 001 Device 004: ID 05e3:0701 Genesys Logic, Inc.
Bus 001 Device 003: ID 05e3:0701 Genesys Logic, Inc.
Bus 001 Device 002: ID 0d49:5020 
Bus 001 Device 001: ID 0000:0000 Virtual Hub



--=_services-9882-1042943804-0001-2
Content-Type: application/gzip; name="config.h.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.h.gz"

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
--=_services-9882-1042943804-0001-2--
