Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbUBEN2l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 08:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265236AbUBEN2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 08:28:41 -0500
Received: from [211.167.76.68] ([211.167.76.68]:52199 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S265233AbUBEN2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 08:28:37 -0500
Date: Thu, 5 Feb 2004 08:07:43 +0800
From: Hugang <hugang@soulinfo.com>
To: linux-kernel@vger.kernel.org
Subject: [oops] 2.6.2-mm1 ohci1394
Message-Id: <20040205080743.0d19d137@localhost>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

here is the dmesg log. 2.6.2 has't this problem.

ohci1394: $Rev: 1097 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 0002:02:0e.0 (0000 -> 0002)
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[40] 
MMIO=[f5000000-f50007ff]  Max Packet=[2048] Found KeyWest i2c on
"uni-n", 2 channels, stepping: 4 bits Found KeyWest i2c on "mac-io", 1
channel, stepping: 4 bits ieee1394: Host added: ID:BUS[0-00:1023] 
GUID[000a95fffe7fe0de] Badness in kobject_get at
/scm/tla/kernel26-mm/lib/kobject.c:431 Call trace:
 [c0009c14] dump_stack+0x18/0x28
 [c0006ef0] check_bug_trap+0x84/0x98
 [c0006fd4] ProgramCheckException+0xd0/0x170
 [c0006574] ret_from_except_full+0x0/0x4c
 [c00bdf94] kobject_get+0x18/0x34
 [c00e8328] bus_for_each_dev+0xa8/0x118
 [d13d0608] nodemgr_node_probe+0x90/0x120 [ieee1394]
 [d13d0b2c] nodemgr_host_thread+0x2b0/0x390 [ieee1394]
 [c000930c] kernel_thread+0x44/0x60
Oops: kernel access of bad area, sig: 11 [#1]
NIP: 3860FFEC LR: C00BE028 SP: CE875ED0 REGS: ce875e20 TRAP: 0401    Not
tainted MSR: 40009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = cfe25a60[52] 'knodemgrd_0' Last syscall: -1 
GPR00: 3860FFED CE875ED0 CFE25A60 D141CD04 CE875F58 CE875F58 D13D0424
00009032 GPR08: 00000000 00000000 C0270000 D141CD04 0C0083C0 
Call trace:
 [c00be088] kobject_put+0x2c/0x3c
 [c00e72f8] put_device+0x14/0x24
 [c00e8344] bus_for_each_dev+0xc4/0x118
 [d13d0608] nodemgr_node_probe+0x90/0x120 [ieee1394]
 [d13d0b2c] nodemgr_host_thread+0x2b0/0x390 [ieee1394]
 [c000930c] kernel_thread+0x44/0x60
Linux agpgart interface v0.100 (c) Dave Jones

-- 
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc
