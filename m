Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262170AbSJATod>; Tue, 1 Oct 2002 15:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262189AbSJATod>; Tue, 1 Oct 2002 15:44:33 -0400
Received: from eos.telenet-ops.be ([195.130.132.40]:57018 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S262170AbSJAToc> convert rfc822-to-8bit; Tue, 1 Oct 2002 15:44:32 -0400
X-Qmail-Scanner-Mail-From: devilkin-lkml@blindguardian.org via whocares
X-Qmail-Scanner: 1.14 (Clear:. Processed in 0.067872 secs)
Content-Type: text/plain;
  charset="us-ascii"
From: DevilKin-LKML <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 -- Debug: sleeping function called from illegal context at slab.c:1374
Date: Tue, 1 Oct 2002 21:49:54 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210012149.54663.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this error, with a backtrace. 

hda: IBM-DBCA-204860, ATA DISK drive
Debug: sleeping function called from illegal context at slab.c:1374
c7fbfea4 c0113f84 c02b2700 c02b694d 0000055e 00000000 c012d2f3 c02b694d 
       0000055e c03e9514 c03e94dc c11cf200 00000000 c01f2040 c11d31e0 000001d0 
       c03e94dc c03e94cc c11cf200 00000000 00000000 c01f20d1 c03e94dc c03e94dc 
Call Trace:
 [<c0113f84>]__might_sleep+0x54/0x60
 [<c012d2f3>]kmem_cache_alloc+0x23/0xf4
 [<c01f2040>]blk_init_free_list+0x4c/0xd0
 [<c01f20d1>]blk_init_queue+0xd/0xe8
 [<c02075c0>]ide_init_queue+0x28/0x68
 [<c020d9a4>]do_ide_request+0x0/0x18
 [<c0207898>]init_irq+0x298/0x354
 [<c0207bf6>]hwif_init+0x112/0x258
 [<c02074ec>]probe_hwif_init+0x1c/0x6c
 [<c021751d>]ide_setup_pci_device+0x3d/0x68
 [<c0105086>]init+0x2e/0x188
 [<c0105058>]init+0x0/0x188
 [<c01054a9>]kernel_thread_helper+0x5/0xc

Need something else?

DK
-- 
Lackland's Laws:
	(1) Never be first.
	(2) Never be last.
	(3) Never volunteer for anything

