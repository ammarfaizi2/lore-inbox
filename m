Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275110AbTHGGcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 02:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275113AbTHGGcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 02:32:19 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:15308 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S275110AbTHGGcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 02:32:14 -0400
Date: Wed, 06 Aug 2003 23:31:47 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm5
Message-ID: <28050000.1060237907@[10.10.2.4]>
In-Reply-To: <20030806223716.26af3255.akpm@osdl.org>
References: <20030806223716.26af3255.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Andrew Morton <akpm@osdl.org> wrote (on Wednesday, August 06, 2003 22:37:16 -0700):

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm5/
> 
> 
> Lots of different things.  Mainly trying to get this tree stabilised again;
> there has been some breakage lately.

I get lots of these .... (without 4/4 turned on)

 Badness in as_dispatch_request at drivers/block/as-iosched.c:1241
Call Trace:
 [<c01ca8d2>] as_dispatch_request+0x216/0x264
 [<c01ca938>] as_next_request+0x18/0x2c
 [<c01c343b>] elv_next_request+0x9f/0xd4
 [<c01d4cd6>] scsi_request_fn+0x2e/0x280
 [<c01c4e2f>] blk_run_queue+0x27/0x38
 [<c01d43af>] scsi_run_queue+0xb3/0xbc
 [<c01d43ff>] scsi_next_command+0x17/0x1c
 [<c01d44bc>] scsi_end_request+0x88/0x94
 [<c01d483b>] scsi_io_completion+0x1ef/0x408
 [<c01dfa4e>] sd_rw_intr+0x1ce/0x1d8
 [<c01d120d>] scsi_finish_command+0x89/0x90
 [<c01d113d>] scsi_softirq+0xc5/0xe0
 [<c012236c>] do_softirq+0x6c/0xcc
 [<c010c1d3>] do_IRQ+0x113/0x124
 [<c023c0d8>] common_interrupt+0x18/0x20

Badness in as_completed_request at drivers/block/as-iosched.c:930
Call Trace:
 [<c01ca29c>] as_completed_request+0xe4/0x170
 [<c01c357b>] elv_completed_request+0x13/0x18
 [<c01c575e>] __blk_put_request+0x2a/0x84
 [<c01c661d>] end_that_request_last+0xc5/0xd8
 [<c01d44a8>] scsi_end_request+0x74/0x94
 [<c01d483b>] scsi_io_completion+0x1ef/0x408
 [<c01dfa4e>] sd_rw_intr+0x1ce/0x1d8
 [<c01d120d>] scsi_finish_command+0x89/0x90
 [<c01d113d>] scsi_softirq+0xc5/0xe0
 [<c012236c>] do_softirq+0x6c/0xcc
 [<c010c1d3>] do_IRQ+0x113/0x124
 [<c023c0d8>] common_interrupt+0x18/0x20

seems to work, but whines a lot ;-)

M.

