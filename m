Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273090AbTG3Rcc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 13:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273091AbTG3Rcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 13:32:31 -0400
Received: from modemcable198.171-130-66.que.mc.videotron.ca ([66.130.171.198]:12161
	"EHLO gaston") by vger.kernel.org with ESMTP id S273090AbTG3Rca
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 13:32:30 -0400
Subject: mremap sleeping in incorrect context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059586337.2420.44.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 30 Jul 2003 13:32:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just had that in my log, running 2.6.0-test2. I'm not familiar
with this code, but Arjan says this is an old problem that was
fixed ages ago, maybe the fix was lost ?

Debug: sleeping function called from invalid context at
mm/page_alloc.c:545
Call trace:
 [c000c1a8] dump_stack+0x18/0x28
 [c0021044] __might_sleep+0x6c/0x84
 [c004e33c] __alloc_pages+0x338/0x33c
 [c0014940] pte_alloc_one+0x24/0x160
 [c005c224] pte_alloc_map+0x88/0x2a8
 [c0065a40] move_one_page+0xd0/0x2a4
 [c0065c6c] move_page_tables+0x58/0xb8
 [c0065d60] move_vma+0x94/0x824
 [c00666f4] do_mremap+0x204/0x468
 [c00669d4] sys_mremap+0x7c/0xcc
 [c0007a5c] ret_from_syscall+0x0/0x44


Ben.

