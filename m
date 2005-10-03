Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVJCHMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVJCHMp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 03:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVJCHMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 03:12:44 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:41953 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932166AbVJCHMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 03:12:44 -0400
Subject: 1GHz pbook 15", linux 2.6.14-rc2 oops on resume
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 09:12:24 +0200
Message-Id: <1128323544.4602.5.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

when a dvd featuring some iso content is in the dvd-drive and the
machine is put to sleep mode, it will give the following oops on resume.
It is working without problems if no media is in the drive.
Voluntary preemption is ON.
Find below the dmesg output when a dvd is in the drive.

eth1: Airport entering sleep mode
eth0: suspending, WakeOnLan disabled
radeonfb (0000:00:10.0): suspending to state: 2...
uninorth-agp: disabling AGP on device 0000:00:10.0
uninorth-agp: disabling AGP on bridge 0000:00:0b.0
radeonfb (0000:00:10.0): switching to D2 state...
radeonfb (0000:00:10.0): resuming from state: 2...
radeonfb (0000:00:10.0): switching to D0 state...
agpgart: Putting AGP V2 device at 0000:00:0b.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:00:10.0 into 4x mode
eth0: resuming
A
eth1 (WE) : Driver using old /proc/net/wireless support, please fix driver !
eth1: get_wireless_stats() called while device not present
PHY ID: 2060e1, addr: 0
eth1 (WE) : Driver using old /proc/net/wireless support, please fix driver !
eth1: get_wireless_stats() called while device not present
eth1: Airport waking up
hda: Enabling Ultra DMA 4
eth1: New link status: Connected (0001)
eth0: Link is up at 1000 Mbps, full-duplex.
eth0: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
BUG: soft lockup detected on CPU#0!
NIP: C0006FCC LR: C02BBC5C SP: EEF6DC00 REGS: eef6db50 TRAP: 0901    Not tainted
MSR: 0200b032 EE: 1 PR: 0 FP: 1 ME: 1 IR/DR: 11
TASK = ef800740[3274] 'pbbuttonsd' THREAD: eef6c000
Last syscall: 54 
GPR00: 00000080 EEF6DC00 EF800740 00079C96 000088B8 00000000 00000000 C05A8A50 
GPR08: C05A8538 EEF6DCC8 00100000 00140040 22004282 
NIP [c0006fcc] __delay+0xc/0x14
LR [c02bbc5c] ide_wait_not_busy+0x4c/0xc0
Call trace:
 [c02b9fa0] ide_do_request+0x5b0/0x990
 [c02ba440] ide_do_drive_cmd+0xc0/0x190
 [c02b6c00] generic_ide_resume+0x80/0xa0
 [c0293b00] resume_device+0x70/0x150
 [c0293db0] dpm_resume+0x100/0x1a0
 [c0293e8c] device_resume+0x3c/0xa0
 [c05438cc] pmac_wakeup_devices+0xbc/0xe0
 [c0544adc] pmu_ioctl+0x58c/0x9b0
 [c008e254] do_ioctl+0x84/0x90
 [c008e2ec] vfs_ioctl+0x8c/0x450
 [c008e744] sys_ioctl+0x94/0xb0
 [c0004820] ret_from_syscall+0x0/0x44
hdc: Enabling MultiWord DMA 2
eth1 (WE) : Driver using old /proc/net/wireless support, please fix driver !
VFS: busy inodes on changed media.
adb: starting probe task...
adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
ADB keyboard at 2, handler 1
ADB mouse at 3, handler set to 4 (trackpad)
adb: finished probe task...
eth1 (WE) : Driver using old /proc/net/wireless support, please fix driver !
agpgart: Putting AGP V2 device at 0000:00:0b.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:00:10.0 into 4x mode
[drm] Loading R200 Microcode
eth1 (WE) : Driver using old /proc/net/wireless support, please fix driver !
hdc: irq timeout: status=0xc0 { Busy }
ide: failed opcode was: unknown
hdc: DMA disabled
eth1 (WE) : Driver using old /proc/net/wireless support, please fix driver !
eth1 (WE) : Driver using old /proc/net/wireless support, please fix driver !
hdc: ATAPI reset complete
VFS: busy inodes on changed media.

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.

