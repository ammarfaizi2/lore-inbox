Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268848AbUIMSjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268848AbUIMSjv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 14:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268839AbUIMSjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 14:39:51 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:16831 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S268834AbUIMSjW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 14:39:22 -0400
Subject: 2.6.9-rc1-mm5 qlogic oops
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1095100546.3628.162.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Sep 2004 11:35:47 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this Oops with qlogic 2200 FC controllers with 2.6.9-rc1-mm5.
Is this a known issue ? Any fixes ?

Thanks,
Badari

QLogic Fibre Channel HBA Driver (c02f39b0)
ACPI: PCI interrupt 0000:04:05.0[A] -> GSI 20 (level, low) -> IRQ 20
qla2200 0000:04:05.0: Found an ISP2200, irq 20, iobase 0xf8870000
qla2200 0000:04:05.0: Configuring PCI space...
qla2200 0000:04:05.0: Configure NVRAM parameters...
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c02faf0a
*pde = 00518001
Oops: 0002 [#1]
SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c02faf0a>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-rc1-mm5)
EIP is at qla2x00_nvram_config+0x19a/0x600
eax: 00000000   ebx: f7864248   ecx: 00000018   edx: f8870000
esi: 00000080   edi: 00000000   ebp: c508ae50   esp: c508ae18
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c508a000 task=c50b15b0)
Stack: c508ae28 00000001 00000246 00000037 c508ae40 c0125dc4 c508ae5c
f7880000
       00000000 000000ff 00000000 f7864248 00000000 000000ff c508ae74
c02f99bf
       c040aec0 c04013b9 c530649c c508ae74 00000000 f7864248 00000000
c508af0c
Call Trace:
 [<c0108e76>] show_stack+0xa6/0xb0
 [<c0108ff2>] show_registers+0x152/0x1c0
 [<c01091fd>] die+0xed/0x180
 [<c011df6e>] do_page_fault+0x3fe/0x665
 [<c0108a5d>] error_code+0x2d/0x38
 [<c02f99bf>] qla2x00_initialize_adapter+0xcf/0x240
 [<c02f637b>] qla2x00_probe_one+0x37b/0x810
 [<c0264259>] pci_device_probe_static+0x49/0x70
 [<c02642b7>] __pci_device_probe+0x37/0x50
 [<c02642f6>] pci_device_probe+0x26/0x60
 [<c02aa4f5>] bus_match+0x35/0x80
 [<c02aa63f>] driver_attach+0x4f/0x90
 [<c02aaaed>] bus_add_driver+0x8d/0xc0
 [<c026459b>] pci_register_driver+0x6b/0xa0
 [<c04f8a8d>] qla2200_init+0xd/0x20
 [<c04dca26>] do_initcalls+0x26/0xc0
 [<c0100574>] init+0x94/0x1d0
 [<c01062b5>] kernel_thread_helper+0x5/0x10
Code: c6 40 1d 04 c6 40 47 04 c6 40 51 05 c6 40 52 08 66 c7 40 54 08 00
c6 40 6f 3c c7 45 f0 01 00 00 00 31 c0 b9 18 00 00 00 8b 7d e8 <f3> ab
8b 4d e4 0f b6 51 08 0f b6 41 09 80 ca 42 0c 21 80 e2 cf
 <0>Kernel panic - not syncing: Attempted to kill init!


