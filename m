Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264744AbTFAWPn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 18:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264746AbTFAWPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 18:15:42 -0400
Received: from warrior.services.quay.plus.net ([212.159.14.227]:10945 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id S264744AbTFAWPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 18:15:41 -0400
Date: Sun, 1 Jun 2003 23:28:58 +0100
From: Robert Murray <rob@mur.org.uk>
To: linux-kernel@vger.kernel.org
Subject: ide problem - is this a known problem, or is the disk dead?
Message-ID: <20030601222857.GA1116@mur.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I'm running 2.4.21-rc6, and one of my drives has failed with the following messages.  Does this indicate a hardware failure?

All but one of the partitions are raid1, so they still work. The one raid0 partition, which holds less important stuff like squid cache files, obviously doesn't.  I tried to remount it read-only, but mount hangs for ever. It would be nice if linux could deal with hardware failures like this gracefully, and allow the fs to be unmounted.

here is the log:

Jun  1 06:28:00 r2d2 kernel: hdc: dma_timer_expiry: dma status == 0x21
Jun  1 06:28:10 r2d2 kernel: hdc: timeout waiting for DMA
Jun  1 06:28:10 r2d2 kernel: hdc: timeout waiting for DMA
Jun  1 06:28:10 r2d2 kernel: hdc: (__ide_dma_test_irq) called while not waiting
Jun  1 06:28:10 r2d2 kernel: hdc: status timeout: status=0xd0 { Busy }
Jun  1 06:28:10 r2d2 kernel:
Jun  1 06:28:10 r2d2 kernel: hdc: drive not ready for command
Jun  1 06:28:40 r2d2 kernel: ide1: reset timed-out, status=0xd0
Jun  1 06:28:40 r2d2 kernel: hdc: status timeout: status=0xd0 { Busy }
Jun  1 06:29:11 r2d2 kernel:
Jun  1 06:29:11 r2d2 kernel: hdc: drive not ready for command
Jun  1 06:29:11 r2d2 kernel: ide1: reset timed-out, status=0xd0
Jun  1 06:29:11 r2d2 kernel: blk: queue c03886b4, I/O limit 4095Mb (mask 0xfffff
fff)
Jun  1 06:29:11 r2d2 kernel: end_request: I/O error, dev 16:06 (hdc), sector 905
464
Jun  1 06:29:11 r2d2 kernel: raid1: Disk failure on ide/host0/bus1/target0/lun0/
part6, disabling device.
Jun  1 06:29:11 r2d2 kernel: ^IOperation continuing on 1 devices
Jun  1 06:29:11 r2d2 kernel: md: updating md3 RAID superblock on device
Jun  1 06:29:11 r2d2 kernel: md: (skipping new-faulty ide/host0/bus1/target0/lun
0/part6 )
Jun  1 06:29:11 r2d2 kernel: md: ide/host0/bus0/target0/lun0/part6 [events: 0000
0077]<6>(write) ide/host0/bus0/target0/lun0/part6's sb offset: 94095168
Jun  1 06:29:11 r2d2 kernel: raid1: ide/host0/bus1/target0/lun0/part6: reschedul
ing block 905464
Jun  1 06:29:11 r2d2 kernel: end_request: I/O error, dev 16:06 (hdc), sector 192
0
Jun  1 06:29:11 r2d2 kernel: end_request: I/O error, dev 16:06 (hdc), sector 192
8
Jun  1 06:29:11 r2d2 kernel: end_request: I/O error, dev 16:06 (hdc), sector 193
6
Jun  1 06:29:11 r2d2 kernel: raid1: ide/host0/bus0/target0/lun0/part6: redirecti
ng sector 905464 to another mirror
Jun  1 06:29:11 r2d2 kernel: end_request: I/O error, dev 16:06 (hdc), sector 194
4
Jun  1 06:29:11 r2d2 kernel: end_request: I/O error, dev 16:06 (hdc), sector 195
2
Jun  1 06:29:11 r2d2 kernel: end_request: I/O error, dev 16:06 (hdc), sector 196
0
Jun  1 06:29:11 r2d2 kernel: end_request: I/O error, dev 16:06 (hdc), sector 196
8
Jun  1 06:29:11 r2d2 kernel: end_request: I/O error, dev 16:06 (hdc), sector 197
6
Jun  1 06:29:11 r2d2 kernel: end_request: I/O error, dev 16:06 (hdc), sector 198
4
Jun  1 06:29:11 r2d2 kernel: end_request: I/O error, dev 16:06 (hdc), sector 199
2
[...]
more of the same.

Get back to me if you need more info.  I'll try the drive in another machine soon to check it.


Cheers

Rob


