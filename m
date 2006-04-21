Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWDULk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWDULk0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 07:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWDULk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 07:40:26 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:55983 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751270AbWDULkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 07:40:25 -0400
Date: Fri, 21 Apr 2006 13:45:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <npiggin@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Message-ID: <20060421114501.GA22570@elte.hu>
References: <20060419112130.GA22648@elte.hu> <20060420091856.GB21660@wotan.suse.de> <20060421112049.GA5609@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421112049.GA5609@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 1.3
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.3 required=5.9 tests=AWL,UNIQUE_WORDS autolearn=no SpamAssassin version=3.0.3
	2.5 UNIQUE_WORDS           BODY: Message body has many words used only once
	-1.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


disabling CONFIG_NUMA i get this one during bootup:

 Brought up 2 CPUs
 BUG: pfn: 0003fff0, page: c3308b00, order: 4
  [<c0104cd0>] show_trace+0xd/0xf
  [<c0104ce7>] dump_stack+0x15/0x17
  [<c0154a1c>] free_pages_bulk+0x155/0x246
  [<c0155673>] free_hot_cold_page+0x104/0x12c
  [<c01556da>] free_hot_page+0xa/0xc
  [<c0155706>] __free_pages+0x2a/0x35
  [<c01620ba>] __vunmap+0x95/0xc1
  [<c0162183>] vfree+0x29/0x2b
  [<c0125e46>] build_sched_domains+0xa70/0xc34
  [<c0126023>] arch_init_sched_domains+0x19/0x1b
  [<c1a1f799>] sched_init_smp+0x12/0x23
  [<c01003b2>] init+0xb9/0x2cb
  [<c0102005>] kernel_thread_helper+0x5/0xb

but otherwise no problems.

	Ingo
