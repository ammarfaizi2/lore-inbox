Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUFJGGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUFJGGu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 02:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUFJGGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 02:06:50 -0400
Received: from prosun.first.gmd.de ([194.95.168.2]:46815 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266127AbUFJGGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 02:06:46 -0400
Subject: oops on checking for changes of usb input devices
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1086847579.24322.34.camel@localhost>
Mime-Version: 1.0
Date: Thu, 10 Jun 2004 08:06:21 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

When I attach a ps2 mouse and keyboard through a ps2->usb adapter and
then do a rescan for changes in input devices I keep getting this oops.
This is kernel 2.6.7-rc2 on powerbook G4. A way to trigger this is to
reload/restart pbbuttonsd.

Any ideas ?

Soeren


kernel: Oops: kernel access of bad area, sig: 11 [#1] 
kernel: NIP: 66696C6C LR: C029B0FC SP: EF367E10 REGS: ef367d60 TRAP: 0400    Not tainted
kernel: MSR: 40009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
kernel: TASK = efbd8050[2952] 'pbbuttonsd' THREAD: ef366000Last syscall: 5 
kernel: GPR00: 66696C6C EF367E10 EFBD8050 EFC8C8A0 ED62713C 00000000 CD7D56B0 EF367DA0  
kernel: GPR08: 00000000 00000000 C0417F04 00000004 80000488 1002578C 00000000 100C0000  
kernel: GPR16: 00000000 00000000 100CA208 100CC7E8 100CC2A8 100CC608 1001E24C 10000000  
kernel: GPR24: 10010000 00000000 1001E25C ED62713C ED62713C C0520468 C04179C8 00000010  
kernel: NIP [66696c6c] 0x66696c6c
kernel: LR [c029b0fc] input_accept_process+0x3c/0x44
kernel: Call trace:
kernel: [c029dcd8] evdev_open+0x64/0x104
kernel: [c029c070] input_open_file+0x98/0x1cc
kernel: [c006b970] chrdev_open+0xe0/0x16c
kernel: [c00605ec] dentry_open+0x150/0x23c
kernel: [c0060498] filp_open+0x64/0x68
kernel: [c0060958] sys_open+0x68/0xa0 
kernel: [c0005ea0] ret_from_syscall+0x0/0x44
udev[20103]: removing device node '/dev/input/event4'


