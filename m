Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261825AbSJIP4D>; Wed, 9 Oct 2002 11:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261827AbSJIP4D>; Wed, 9 Oct 2002 11:56:03 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:28332 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S261825AbSJIP4B>; Wed, 9 Oct 2002 11:56:01 -0400
Subject: 2.5.41-bk2 yet another $SLEEPING at mm/slab.c:1374 report
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 09 Oct 2002 09:57:06 -0600
Message-Id: <1034179026.32404.194.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

I looked through recent archives and although I saw several reports of
"mm/slabc:1374" debug messages, I didn't see this particular traceback. 
Apologies in advance if this is a duplicate report.
Kernel is 2.5.41-bk2.

Steven

Debug: sleeping function called from illegal context at mm/slab.c:1374
Call Trace:
 [<c0119c86>] __might_sleep+0x56/0x5d
 [<c0135f75>] kmalloc+0x65/0x1b0
 [<c0120478>] __request_region+0x18/0xc0
 [<c021897f>] eata2x_detect+0x13f/0xd10
 [<c01359bc>] kmem_cache_grow+0xfc/0x320
 [<c010eeea>] timer_interrupt+0xfa/0x1b0
 [<c010adca>] handle_IRQ_event+0x3a/0x60
 [<c02064f4>] ahc_linux_alloc_device+0x14/0x70
 [<c020571c>] ahc_linux_queue+0x16c/0x1a0
 [<c01098e4>] common_interrupt+0x18/0x20
 [<c01eeb80>] scsi_done+0x0/0x80
 [<c01cb46e>] elv_queue_empty+0xe/0x20
 [<c0118081>] schedule+0x321/0x3b0
 [<c01cb46e>] elv_queue_empty+0xe/0x20
 [<c01f5400>] scsi_request_fn+0x1f0/0x4c0
 [<c01f4b4d>] scsi_queue_next_request+0x5d/0x170
 [<c01ee26d>] scsi_release_command+0x27d/0x290
 [<c0118160>] default_wake_function+0x0/0x40
 [<c01ee612>] scsi_wait_req+0xa2/0xc0
 [<c013610a>] kmem_cache_free+0x4a/0x80
 [<c01cb302>] elevator_exit+0x12/0x20
 [<c01ccd4f>] blk_cleanup_queue+0x4f/0x60
 [<c01f73b6>] scan_scsis+0x96/0xa0
 [<c01efa28>] scsi_register_host+0x48/0x330
 [<c01b3d83>] put_bus+0x13/0x57
 [<c01050b1>] init+0x51/0x1d0
 [<c0105060>] init+0x0/0x1d0
 [<c01070c9>] kernel_thread_helper+0x5/0xc




