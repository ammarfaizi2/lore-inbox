Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbTKQVCp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 16:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTKQVCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 16:02:44 -0500
Received: from pop.gmx.net ([213.165.64.20]:49803 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261806AbTKQVCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 16:02:34 -0500
X-Authenticated: #20450766
Date: Mon, 17 Nov 2003 21:01:37 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: DMA_NONE data_direction in scsi
In-Reply-To: <Pine.LNX.4.44.0311172013230.2258-100000@poirot.grange>
Message-ID: <Pine.LNX.4.44.0311172057160.2258-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003, Guennadi Liakhovetski wrote:

> While trying to fix tmscsim for 2.6, I've arrived at the Oops below, which

...Oops with some debugging output follow...

Guennadi
---
Guennadi Liakhovetski

DC390(0): IO_PORT=7100,IRQ=b
DC390_init: No EEPROM found! Trying default settings ...
DC390: Used defaults: AdaptID=7, SpeedIdx=0 (10.0 MHz), DevMode=0x1f, AdaptMode=0x0f, TaggedCmnds=3 (16), DelayReset=1s
DC390: pSH = c14ec000, Index 00
DC390: Adapter index 0, ID 7, IO 0x00007100, IRQ 0x0b
DC390: pACB = c14ec204, pDCBmap = c14ec240, pSRB_array = c14ec2ec
DC390: ACB size= 1088, DCB size=   30, SRB size=   50
DC390: 1 adapters found
scsi0 : Tekram DC390/AM53C974 V2.0f 2000-12-20
scsi_wait_req(): direction 2
scsi_do_req(): direction 2
scsi_insert_special_req(): direction 2
scsi_request_fn(): direction 2
scsi_dispatch_cmd(): direction 2
DC390: Queue Cmd=12,Tgt=0,LUN=0 (pid=0), direction=2
DC390_queue_command(): direction 2
DC390: Get Free SRB c14ec2ec
DC390_queue_command(): direction 2
DC390: Free SRB w/o Waiting
dc390_BuildSRB(): direction 2
DC390: We were just reset and don't accept commands yet!
DC390: Insert pSRB c14ec2ec cmd 0 to Waiting
DC390: Debug: Waiting queue woken up by timer!
DC390: Remove SRB c14ec2ec from head of Waiting
DC390: Append SRB c14ec2ec to Going
DISC, SRBdone (00,00000000), SRB c14ec2ec, pid 0
DC390: INQUIRY: result: 00000000
DC390: Remove SRB c14ec2ec from Going
DC390: Free SRB c14ec2ec
  Vendor:           Model:                   Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_wait_req(): direction 2
scsi_do_req(): direction 2
scsi_insert_special_req(): direction 2
scsi_request_fn(): direction 2
scsi_dispatch_cmd(): direction 2
DC390: Queue Cmd=12,Tgt=1,LUN=0 (pid=1), direction=2
DC390_queue_command(): direction 2
DC390: Get Free SRB c14ec2ec
DC390_queue_command(): direction 2
DC390: Free SRB w/o Waiting
dc390_BuildSRB(): direction 2
DC390: Append SRB c14ec2ec to Going
DISC, SRBdone (ff,00000000), SRB c14ec2ec, pid 1
DC390: INQUIRY: result: 00010000
DC390: Free SRB c14ec2ec
scsi_wait_req(): direction 2
scsi_do_req(): direction 2
scsi_insert_special_req(): direction 2
scsi_request_fn(): direction 2
scsi_dispatch_cmd(): direction 2
DC390: Queue Cmd=12,Tgt=2,LUN=0 (pid=2), direction=2
DC390_queue_command(): direction 2
DC390: Get Free SRB c14ec2ec
DC390_queue_command(): direction 2
DC390: Free SRB w/o Waiting
dc390_BuildSRB(): direction 2
DC390: Append SRB c14ec2ec to Going
DISC, SRBdone (ff,00000000), SRB c14ec2ec, pid 2
DC390: INQUIRY: result: 00010000
DC390: Free SRB c14ec2ec
scsi_wait_req(): direction 2
scsi_do_req(): direction 2
scsi_insert_special_req(): direction 2
scsi_request_fn(): direction 2
scsi_dispatch_cmd(): direction 2
DC390: Queue Cmd=12,Tgt=3,LUN=0 (pid=3), direction=2
DC390_queue_command(): direction 2
DC390: Get Free SRB c14ec2ec
DC390_queue_command(): direction 2
DC390: Free SRB w/o Waiting
dc390_BuildSRB(): direction 2
DC390: Append SRB c14ec2ec to Going
DISC, SRBdone (ff,00000000), SRB c14ec2ec, pid 3
DC390: INQUIRY: result: 00010000
DC390: Free SRB c14ec2ec
scsi_wait_req(): direction 2
scsi_do_req(): direction 2
scsi_insert_special_req(): direction 2
scsi_request_fn(): direction 2
scsi_dispatch_cmd(): direction 2
DC390: Queue Cmd=12,Tgt=4,LUN=0 (pid=4), direction=2
DC390_queue_command(): direction 2
DC390: Get Free SRB c14ec2ec
DC390_queue_command(): direction 2
DC390: Free SRB w/o Waiting
dc390_BuildSRB(): direction 2
DC390: Append SRB c14ec2ec to Going
DISC, SRBdone (ff,00000000), SRB c14ec2ec, pid 4
DC390: INQUIRY: result: 00010000
DC390: Free SRB c14ec2ec
scsi_wait_req(): direction 2
scsi_do_req(): direction 2
scsi_insert_special_req(): direction 2
scsi_request_fn(): direction 2
scsi_dispatch_cmd(): direction 2
DC390: Queue Cmd=12,Tgt=5,LUN=0 (pid=5), direction=2
DC390_queue_command(): direction 2
DC390: Get Free SRB c14ec2ec
DC390_queue_command(): direction 2
DC390: Free SRB w/o Waiting
dc390_BuildSRB(): direction 2
DC390: Append SRB c14ec2ec to Going
DISC, SRBdone (ff,00000000), SRB c14ec2ec, pid 5
DC390: INQUIRY: result: 00010000
DC390: Free SRB c14ec2ec
scsi_wait_req(): direction 2
scsi_do_req(): direction 2
scsi_insert_special_req(): direction 2
scsi_request_fn(): direction 2
scsi_dispatch_cmd(): direction 2
DC390: Queue Cmd=12,Tgt=6,LUN=0 (pid=6), direction=2
DC390_queue_command(): direction 2
DC390: Get Free SRB c14ec2ec
DC390_queue_command(): direction 2
DC390: Free SRB w/o Waiting
dc390_BuildSRB(): direction 2
DC390: Append SRB c14ec2ec to Going
DISC, SRBdone (ff,00000000), SRB c14ec2ec, pid 6
DC390: INQUIRY: result: 00010000
DC390: Free SRB c14ec2ec
sd_revalidate_disk(): direction 0
sd_spinup_disk(): direction 3
scsi_wait_req(): direction 3
scsi_do_req(): direction 3
scsi_insert_special_req(): direction 3
scsi_request_fn(): direction 3
scsi_dispatch_cmd(): direction 3
DC390: Queue Cmd=00,Tgt=0,LUN=0 (pid=7), direction=3
DC390_queue_command(): direction 3
DC390: Get Free SRB c14ec2ec
DC390_queue_command(): direction 3
DC390: Free SRB w/o Waiting
dc390_BuildSRB(): direction 3
------------[ cut here ]------------
kernel BUG at include/asm/dma-mapping.h:53!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0249d6e>]    Not tainted
EFLAGS: 00010046
EIP is at dc390_BuildSRB+0xea/0x190
eax: c1027fd8   ebx: c14c8ea8   ecx: c1000000   edx: c0fffdf8
esi: 00000df8   edi: c14ec2ec   ebp: c17b3d20   esp: c17b3d00
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c17b2000 task=c179e980)
Stack: c032cf56 c032cf47 00000003 c14ec2ec c023f68c c14ec204 c14ec2ec c023f68c
       c17b3d44 c024a281 c14c8ea8 c1529610 c14ec2ec 00000293 c14ec000 c14c8ea8
       c1529610 c17b3d70 c023f434 c14c8ea8 c023f68c c0322432 c0322420 00000003
Call Trace:
 [<c023f68c>] scsi_done+0x0/0x64
 [<c023f68c>] scsi_done+0x0/0x64
 [<c024a281>] DC390_queue_command+0x325/0x338
 [<c023f434>] scsi_dispatch_cmd+0x3a8/0x49c
 [<c023f68c>] scsi_done+0x0/0x64
 [<c0246293>] scsi_request_fn+0x43f/0x670
 [<c02226de>] blk_insert_request+0x116/0x1b4
 [<c02445f9>] scsi_insert_special_req+0x39/0x44
 [<c0244716>] scsi_do_req+0x7a/0x84
 [<c0244943>] scsi_wait_req+0x9b/0xd4
 [<c0244720>] scsi_wait_done+0x0/0x188
 [<c024ff9f>] sd_spinup_disk+0xb3/0x288
 [<c02508f2>] sd_revalidate_disk+0xda/0x144
 [<c0250ce5>] sd_probe+0x389/0x43c
 [<c021e206>] bus_match+0x32/0x58
 [<c021e304>] driver_attach+0x44/0x84
 [<c021e58d>] bus_add_driver+0x7d/0x9c
 [<c021e937>] driver_register+0x43/0x50
 [<c02487d3>] scsi_register_driver+0x13/0x18
 [<c03a86d6>] init_sd+0x56/0x70
 [<c039673d>] do_initcalls+0x3d/0x98
 [<c03967b4>] do_basic_setup+0x1c/0x28
 [<c01051cb>] init+0xc3/0x238
 [<c0105108>] init+0x0/0x238
 [<c0107409>] kernel_thread_helper+0x5/0xc

Code: 0f 0b 35 00 f6 cb 32 c0 29 c8 8d 04 40 89 c2 c1 e2 04 01 d0
 <0>Kernel panic: Attempted to kill init!

