Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266209AbUHOVSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266209AbUHOVSN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 17:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266900AbUHOVSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 17:18:13 -0400
Received: from host-83-146-9-72.bulldogdsl.com ([83.146.9.72]:8811 "EHLO
	host-83-146-9-72.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S266209AbUHOVSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 17:18:08 -0400
Message-ID: <411FD307.4000102@unsolicited.net>
Date: Sun, 15 Aug 2004 22:17:59 +0100
From: David R <spam.david.trap@unsolicited.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.8.1 Oops after raid1 disk failure
Content-Type: multipart/mixed;
 boundary="------------010606030806030302000105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010606030806030302000105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I got the following Oops (attached) after a drive failed in my raid1 
pair. I'm assuming the kernel shouldn't really do this as the other 
drive was ok?

Cheers
David

--------------010606030806030302000105
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"


Aug 15 21:30:35 server kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Aug 15 21:30:35 server kernel: hdc: dma_intr: error=0x40 { Uncorrectable Error } LBAsect=100651832, sector=100651832
Aug 15 21:30:35 server kernel: end_request: I/O error, dev hdc, sector 100651832  
Aug 15 21:30:35 server kernel: raid1: Disk failure on hdc3, disabling device
Oops: 0000 [#1]
PREEMPT
Modules linked in: thermal processor fan button battery ac binfmt_misc
CPU:    0
EIP:    0060:[<c0318200>]    Not tainted 
EFLAGS: 00010002   (2.6.8.1)
EIP is at read_intr+0x60/0x190
eax: dff8f240   ebx: 00000000   ecx: 00000000   edx: c063b10c
esi: fffffff8   edi: 00000008   ebp: 00000008   esp: ddee9f38
ds: 007b   es: 007b   ss: 0068
Process klogd (pid: 1778, threadinfo=ddee8000 task=dde12dd0)
Stack: c063b10c 00000001 00000008 dde12dd0 ddee8000 c063b10c 00000286 dff8f240
       c030e59c c063b10c 00515380 c03181a0 c063b060 dfd0af60 04000001 00000000
       ddee9fc4 c010850a 0000000e dff8f240 ddee9fc4 ddee8000 0000000e c05b4100
Call Trace:
 [<c030e59c>] ide_intr+0x11c/0x1e0
 [<c03181a0>] read_intr+0x0/0x190
 [<c010850a>] handle_IRQ_event+0x3a/0x70
 [<c01088d3>] do_IRQ+0xa3/0x170
 [<c0106b28>] common_interrupt+0x18/0x20
Code: 8b 73 18 89 ef 39 ee 0f 46 fe 29 fd 8b 53 38 0f b7 42 1a 8b
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing
--------------010606030806030302000105--
