Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVFOAMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVFOAMT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 20:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVFOAMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 20:12:19 -0400
Received: from dvhart.com ([64.146.134.43]:18602 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261436AbVFOAMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 20:12:10 -0400
Date: Tue, 14 Jun 2005 17:12:12 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
Subject: sysfs panic from 2.6.11
Message-ID: <23990000.1118794332@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this a known issue that's fixed in later releases? I don't remember it
from earlier tests ... during boot on a NUMA-Q

Mapping cpu 0 to node 0
Brought up 1 CPUs
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
PCI: Probing PCI hardware (bus 00)
PCI: Searching for i450NX host bridges on 0000:00:10.0
PCI: Searching for i450NX host bridges on 0000:01:10.0
------------[ cut here ]------------
kernel BUG at fs/sysfs/file.c:381!
invalid operand: 0000 [#1]
SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c017bbe3>]    Not tainted VLI
EFLAGS: 00010246   (2.6.11) 
EIP is at sysfs_create_file+0x17/0x30
eax: 00000000   ebx: c32bfcd8   ecx: c02ce410   edx: c32bfce0
esi: c32bfc60   edi: c32bfd60   ebp: 00000001   esp: c3261eb0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c3260000 task=c3230a40)
Stack: c01da4e3 c32bfce0 c02ce410 c031994a c32bfcd8 c02ce410 c32bfcd8 c32bfd20 
       c028c49d 00000000 00000001 f1842844 00000001 00000001 f1842800 00000000 
       c0319a82 c32bfd60 f1842800 00000001 f1842800 00000001 00000000 00000001 
Call Trace:
 [<c01da4e3>] class_device_create_file+0x1b/0x20
 [<c031994a>] pci_alloc_child_bus+0x76/0xb8
 [<c0319a82>] pci_scan_bridge+0xc2/0x204
 [<c0319eb9>] pci_scan_child_bus+0x69/0x94
 [<c0319aa9>] pci_scan_bridge+0xe9/0x204
 [<c0319eb9>] pci_scan_child_bus+0x69/0x94
 [<c031a057>] pci_scan_bus_parented+0x157/0x1c0
 [<c0320eed>] pcibios_scan_root+0x41/0x48
 [<c0320562>] pci_numa_init+0x2e/0xdc
 [<c03068b9>] do_initcalls+0x6d/0xc0
 [<c030692a>] do_basic_setup+0x1e/0x24
 [<c01003ac>] init+0xa8/0x164
 [<c0100304>] init+0x0/0x164
 [<c0100765>] kernel_thread_helper+0x5/0xc
Code: f0 ff 42 74 0f 8e 6b 01 00 00 89 c8 5b 5e 5f 5d c3 8d 76 00 8b 54 24 04 8b 4c 24 08 85 d2 74 0b 8b 42 30 85 c0 74 04 85 c9 75 0b <0f> 0b 7d 01 2b c4 27 c0 8b 42 30 6a 04 51 50 e8 81 ff ff ff 83 
 <0>Kernel panic - not syncing: Attempted to kill init!

