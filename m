Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269662AbUICMi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269662AbUICMi3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269648AbUICMi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:38:28 -0400
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:34434
	"HELO fargo") by vger.kernel.org with SMTP id S269662AbUICMf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:35:29 -0400
Date: Fri, 3 Sep 2004 14:34:47 +0200
From: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: cdrom_decode_status error
Message-ID: <20040903123446.GA488@fargo>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm doing tests with growisofs, and just recorded a dvd with a probably
wrong format. What happens is that this bad-recorded dvd-r seems to
broke the linux kernel each time i try to mount the disc. If i issue
a 'mount' command, the 'mount' process stucks in D state until i try
to eject the dvd tray. The errors that appear in the kernel log are
below.

I'm able to reproduce this error always with 2.6.7 and 2.6.8.


Sep  3 13:48:11 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:48:11 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:48:16 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:48:16 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:48:33 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:48:33 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:48:40 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:48:40 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:48:40 kernel: hdd: DMA disabled
Sep  3 13:48:40 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 13:48:40 kernel: hdd: ATAPI reset complete
Sep  3 13:48:52 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:48:52 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:48:59 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:48:59 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:49:05 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:49:05 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:49:19 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:49:19 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:49:19 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 13:49:19 kernel: hdd: ATAPI reset complete
Sep  3 13:49:29 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:49:29 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:49:29 kernel: end_request: I/O error, dev hdd, sector 0
Sep  3 13:49:29 kernel: Buffer I/O error on device hdd, logical block 0
Sep  3 13:49:36 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:49:36 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:49:48 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:49:48 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:50:04 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:50:04 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:50:15 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:50:15 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:50:15 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 13:50:16 kernel: hdd: ATAPI reset complete
Sep  3 13:50:26 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:50:26 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:50:35 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:50:35 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:50:43 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:50:43 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:51:00 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:51:00 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:51:00 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 13:51:00 kernel: hdd: ATAPI reset complete
Sep  3 13:51:04 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:51:04 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:51:04 kernel: end_request: I/O error, dev hdd, sector 8
Sep  3 13:51:04 kernel: Buffer I/O error on device hdd, logical block 1
Sep  3 13:51:17 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:51:17 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:51:34 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:51:34 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:51:40 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:51:40 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:51:56 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:51:56 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:51:56 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 13:51:56 kernel: hdd: ATAPI reset complete
Sep  3 13:52:06 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:52:06 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:52:11 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:52:11 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:52:29 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:52:29 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:52:34 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:52:34 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:52:34 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 13:52:34 kernel: hdd: ATAPI reset complete
Sep  3 13:52:45 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:52:45 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:52:45 kernel: end_request: I/O error, dev hdd, sector 16
Sep  3 13:52:45 kernel: Buffer I/O error on device hdd, logical block 2
Sep  3 13:52:58 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:52:58 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:53:05 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:53:05 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:53:17 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:53:17 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:53:32 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:53:32 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:53:32 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 13:53:32 kernel: hdd: ATAPI reset complete
Sep  3 13:53:38 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:53:38 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:53:49 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:53:49 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:53:59 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:53:59 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:54:04 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:54:04 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:54:04 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 13:54:04 kernel: hdd: ATAPI reset complete
Sep  3 13:54:12 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:54:12 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:54:12 kernel: end_request: I/O error, dev hdd, sector 24
Sep  3 13:54:12 kernel: Buffer I/O error on device hdd, logical block 3
Sep  3 13:54:22 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:54:22 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:54:28 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:54:28 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:54:44 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:54:44 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:54:52 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:54:52 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:54:52 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 13:54:52 kernel: hdd: ATAPI reset complete
Sep  3 13:55:07 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:55:07 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:55:22 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:55:22 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:55:27 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:55:27 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:55:38 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:55:38 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:55:38 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 13:55:38 kernel: hdd: ATAPI reset complete
Sep  3 13:55:49 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:55:49 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:55:49 kernel: end_request: I/O error, dev hdd, sector 32
Sep  3 13:55:49 kernel: Buffer I/O error on device hdd, logical block 4
Sep  3 13:55:54 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:55:54 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:56:06 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:56:06 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:56:17 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:56:17 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:56:22 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:56:22 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:56:22 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 13:56:22 kernel: hdd: ATAPI reset complete
Sep  3 13:56:36 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:56:36 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:56:49 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:56:49 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:56:58 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:56:58 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:57:11 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:57:11 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:57:11 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 13:57:11 kernel: hdd: ATAPI reset complete
Sep  3 13:57:23 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:57:23 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:57:23 kernel: end_request: I/O error, dev hdd, sector 40
Sep  3 13:57:23 kernel: Buffer I/O error on device hdd, logical block 5
Sep  3 13:57:33 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:57:33 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:57:48 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:57:48 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:57:57 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:57:57 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:58:07 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:58:07 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:58:07 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 13:58:07 kernel: hdd: ATAPI reset complete
Sep  3 13:58:23 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:58:23 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:58:29 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:58:29 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:58:42 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:58:42 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:58:57 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:58:57 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:58:57 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 13:58:57 kernel: hdd: ATAPI reset complete
Sep  3 13:59:03 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:59:03 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:59:03 kernel: end_request: I/O error, dev hdd, sector 48
Sep  3 13:59:03 kernel: Buffer I/O error on device hdd, logical block 6
Sep  3 13:59:17 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:59:17 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:59:26 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:59:26 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:59:32 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:59:32 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:59:46 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:59:46 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 13:59:46 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 13:59:46 kernel: hdd: ATAPI reset complete
Sep  3 13:59:56 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 13:59:56 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:00:11 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:00:11 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:00:23 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:00:23 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:00:31 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:00:31 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:00:31 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:00:31 kernel: hdd: ATAPI reset complete
Sep  3 14:00:42 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:00:42 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:00:42 kernel: end_request: I/O error, dev hdd, sector 56
Sep  3 14:00:42 kernel: Buffer I/O error on device hdd, logical block 7
Sep  3 14:00:52 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:00:52 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:01:00 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:01:00 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:01:10 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:01:10 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:01:21 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:01:21 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:01:21 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:01:21 kernel: hdd: ATAPI reset complete
Sep  3 14:01:29 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:01:29 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:01:42 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:01:42 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:01:58 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:01:58 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:02:05 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:02:05 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:02:05 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:02:06 kernel: hdd: ATAPI reset complete
Sep  3 14:02:16 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:02:16 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:02:16 kernel: end_request: I/O error, dev hdd, sector 64
Sep  3 14:02:16 kernel: Buffer I/O error on device hdd, logical block 8
Sep  3 14:02:27 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:02:27 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:02:35 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:02:35 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:02:47 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:02:47 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:02:58 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:02:58 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:02:58 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:02:58 kernel: hdd: ATAPI reset complete
Sep  3 14:03:07 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:03:07 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:03:17 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:03:17 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:03:28 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:03:28 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:03:35 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:03:35 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:03:35 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:03:35 kernel: hdd: ATAPI reset complete
Sep  3 14:03:49 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:03:49 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:03:49 kernel: end_request: I/O error, dev hdd, sector 72
Sep  3 14:03:49 kernel: Buffer I/O error on device hdd, logical block 9
Sep  3 14:04:03 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:04:03 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:04:10 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:04:10 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:04:20 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:04:20 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:04:31 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:04:31 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:04:31 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:04:31 kernel: hdd: ATAPI reset complete
Sep  3 14:04:44 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:04:44 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:04:57 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:04:57 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:05:08 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:05:08 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:05:14 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:05:14 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:05:14 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:05:15 kernel: hdd: ATAPI reset complete
Sep  3 14:05:28 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:05:28 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:05:28 kernel: end_request: I/O error, dev hdd, sector 80
Sep  3 14:05:28 kernel: Buffer I/O error on device hdd, logical block 10
Sep  3 14:05:42 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:05:42 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:05:49 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:05:49 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:05:57 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:05:57 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:06:05 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:06:05 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:06:05 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:06:05 kernel: hdd: ATAPI reset complete
Sep  3 14:06:20 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:06:20 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:06:32 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:06:32 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:06:42 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:06:42 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:06:55 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:06:55 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:06:55 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:06:55 kernel: hdd: ATAPI reset complete
Sep  3 14:07:06 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:07:06 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:07:06 kernel: end_request: I/O error, dev hdd, sector 88
Sep  3 14:07:06 kernel: Buffer I/O error on device hdd, logical block 11
Sep  3 14:07:13 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:07:13 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:07:25 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:07:25 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:07:41 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:07:41 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:07:51 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:07:51 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:07:51 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:07:51 kernel: hdd: ATAPI reset complete
Sep  3 14:08:05 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:08:05 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:08:22 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:08:22 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:08:37 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:08:37 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:08:49 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:08:49 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:08:49 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:08:49 kernel: hdd: ATAPI reset complete
Sep  3 14:09:09 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:09:09 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:09:09 kernel: end_request: I/O error, dev hdd, sector 96
Sep  3 14:09:09 kernel: Buffer I/O error on device hdd, logical block 12
Sep  3 14:09:24 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:09:24 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:09:37 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:09:37 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:09:50 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:09:50 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:09:56 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:09:56 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:09:56 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:09:56 kernel: hdd: ATAPI reset complete
Sep  3 14:10:13 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:10:13 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:10:27 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:10:27 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:10:39 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:10:39 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:10:51 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:10:51 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:10:51 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:10:51 kernel: hdd: ATAPI reset complete
Sep  3 14:11:01 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:11:01 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:11:01 kernel: end_request: I/O error, dev hdd, sector 104
Sep  3 14:11:01 kernel: Buffer I/O error on device hdd, logical block 13
Sep  3 14:11:17 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:11:17 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:11:25 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:11:25 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:11:33 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:11:33 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:11:47 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:11:47 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:11:47 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:11:47 kernel: hdd: ATAPI reset complete
Sep  3 14:11:56 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:11:56 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:12:08 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:12:08 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:12:19 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:12:19 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:12:27 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:12:27 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:12:27 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:12:27 kernel: hdd: ATAPI reset complete
Sep  3 14:12:40 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:12:40 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:12:40 kernel: end_request: I/O error, dev hdd, sector 112
Sep  3 14:12:40 kernel: Buffer I/O error on device hdd, logical block 14
Sep  3 14:12:51 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:12:51 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:13:01 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:13:01 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:13:17 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:13:17 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:13:30 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:13:30 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:13:30 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:13:30 kernel: hdd: ATAPI reset complete
Sep  3 14:13:43 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:13:43 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:13:53 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:13:53 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:14:07 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:14:07 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:14:15 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:14:15 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:14:15 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:14:16 kernel: hdd: ATAPI reset complete
Sep  3 14:14:26 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:14:26 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:14:26 kernel: end_request: I/O error, dev hdd, sector 120
Sep  3 14:14:26 kernel: Buffer I/O error on device hdd, logical block 15
Sep  3 14:14:42 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:14:42 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:14:56 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:14:56 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:15:06 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:15:06 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:15:21 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:15:21 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:15:21 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:15:21 kernel: hdd: ATAPI reset complete
Sep  3 14:15:31 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:15:31 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:15:44 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:15:44 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:15:55 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:15:55 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:16:13 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:16:13 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:16:13 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:16:13 kernel: hdd: ATAPI reset complete
Sep  3 14:16:25 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:16:25 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:16:25 kernel: end_request: I/O error, dev hdd, sector 0
Sep  3 14:16:25 kernel: Buffer I/O error on device hdd, logical block 0
Sep  3 14:16:36 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:16:36 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:16:49 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:16:49 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:17:05 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:17:05 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:17:23 kernel: hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Sep  3 14:17:23 kernel: hdd: cdrom_decode_status: error=0x40LastFailedSense 0x04 
Sep  3 14:17:23 kernel: hdd: ide_intr: huh? expected NULL handler on exit
Sep  3 14:17:23 kernel: hdd: ATAPI reset complete
Sep  3 14:17:33 kernel: hdd: tray open
Sep  3 14:17:33 kernel: end_request: I/O error, dev hdd, sector 64
Sep  3 14:17:33 kernel: Buffer I/O error on device hdd, logical block 8

-- 
David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra
