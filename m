Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262203AbSJISXb>; Wed, 9 Oct 2002 14:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262204AbSJISXb>; Wed, 9 Oct 2002 14:23:31 -0400
Received: from relay.muni.cz ([147.251.4.35]:8886 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S262203AbSJISX3>;
	Wed, 9 Oct 2002 14:23:29 -0400
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Petr Konecny <pekon@fi.muni.cz>
Subject: Re: 2.5.41-ac1: Debug: sleeping function called from illegal context at include/asm/semaphore.h:145
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
Message-ID: <qwwzntnxy8b.fsf@decibel.fi.muni.cz>
Cc: akpm@digeo.com, rml@tech9.net
Date: Wed, 9 Oct 2002 18:29:08 GMT
X-Nntp-Posting-Host: decibel.fi.muni.cz
X-Url: http://www.fi.muni.cz/~pekon/
Content-Type: text/plain; charset=us-ascii
References: <20021008031136.GA1887@izno.net>
Mime-Version: 1.0
Organization: unknown
X-Muni-Virus-Test: Clean
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Martin Dahl (Martin) said:

 Martin> On my thinkpad a20m i get the following debug messages during boot:
 Martin> At IDE initialization:

 Martin> Debug: sleeping function called from illegal context at mm/slab.c:1374
 Martin> Call Trace:
 Martin> [__kmem_cache_alloc+202/208] __kmem_cache_alloc+0xca/0xd0
 Martin> [blk_init_free_list+101/224] blk_init_free_list+0x65/0xe0
 Martin> [blk_init_queue+23/256] blk_init_queue+0x17/0x100
 Martin> [ide_init_queue+57/160] ide_init_queue+0x39/0xa0
 Martin> [do_ide_request+0/48] do_ide_request+0x0/0x30
 Martin> [init_irq+462/912] init_irq+0x1ce/0x390
 Martin> [ide_intr+0/384] ide_intr+0x0/0x180
 Martin> [hwif_init+216/608] hwif_init+0xd8/0x260
 Martin> [probe_hwif_init+36/112] probe_hwif_init+0x24/0x70
 Martin> [ide_setup_pci_device+80/128] ide_setup_pci_device+0x50/0x80
 Martin> [piix_init_one+54/64] piix_init_one+0x36/0x40
 Martin> [init+53/352] init+0x35/0x160
 Martin> [init+0/352] init+0x0/0x160
 Martin> [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Same here on Dell Inspiron 5000.

Happens with CONFIG_PREEMPT=y. Disappears with CONFIG_PREEMPT=n.

                                                Petr

