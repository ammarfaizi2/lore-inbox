Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265592AbTGCJRO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 05:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265607AbTGCJRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 05:17:14 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:12990 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265592AbTGCJRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 05:17:12 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.74 does not boot with TCQ: Unable to handle NULL pointer dereference
Date: Thu, 3 Jul 2003 03:38:54 -0400
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307030338.54603.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.72 + bk : kernel boots fine with TCQ, TASKFILE, and TASKFILE_IO enabled
It froze a bunch of times, but at least it booted.

2.5.74: kernel refuses to boot (kernel panic).
Disabling TASKFILE_IO does not help
Disabling TASKFILE does not help
Disabling TCQ allows the kernel to boot. 

Here's the oops data (copied by hand)...
Please CC, I'm not subscribed.

Unable to handle kernel NULL pointer dereference in virtual address 00000000
.... 
kernel is not tainted...
...
EIP at 0x0 
Process swapper

__elv_add_request + 0x36/0x50
ide_do_drive_cmd+0xc2/0x140
ide_diag_taskfile+0xac/0xe0
ide_raw_taskfile+0x27/0x30
ide_tcq_configure+0x7c/0x110
ide_enable_queued+0x5e/0x100
__ide_dma_queued_on+0x94/0xc0
__ide_dma_on+0x53/0x60
via82cxxx_ide_dma_check+0xbf/0xe0
probe_hwif+0x24a/0x480
probe_hwif_init+0x25/0x80
ide_setup_pci_device+0x57/0x90
via_init_one+0x3c/0x50
ide_scan_pcidev+0x5c/0x70
ide_scan_pcibus+0x3e/0xe0
probe_for_hwifs+0x10/0x20
ide_init_builtin_drivers+0x5/0x10
ide_init+0x45/0x60
do_initcalls+0x2c/0xa0
init_workqueues+0xf/0x60
init+0x34/0x1d0
init+0x0/0x1d0
kernel_thread_helper+0x5/0x10

Code: Bad EIP value

<0> Kernel panic: Attempted to kill init.

