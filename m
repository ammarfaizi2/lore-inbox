Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263294AbTJKMsz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 08:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263297AbTJKMsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 08:48:54 -0400
Received: from ulysses.news.tiscali.de ([195.185.185.36]:27908 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S263294AbTJKMsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 08:48:46 -0400
To: linux-kernel@vger.kernel.org
Path: 127.0.0.1!nobody
From: Peter Matthias <espi@epost.de>
Newsgroups: linux.kernel
Subject: Kernel 2.6.0-test7 with nForce and nvidia driver
Date: Sat, 11 Oct 2003 14:53:25 +0200
Organization: Tiscali Germany
Message-ID: <5gu8mb.2b.ln@127.0.0.1>
NNTP-Posting-Host: p62.246.122.217.tisdip.tiscali.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: ulysses.news.tiscali.de 1065876421 52379 62.246.122.217 (11 Oct 2003 12:47:01 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Sat, 11 Oct 2003 12:47:01 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I frequently get attached output on my system with dmesg. O.k. I could
disable the output by removing the line in search.c, but I think something
could be wrong, although I have no problems.

Thanks,
        Peter

BTW: Does someone know when the nvidia net driver will be ported?

Badness in pci_find_subsys at drivers/pci/search.c:132
Call Trace:
 [<c01cf3de>] pci_find_subsys+0xce/0xe0
 [<c01cf41f>] pci_find_device+0x2f/0x40
 [<c01cf2e8>] pci_find_slot+0x28/0x50
 [<dfb15de9>] os_pci_init_handle+0x39/0x70 [nvidia]
 [<df9eb2af>] __nvsym00057+0x1f/0x24 [nvidia]
 [<dfabf56b>] __nvsym04236+0x1f/0x24 [nvidia]
 [<dfa978ad>] __nvsym03984+0x215/0x1d88 [nvidia]
 [<df9fa179>] __nvsym01540+0x49/0x90 [nvidia]
 [<dfa18fab>] __nvsym01480+0x2b/0x34 [nvidia]
 [<df9f9aa4>] __nvsym01583+0x58/0x68 [nvidia]
 [<df9f99eb>] __nvsym01528+0x27/0x48 [nvidia]
 [<dfa13927>] __nvsym02561+0x4f/0x6c [nvidia]
 [<dfa138d8>] __nvsym02561+0x0/0x6c [nvidia]
 [<dfb0cf06>] __nvsym05233+0x2e/0x40c [nvidia]
 [<df9fa0fa>] __nvsym01580+0x3a/0x70 [nvidia]
 [<df9fa0fa>] __nvsym01580+0x3a/0x70 [nvidia]
 [<df9fa0fa>] __nvsym01580+0x3a/0x70 [nvidia]
 [<c011490e>] recalc_task_prio+0x7e/0x180
 [<df9fa0fa>] __nvsym01580+0x3a/0x70 [nvidia]
 [<df9fa0fa>] __nvsym01580+0x3a/0x70 [nvidia]
 [<dfa96be7>] __nvsym03978+0x3b/0x58 [nvidia]
 [<dfa9a9ec>] __nvsym03993+0x15cc/0x15d8 [nvidia]
 [<dfa975e6>] __nvsym03986+0x21a/0x2cc [nvidia]
 [<dfa9d0ad>] __nvsym04031+0xc5/0x418 [nvidia]
 [<dfa9cfa0>] __nvsym04015+0x68/0xb0 [nvidia]
 [<dfa9276d>] __nvsym00610+0x85/0x954 [nvidia]
 [<df9ef044>] rm_isr+0x10/0x14 [nvidia]
 [<dfb13f95>] nv_kern_isr+0x65/0x70 [nvidia]
 [<c010a9ca>] handle_IRQ_event+0x3a/0x70
 [<dfac21ba>] __nvsym00688+0x16a/0x338 [nvidia]
 [<df9ec64a>] __nvsym00257+0x12/0x18 [nvidia]
 [<df9ed9b9>] __nvsym00827+0xd/0x1c [nvidia]
 [<df9ef054>] rm_isr_bh+0xc/0x10 [nvidia]
 [<c011bf66>] tasklet_action+0x46/0x70
 [<c011bd93>] do_softirq+0x93/0xa0
 [<c010ad08>] do_IRQ+0xc8/0xf0
 [<c0106e70>] default_idle+0x0/0x30
 [<c0105000>] _stext+0x0/0x30
 [<c010920c>] common_interrupt+0x18/0x20
 [<c0106e70>] default_idle+0x0/0x30
 [<c0105000>] _stext+0x0/0x30
 [<c0106e94>] default_idle+0x24/0x30
 [<c0106f10>] cpu_idle+0x30/0x40
 [<c033668f>] start_kernel+0x13f/0x150
 [<c0336420>] unknown_bootoption+0x0/0x100

Badness in pci_find_subsys at drivers/pci/search.c:132
Call Trace:
 [<c01cf3de>] pci_find_subsys+0xce/0xe0
 [<c01cf41f>] pci_find_device+0x2f/0x40
 [<c01cf2e8>] pci_find_slot+0x28/0x50
 [<dfb15de9>] os_pci_init_handle+0x39/0x70 [nvidia]
 [<df9eb2af>] __nvsym00057+0x1f/0x24 [nvidia]
 [<dfabf56b>] __nvsym04236+0x1f/0x24 [nvidia]
 [<dfa978ad>] __nvsym03984+0x215/0x1d88 [nvidia]
 [<df9f9aa4>] __nvsym01583+0x58/0x68 [nvidia]
 [<df9f99eb>] __nvsym01528+0x27/0x48 [nvidia]
 [<c0114b96>] wake_up_process_kick+0x26/0x30
 [<c0154272>] send_sigio_to_task+0xf2/0x130
 [<df9fa0fa>] __nvsym01580+0x3a/0x70 [nvidia]
 [<df9fa0fa>] __nvsym01580+0x3a/0x70 [nvidia]
 [<df9fa0fa>] __nvsym01580+0x3a/0x70 [nvidia]
 [<df9fa0fa>] __nvsym01580+0x3a/0x70 [nvidia]
 [<df9fa0fa>] __nvsym01580+0x3a/0x70 [nvidia]
 [<dfa18ee4>] __nvsym01575+0x28/0x34 [nvidia]
 [<c011490e>] recalc_task_prio+0x7e/0x180
 [<c011490e>] recalc_task_prio+0x7e/0x180
 [<dfa9a9ec>] __nvsym03993+0x15cc/0x15d8 [nvidia]
 [<c0115831>] __wake_up_common+0x31/0x50
 [<dfa975e6>] __nvsym03986+0x21a/0x2cc [nvidia]
 [<dfa9d0ad>] __nvsym04031+0xc5/0x418 [nvidia]
 [<dfa9cfa0>] __nvsym04015+0x68/0xb0 [nvidia]
 [<dfa9276d>] __nvsym00610+0x85/0x954 [nvidia]
 [<c026625a>] sock_aio_read+0xca/0xe0
 [<c0143f9c>] do_sync_read+0x8c/0xc0
 [<dfac21ba>] __nvsym00688+0x16a/0x338 [nvidia]
 [<df9ed9b9>] __nvsym00827+0xd/0x1c [nvidia]
 [<df9ef054>] rm_isr_bh+0xc/0x10 [nvidia]
 [<c011bf66>] tasklet_action+0x46/0x70
 [<c011bd93>] do_softirq+0x93/0xa0
 [<c010ad08>] do_IRQ+0xc8/0xf0
 [<c010920c>] common_interrupt+0x18/0x20


Badness in pci_find_subsys at drivers/pci/search.c:132
Call Trace:
 [<c01cf3de>] pci_find_subsys+0xce/0xe0
 [<c01cf41f>] pci_find_device+0x2f/0x40
 [<c01cf2e8>] pci_find_slot+0x28/0x50
 [<dfb15de9>] os_pci_init_handle+0x39/0x70 [nvidia]
 [<df9eb2af>] __nvsym00057+0x1f/0x24 [nvidia]
 [<dfabf56b>] __nvsym04236+0x1f/0x24 [nvidia]
 [<dfa978ad>] __nvsym03984+0x215/0x1d88 [nvidia]
 [<c01157fa>] default_wake_function+0x2a/0x30
 [<c0115831>] __wake_up_common+0x31/0x50
 [<c01efa20>] as_antic_stop+0x30/0x70
 [<c01f0b3b>] as_add_request+0x19b/0x200
 [<c01eae22>] get_request+0x1a2/0x250
 [<c01e8ca9>] __elv_add_request+0x29/0x40
 [<c01eb772>] __make_request+0x262/0x550
 [<c01ebb69>] generic_make_request+0x109/0x190
 [<c01ca01f>] radix_tree_node_alloc+0x1f/0x60
 [<c01ca11f>] radix_tree_extend+0x3f/0x70
 [<c01ca1f1>] radix_tree_insert+0xa1/0xb0
 [<c01ebc2d>] submit_bio+0x3d/0x80
 [<c016189e>] mpage_bio_submit+0x2e/0x40
 [<c011490e>] recalc_task_prio+0x7e/0x180
 [<c02695a7>] alloc_skb+0x47/0xe0
 [<dfa9a9ec>] __nvsym03993+0x15cc/0x15d8 [nvidia]
 [<dfa975e6>] __nvsym03986+0x21a/0x2cc [nvidia]
 [<dfa9d0ad>] __nvsym04031+0xc5/0x418 [nvidia]
 [<dfa9cfa0>] __nvsym04015+0x68/0xb0 [nvidia]
 [<dfa9276d>] __nvsym00610+0x85/0x954 [nvidia]
 [<c0131aef>] __alloc_pages+0xaf/0x350
 [<c0143f9c>] do_sync_read+0x8c/0xc0
 [<dfac21ba>] __nvsym00688+0x16a/0x338 [nvidia]
 [<df9ed9b9>] __nvsym00827+0xd/0x1c [nvidia]
 [<df9ef054>] rm_isr_bh+0xc/0x10 [nvidia]
 [<c011bf66>] tasklet_action+0x46/0x70
 [<c011bd93>] do_softirq+0x93/0xa0
 [<c010ad08>] do_IRQ+0xc8/0xf0
 [<c010920c>] common_interrupt+0x18/0x20

