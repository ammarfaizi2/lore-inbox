Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbUKWWN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbUKWWN7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbUKWWMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 17:12:17 -0500
Received: from 113-104-46.adsl.cust.tie.cl ([200.113.104.46]:51334 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261439AbUKWWK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 17:10:28 -0500
Date: Tue, 23 Nov 2004 19:12:19 -0300
From: celeron <celeron2002@chile.com>
To: linux-kernel@vger.kernel.org
Subject: bug in mm/slab.c
Message-Id: <20041123191219.6c280ad4.celeron2002@chile.com>
Organization: lala
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem with chipset nforce in the boot
Kernel 2.6.9-final in archlinux ( www.archlinux.org ) but compiled by myself.

nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6111  Tue Jul 27 07:55:38 PDT 2004
kmem_cache_create: duplicate cache sgpool-8
------------[ cut here ]------------
kernel BUG at mm/slab.c:1442!
invalid operand: 0000 [#1]
PREEMPT 
Modules linked in: scsi_mod i2c_amd756 i2c_algo_bit i2c_isa i2c_algo_pcf w83781d i2c_sensor nvidia
CPU:    0
EIP:    0060:[<c0139a22>]    Tainted: P   VLI
EFLAGS: 00010202   (2.6.9-final) 
EIP is at kmem_cache_create+0x3f2/0x560
eax: 0000002c   ebx: cee8fdd0   ecx: c056b8cc   edx: 00000286
esi: c046a7c6   edi: cfa9c343   ebp: cec41c60   esp: cdc6af34
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1094, threadinfo=cdc6a000 task=cdcf0aa0)
Stack: c044d5dc cfa9c33a 00000020 00002000 cdc6af54 cec41c9c ffffffe0 c0000000 
       00000020 cfaa2dc0 00000000 cdc6a000 c049f4e0 cfa5e10a cfa9c33a 00000080 
       00000020 00002000 00000000 00000000 c049f4f8 cfaa3340 cfa5e009 b7fcd000 
Call Trace:
 [<cfa5e10a>] scsi_init_queue+0x4a/0xc0 [scsi_mod]
 [<cfa5e009>] init_scsi+0x9/0xc0 [scsi_mod]
 [<c012e7fa>] sys_init_module+0x18a/0x270
 [<c01040b9>] sysenter_past_esp+0x52/0x71
Code: f4 e9 b6 fc ff ff 8b 44 24 38 c7 04 24 dc d5 44 c0 89 44 24 04 e8 5f c7 fd ff b9 cc b8 56 c0 ff 05 cc b8 56 c0 0f 8e 2f 19 00 00 <0f> 0b a2 05 41 cf 44 c0 8b 0b 89 cb e9 dd fe ff ff 8b 47 34 c7 
 <6>eth0: link up, 10Mbps, half-duplex, lpa 0x0000
hdd: CHECK for good STATUS
spurious 8259A interrupt: IRQ7.


My System:

LSPCI
00:00.0 Host bridge: nVidia Corporation nForce CPU bridge (rev b2)
00:00.1 RAM memory: nVidia Corporation nForce 220/420 Memory Controller (rev b2)
00:00.2 RAM memory: nVidia Corporation nForce 220/420 Memory Controller (rev b2)
00:00.3 RAM memory: nVidia Corporation: Unknown device 01aa (rev b2)
00:01.0 ISA bridge: nVidia Corporation nForce ISA Bridge (rev c3)
00:01.1 SMBus: nVidia Corporation nForce PCI System Management (rev c1)
00:02.0 USB Controller: nVidia Corporation nForce USB Controller (rev c3)
00:03.0 USB Controller: nVidia Corporation nForce USB Controller (rev c3)
00:04.0 Ethernet controller: nVidia Corporation nForce Ethernet Controller (rev c2)
00:05.0 Multimedia audio controller: nVidia Corporation: Unknown device 01b0 (rev c2)
00:06.0 Multimedia audio controller: nVidia Corporation nForce Audio (rev c2)
00:08.0 PCI bridge: nVidia Corporation nForce PCI-to-PCI bridge (rev c2)
00:09.0 IDE interface: nVidia Corporation nForce IDE (rev c3)
00:1e.0 PCI bridge: nVidia Corporation nForce AGP to PCI Bridge (rev b2)
01:06.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
01:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
01:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
02:00.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2 - nForce GPU] (rev b1)

CPUINFO
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(TM) XP 1600+
stepping	: 2
cpu MHz		: 1403.176
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 2768.89

MODULES
scsi_mod 69468 1 - Loading 0xcfa93000
i2c_amd756 4932 0 - Live 0xcfa68000
i2c_algo_bit 8584 0 - Live 0xcfa79000
i2c_isa 1728 0 - Live 0xcfa66000
i2c_algo_pcf 6020 0 - Live 0xcfa63000
w83781d 34544 2 - Live 0xcfa6f000
i2c_sensor 2944 1 w83781d, Live 0xcfa61000
nvidia 4811124 12 - Live 0xcff50000

SCSI
I dont have scsi drivers :(
