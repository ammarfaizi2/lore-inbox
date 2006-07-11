Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWGKSNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWGKSNE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWGKSNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:13:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:58655 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751175AbWGKSNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:13:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fHlTCyZSfMMwslsNpLRHgFPpKXPpil+anTF41ThuvXs3ZXPUIeM6RplEI3GqQDgnuxo/FQTMtZTjiUCuehvWo1o9wlUepHfa/miqld+ZzR5MuholAzEsW4mnZBB+9Rd2SFLD7n/ysbgm7xd+rODfsOljmt8BhEqg/51HU7QBdcw=
Message-ID: <a762e240607111112v1bd28135hf99fdf0cc08a6d52@mail.gmail.com>
Date: Tue, 11 Jul 2006 11:13:00 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc1-mm1 panic on boot x86_64 NMI watchdog detected LOCKUP
Cc: "Andrew Morton" <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  I just tried booting 2.6.18-rc1-mm1 (I was booting 2.6.17-mm6 just
fine) and got the following error on boot.

CPU 15: synchronized TSC with CPU 0 (last diff 49 cycles, maxerr 4698 cycles)
Brought up 16 CPUs
testing NMI watchdog ... OK.
time.c: Using 333.333333 MHz WALL PIT GTOD PIT/HPET timer.
time.c: Detected 3002.570 MHz processor.
migration_cost=9,1121,16845
checking if image is initramfs... it is
Freeing initrd memory: 2770k freed
NMI Watchdog detected LOCKUP on CPU 8
CPU 8
Modules linked in:
Pid: 51, comm: khelper Not tainted 2.6.18-rc1-mm1-smp #2
RIP: 0010:[<ffffffff803dd6f5>]  [<ffffffff803dd6f5>]
.text.lock.spinlock+0x31/0x8a
RSP: 0000:ffff81065f91be70  EFLAGS: 00000086
RAX: 0000000000000000 RBX: ffff810476ce3380 RCX: 0000000000000000
RDX: ffff81046fad4108 RSI: ffff81046fad4000 RDI: ffff810476ce3384
RBP: ffff810476ce3380 R08: 0000000000000000 R09: 000000000036f849
R10: 0000000000000000 R11: 0000000000000002 R12: ffff81065f91bf04
R13: ffff81065f91bef8 R14: ffff810476dcdd18 R15: ffffffff8023f7a8
FS:  0000000000000000(0000) GS:ffff810476f79140(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000201000 CR4: 00000000000006e0
Process khelper (pid: 51, threadinfo ffff81065f91a000, task ffff81046fedd080)
Stack:  ffffffff803dd040 ffff81047003f8c0 ffff81065f91bef8 ffff810476dcdd18
 0000000000000246 ffff81046fad4108 ffff810476ce3380 ffff81046fad4108
 ffffffff8025b211 0000000000000000 0000000000000000 ffff81046fedd080
Call Trace:
 [<ffffffff803dd040>] __down_read+0x12/0x9a
 [<ffffffff8025b211>] taskstats_exit_alloc+0x59/0x8a
 [<ffffffff80232e89>] do_exit+0x178/0x8f6
 [<ffffffff8023f940>] request_module+0x0/0x150
 [<ffffffff8020a05a>] child_rip+0x8/0x12
 [<ffffffff8023f7a8>] __call_usermodehelper+0x0/0x47
 [<ffffffff8023f866>] ____call_usermodehelper+0x0/0xda
 [<ffffffff8020a052>] child_rip+0x0/0x12


Code: 7e f9 e9 d3 fe ff ff f3 90 83 3b 00 7e f9 e9 da fe ff ff e8
console shuts up ...


Any ideas, have we seen this?  I can attach config and full dmesg if needed.

thanks,
  Keith
