Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267310AbTBXSXa>; Mon, 24 Feb 2003 13:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267443AbTBXSWM>; Mon, 24 Feb 2003 13:22:12 -0500
Received: from franka.aracnet.com ([216.99.193.44]:16799 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267310AbTBXSUI>; Mon, 24 Feb 2003 13:20:08 -0500
Date: Mon, 24 Feb 2003 10:30:17 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 400] New: Highpoint 370 triggers sleeping from illegal context
 debug code.
Message-ID: <18160000.1046111417@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=400

           Summary: Highpoint 370 triggers sleeping from illegal context
                    debug code.
    Kernel Version: 2.5.62
            Status: NEW
          Severity: normal
             Owner: alan@lxorguk.ukuu.org.uk
         Submitter: davej@codemonkey.org.uk


Debug: sleeping function called from illegal context at mm/slab.c:1617
Call Trace:
 [<c0145512>] kmalloc+0xd4/0xe3
 [<c018fa23>] proc_create+0x87/0xec
 [<c018fbba>] proc_mkdir+0x2b/0x67
 [<c010c66f>] register_irq_proc+0x7e/0xc4
 [<c010c413>] setup_irq+0x132/0x165
 [<c03149b8>] ide_intr+0x0/0x2e1
 [<c010bc25>] request_irq+0x9b/0xce
 [<c0316075>] init_irq+0x188/0x526
 [<c03149b8>] ide_intr+0x0/0x2e1
 [<c031659f>] alloc_disks+0x9c/0x119
 [<c031686f>] hwif_init+0xe3/0x27b
 [<c0315d8f>] probe_hwif_init+0x2c/0x78
 [<c0328c1c>] ide_setup_pci_device+0x4e/0x74
 [<c0312108>] hpt366_init_one+0x32/0x38
 [<c01050a1>] init+0x64/0x192
 [<c010503d>] init+0x0/0x192
 [<c010737d>] kernel_thread_helper+0x5/0xb

