Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268149AbTBYSjb>; Tue, 25 Feb 2003 13:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268150AbTBYSjb>; Tue, 25 Feb 2003 13:39:31 -0500
Received: from air-2.osdl.org ([65.172.181.6]:44778 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268149AbTBYSja>;
	Tue, 25 Feb 2003 13:39:30 -0500
Message-Id: <200302251849.h1PInh921599@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Dave McCracken <dmccr@us.ibm.com>, cliffw@osdl.org
Subject: 2.5.62-mm3 -Panics during dbt2 run
In-Reply-To: Message from Andrew Morton <akpm@digeo.com> 
   of "Tue, 25 Feb 2003 01:55:37 PST." <20030225015537.4062825b.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Feb 2003 10:49:43 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tried hard to test this, but all it does for me is panic.
Is this fixed in 2.5.63?
This is 4-way PIII system. 
 panic, while booting
Press Y within 1 seconds to force file system integrity check...
 [<c02409e8>] as_next_request+0x38/0x50
 [<c02385c6>] elv_next_request+0x16/0x110
 [<c02823bc>] scsi_request_fn+0x4c/0x300
 [<c023a358>] blk_remove_plug+0x88/0x100
 [<c023a64d>] __blk_run_queue+0x1d/0x30
 [<c0281739>] scsi_queue_next_request+0xa9/0x240
 [<c023c060>] end_that_request_last+0x50/0x90
 [<c02819d2>] scsi_end_request+0x102/0x120
 [<c0281d31>] scsi_io_completion+0x161/0x4e0
 [<c02a545c>] ahc_done+0x1ec/0x470
 [<c02ab3fb>] sd_rw_intr+0x7b/0x210
 [<c027b6f6>] scsi_finish_command+0x86/0xf0
 [<c027b4d9>] scsi_softirq+0xc9/0x220
 [<c0129515>] do_softirq+0xc5/0xd0
 [<c010bf35>] do_IRQ+0x1c5/0x1f0
 [<c0107340>] default_idle+0x0/0x40
 [<c010a584>] common_interrupt+0x18/0x20
 [<c0107340>] default_idle+0x0/0x40
 [<c010736d>] default_idle+0x2d/0x40
 [<c010740a>] cpu_idle+0x4a/0x60
 [<c0105000>] rest_init+0x0/0x80

Code: 8b 46 14 8b 40 50 89 04 24 e8 5e 9b ff ff 8d 43 70 e8 c6 52
---------------------------------

It died again, while bunzipping the db backup, but
i did not get the panic string

--------------------------------------
cliffw


