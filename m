Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbTDJQqy (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 12:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTDJQqy (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 12:46:54 -0400
Received: from smtp.wesleyan.edu ([129.133.2.100]:38058 "EHLO
	mail.wesleyan.edu") by vger.kernel.org with ESMTP id S264103AbTDJQqw (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 12:46:52 -0400
Date: Thu, 10 Apr 2003 12:58:25 -0400 (EDT)
From: "Eric R. Buddington" <ebuddington@wesleyan.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.5.67: Stack dumps in ide-scsi code
Message-ID: <Pine.GSO.4.53.0304101254510.3749@facstaff.wesleyan.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-ECS-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux-2.5.67
Asus A7S-VM motherboard with suspected problems (onboard USB, Ethernet
  flaky)
HP 200j CD/DVD writer
Duron 950 processor

While trying to burn a DVD-RW on my HP 200j, a got a rapid series of
stack dumps. I think the initial dump was different, but scrolled
out of the buffer.

Two dumps below repeated (alternating) several times, until hdc (the
DVD writer) was offlined.

If the questionable motherboard makes this uninteresting, that's OK.
I'll have a new MB soon, and re-submit if it still happens.

-Eric

---------------------------------------

ide-scsi: reset called for 2292
hdc: ATAPI reset complete
ide-scsi: abort called for 2292
Debug: sleeping function called from illegal context at
include/asm/semaphore.h:
119
Call Trace:
 [<c011e7f7>] __might_sleep+0x53/0x68
 [<c0273d87>] scsi_sleep+0xc7/0xf4
 [<c0121fdd>] __call_console_drivers+0x51/0x58
 [<c0273cac>] scsi_sleep_done+0x0/0x14
 [<c0122651>] release_console_sem+0x101/0x270
 [<cfa9a9e9>] idescsi_abort+0x285/0x304 [ide_scsi]
 [<c0272c0d>] scsi_send_eh_cmnd+0x51d/0x60c
 [<cfa9abdb>] idescsi_reset+0x173/0x220 [ide_scsi]
 [<c02731a7>] scsi_eh_tur+0x83/0xe0
 [<c027359b>] scsi_eh_bus_device_reset+0xef/0x124
 [<c0274193>] scsi_eh_ready_devs+0x17/0x58
 [<c027446c>] scsi_unjam_host+0x1c8/0x2a4
 [<c02747be>] scsi_error_handler+0x276/0x2d8
 [<c0274548>] scsi_error_handler+0x0/0x2d8
 [<c0107179>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c011c780>] schedule+0x640/0x648
 [<c0107e4f>] __down+0x11b/0x2ac
 [<c011c7dc>] default_wake_function+0x0/0x14
 [<c010a835>] dump_stack+0xd/0x10
 [<c010842f>] __down_failed+0xb/0x14
 [<c02749bf>] .text.lock.scsi_error+0x37/0x48
 [<c0121fdd>] __call_console_drivers+0x51/0x58
 [<c0273cac>] scsi_sleep_done+0x0/0x14
 [<c0122651>] release_console_sem+0x101/0x270
 [<cfa9a9e9>] idescsi_abort+0x285/0x304 [ide_scsi]
 [<c0272c0d>] scsi_send_eh_cmnd+0x51d/0x60c
 [<cfa9abdb>] idescsi_reset+0x173/0x220 [ide_scsi]
 [<c02731a7>] scsi_eh_tur+0x83/0xe0
 [<c027359b>] scsi_eh_bus_device_reset+0xef/0x124
 [<c0274193>] scsi_eh_ready_devs+0x17/0x58
 [<c027446c>] scsi_unjam_host+0x1c8/0x2a4
 [<c02747be>] scsi_error_handler+0x276/0x2d8
 [<c0274548>] scsi_error_handler+0x0/0x2d8
 [<c0107179>] kernel_thread_helper+0x5/0xc


