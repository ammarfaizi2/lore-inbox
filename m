Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbUKPLvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbUKPLvH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 06:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbUKPLvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 06:51:07 -0500
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:31736 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261959AbUKPLvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 06:51:04 -0500
Subject: 2.6.10-rc2 pbook oops on resume
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 16 Nov 2004 12:50:54 +0100
Message-Id: <1100605854.6333.7.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

machine comes up ok, but I see this oops in dmesg... Any ideas ?

Soeren

hda: Set PIO timing for mode 0, reg: 0x0c50032b
eth0: suspending, WakeOnLan disabled
radeonfb: suspending to state: 3...
agpgart: Putting AGP V2 device at 0000:00:0b.0 into 0x mode
agpgart: Putting AGP V2 device at 0000:00:10.0 into 0x mode
radeonfb: switching to D2 state...
cpufreq: resume failed to assert current frequency is what timing core
thinks it is.
radeonfb: switching to D0 state...
radeonfb: resumed !
Badness in enable_irq at kernel/irq/manage.c:106
Call trace:
 [c0007570] dump_stack+0x18/0x28
 [c000536c] check_bug_trap+0xb4/0xf0
 [c0005538] ProgramCheckException+0x190/0x1c0
 [c0004954] ret_from_except_full+0x0/0x4c
 [c003cd70] enable_irq+0xa0/0xa8
 [c02813e8] ohci_pci_resume+0xbc/0xd4
 [c0277ee0] usb_hcd_pci_resume+0xb0/0x114
 [c01c9fbc] pci_device_resume+0x4c/0x50
 [c0224d2c] resume_device+0x44/0x4c
 [c0224e64] dpm_resume+0x130/0x148
 [c0224eb4] device_resume+0x38/0x78
 [c04b1be4] 0xc04b1be4
 [c04b20cc] 0xc04b20cc
 [c04b2930] 0xc04b2930
 [c0078e34] sys_ioctl+0x100/0x318
Badness in enable_irq at kernel/irq/manage.c:106
Call trace:
 [c0007570] dump_stack+0x18/0x28
 [c000536c] check_bug_trap+0xb4/0xf0
 [c0005538] ProgramCheckException+0x190/0x1c0
 [c0004954] ret_from_except_full+0x0/0x4c
 [c003cd70] enable_irq+0xa0/0xa8
 [c02813e8] ohci_pci_resume+0xbc/0xd4
 [c0277ee0] usb_hcd_pci_resume+0xb0/0x114
 [c01c9fbc] pci_device_resume+0x4c/0x50
 [c0224d2c] resume_device+0x44/0x4c
 [c0224e64] dpm_resume+0x130/0x148
 [c0224eb4] device_resume+0x38/0x78
 [c04b1be4] 0xc04b1be4
 [c04b20cc] 0xc04b20cc
 [c04b2930] 0xc04b2930
 [c0078e34] sys_ioctl+0x100/0x318

-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.

