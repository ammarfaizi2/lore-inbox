Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265557AbUAWLri (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 06:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266215AbUAWLri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 06:47:38 -0500
Received: from medusa.csi-inc.com ([204.17.222.19]:14722 "EHLO
	medusa.csi-inc.com") by vger.kernel.org with ESMTP id S265557AbUAWLrg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 06:47:36 -0500
Message-ID: <000701c3e1a6$ac762330$c8de11cc@black>
From: "Mike Black" <mblack@csi-inc.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: 2.1.6 st.o sleeping invalid context
Date: Fri, 23 Jan 2004 06:47:26 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Testing 2.6.1 and got the following message during boot -- apparently when loading the st.o module -- although the modules still
loads successfully.

Jan 23 06:41:49 yeti kernel: Debug: sleeping function called from invalid context at mm/slab.c:1856
Jan 23 06:41:49 yeti kernel: in_atomic():1, irqs_disabled():0
Jan 23 06:41:49 yeti kernel: Call Trace:
Jan 23 06:41:49 yeti kernel:  [<c011da0c>] __might_sleep+0xab/0xc9
Jan 23 06:41:49 yeti kernel:  [<c0142a4a>] kmem_cache_alloc+0x74/0x76
Jan 23 06:41:49 yeti kernel:  [<c0162e81>] cdev_alloc+0x24/0x5e
Jan 23 06:41:49 yeti kernel:  [<f8871743>] st_probe+0x3f4/0x7c1 [st]
Jan 23 06:41:49 yeti kernel:  [<c018f7b0>] init_dir+0x0/0x22
Jan 23 06:41:49 yeti kernel:  [<c01f7d29>] bus_match+0x3d/0x65
Jan 23 06:41:49 yeti kernel:  [<c01f7e42>] driver_attach+0x59/0x83
Jan 23 06:41:49 yeti kernel:  [<c01f810b>] bus_add_driver+0x9e/0xb1
Jan 23 06:41:49 yeti kernel:  [<f881905e>] init_st+0x5e/0x9c [st]
Jan 23 06:41:49 yeti kernel:  [<c013898f>] sys_init_module+0x13e/0x29a
Jan 23 06:41:49 yeti kernel:  [<c01091e3>] syscall_call+0x7/0xb

Michael D. Black mblack@csi-inc.com
http://www.csi-inc.com/
http://www.csi-inc.com/~mike
321-676-2923, x203
Melbourne FL

