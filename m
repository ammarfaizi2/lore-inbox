Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263653AbUD2Gmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbUD2Gmf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 02:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbUD2Gme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 02:42:34 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:18037 "EHLO
	damned.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S263653AbUD2GlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 02:41:16 -0400
To: linux-kernel@vger.kernel.org
Subject: uspend to Disk - Kernel 2.6.4 vs. r50p
Message-Id: <20040429064115.9A8E814D@damned.travellingkiwi.com>
Date: Thu, 29 Apr 2004 07:41:15 +0100 (BST)
From: hamish@travellingkiwi.com (Hamie)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an r50p running debian unstable with kernel 2.6.4, compiled from scratch using the source from kernel.org, no patching (i.e. for swsusp etc).

Most things work fine (2.6.5 broke USB for me, so I'm still at 2.6.4), but I want suspend to disk (or suspend to RAM for that matter) to work.

But.

echo -n disk > /proc/power/state

results in the (Correct?) text screen that says it's going to do the suspend etc... But then just wakes straight up. here's the logs from kern.log
Apr 29 06:44:12 ballbreaker kernel: Stopping tasks: =======================================================================|
Apr 29 06:44:12 ballbreaker kernel: Freeing memory: .......................................|
Apr 29 06:44:12 ballbreaker kernel: hdc: start_power_step(step: 0)
Apr 29 06:44:12 ballbreaker kernel: hdc: completing PM request, suspend
Apr 29 06:44:12 ballbreaker kernel: hda: start_power_step(step: 0)
Apr 29 06:44:12 ballbreaker kernel: hda: start_power_step(step: 1)
Apr 29 06:44:12 ballbreaker kernel: hda: complete_power_step(step: 1, stat: 50, err: 0)
Apr 29 06:44:12 ballbreaker kernel: hda: completing PM request, suspend
Apr 29 06:44:12 ballbreaker kernel: PM: Attempting to suspend to disk.
Apr 29 06:44:12 ballbreaker kernel: PM: snapshotting memory.
Apr 29 06:44:12 ballbreaker kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Apr 29 06:44:12 ballbreaker kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Apr 29 06:44:12 ballbreaker kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Apr 29 06:44:13 ballbreaker kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
Apr 29 06:44:13 ballbreaker kernel: hda: Wakeup request inited, waiting for !BSY...
Apr 29 06:44:13 ballbreaker kernel: hda: start_power_step(step: 1000)
Apr 29 06:44:13 ballbreaker kernel: blk: queue de7f5df8, I/O limit 4095Mb (mask 0xffffffff)
Apr 29 06:44:13 ballbreaker kernel: hda: completing PM request, resume
Apr 29 06:44:13 ballbreaker kernel: hdc: Wakeup request inited, waiting for !BSY...
Apr 29 06:44:13 ballbreaker kernel: hdc: start_power_step(step: 1000)
Apr 29 06:44:13 ballbreaker kernel: hdc: completing PM request, resume
Apr 29 06:44:13 ballbreaker kernel: Restarting tasks... done


Anyone know why it doesn't actually power off? Info on this phenomenon seems to be a bit sparse, but there seems to be a few people reporting it on various laptops...

What is the story on suspend to disk anyway? Should we use the kernel code? swsusp patches & resume2? pmdisk patches?  Damnit I just want it to work... I'd even use straight FN-F4 except my video won't wake up afterwards... Currently I have to reboot several times a day (i.e. whenever I want to move my thinkpad from one place to another). very frustrating...

TIA
 hamish. 
