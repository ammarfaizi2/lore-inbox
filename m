Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263936AbTDWDAL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 23:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbTDWDAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 23:00:11 -0400
Received: from [66.212.224.118] ([66.212.224.118]:38665 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id S263936AbTDWDAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 23:00:10 -0400
Date: Tue, 22 Apr 2003 23:04:17 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Nick Piggin <piggin@cyberone.com.au>
Subject: Badness in as-iosched:1210
Message-ID: <Pine.LNX.4.50.0304222259300.2085-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure wether you want this, it was during error handling from the 
HBA driver (source was disk error).

scsi1: ERROR on channel 0, id 3, lun 0, CDB: Read (10) 00 00 7f de 60 00 00 80 00 
Info fld=0x7fdeb2, Current sdd: sense key Medium Error
Additional sense: Unrecovered read error
end_request: I/O error, dev sdd, sector 8380032
Badness in as_add_request at drivers/block/as-iosched.c:1210
Call Trace:
 [<c0298c30>] as_add_request+0xd0/0x110
 [<c028fee5>] __elv_add_request+0x25/0x40
 [<c02e5a5f>] scsi_queue_next_request+0xaf/0x430
 [<c02938a7>] end_that_request_first+0x17/0x20
 [<c02e5e2f>] scsi_end_request+0x4f/0x130
 [<c02e30eb>] print_sense+0x1b/0x20
 [<c02e6391>] scsi_io_completion+0x2d1/0x460
 [<c0320071>] sd_rw_intr+0x41/0x160
 [<c02e077c>] scsi_finish_command+0x11c/0x160
 [<c030a7c7>] ahc_linux_isr+0x1d7/0x3a0
 [<c02e0606>] scsi_softirq+0xa6/0xd0
 [<c01268da>] do_softirq+0xca/0xd0
 [<c010bffa>] do_IRQ+0x1ba/0x210
 [<c0106f00>] default_idle+0x0/0x40
 [<c010a418>] common_interrupt+0x18/0x20
 [<c0106f00>] default_idle+0x0/0x40
 [<c0106f2e>] default_idle+0x2e/0x40
 [<c0106fba>] cpu_idle+0x3a/0x50
 [<c0105000>] rest_init+0x0/0x80
 [<c055e7dc>] start_kernel+0x16c/0x190

