Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbUCBXGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 18:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUCBXGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 18:06:15 -0500
Received: from mail47-s.fg.online.no ([148.122.161.47]:62877 "EHLO
	mail47-s.fg.online.no") by vger.kernel.org with ESMTP
	id S261223AbUCBXGH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 18:06:07 -0500
To: linux-kernel@vger.kernel.org
Subject: Hard disk failure messages
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 03 Mar 2004 00:06:04 +0100
Message-ID: <yw1xoerealyb.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One of my hard disks recently failed again.  This time I got these
messages in the kernel log:

hdi: dma_timer_expiry: dma status == 0x20
hdi: DMA timeout retry
hdi: timeout waiting for DMA
hdi: status error: status=0x00 { }

hdi: drive not ready for command
hdi: status error: status=0x00 { }

hdi: drive not ready for command
hdi: status error: status=0x00 { }

hdi: drive not ready for command
hdi: status error: status=0x00 { }

hdi: drive not ready for command
ide4: reset: success
hdi: task_out_intr: status=0x00 { }

hdi: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hdi: drive not ready for command
hdi: recal_intr: status=0xd0 { Busy }

hdi: DMA disabled
ide4: reset: master: error (0x00?)
hdi: status timeout: status=0xd0 { Busy }

hdi: no DRQ after issuing WRITE_EXT
ide4: reset timed-out, status=0xd0
end_request: I/O error, dev hdi, sector 183519345
raid1: Disk failure on md3, disabling device. 
	Operation continuing on 1 devices

What do these errors mean more precisely?  I'd like to know what
happened.  The disk doesn't reply anything meaningful to SMART
queries.  hdparm -C reports the disk state as "standby" even though
automatic spindown was not enabled and hdparm -I returns zeros for all
values.

This has happened several times with hdi, using different disks.  I
had the shop test one of the disks and got it replaced.  The other has
been working will on a different port of the same controller for
months.

In case it matters, these are Seagate Barracuda disks on an hpt374
controller.

-- 
Måns Rullgård
mru@kth.se
