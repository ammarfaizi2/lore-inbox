Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266049AbUAUSq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 13:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266072AbUAUSq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 13:46:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:56227 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266049AbUAUSqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 13:46:38 -0500
X-Authenticated: #4512188
Message-ID: <400EC908.4020801@gmx.de>
Date: Wed, 21 Jan 2004 19:46:32 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.1-mm4
References: <20040115225948.6b994a48.akpm@osdl.org> <4007B03C.4090106@gmx.de>
In-Reply-To: <4007B03C.4090106@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here is the stack backtrace:

I hope it helps, otherwise I could try compiling in frame-pointers. (I 
used another logger to get this...)

Is it nvidia driver doing something bad (which earlier kernels didn't do)?

Jan 21 19:25:39 tachyon Badness in pci_find_subsys at 
drivers/pci/search.c:132
Jan 21 19:25:39 tachyon Call Trace:
Jan 21 19:25:39 tachyon [<c027a7f8>] pci_find_subsys+0xe8/0xf0
Jan 21 19:25:39 tachyon [<c027a82f>] pci_find_device+0x2f/0x40
Jan 21 19:25:39 tachyon [<c027a6e8>] pci_find_slot+0x28/0x50
Jan 21 19:25:39 tachyon [<f9faf9f9>] os_pci_init_handle+0x35/0x62 [nvidia]
Jan 21 19:25:39 tachyon [<f9fc978f>] _nv001243rm+0x1f/0x24 [nvidia]
Jan 21 19:25:39 tachyon [<fa10ffb5>] _nv000816rm+0x2f5/0x384 [nvidia]
Jan 21 19:25:39 tachyon [<fa0787cc>] _nv003801rm+0xd8/0x100 [nvidia]
Jan 21 19:25:39 tachyon [<fa10faef>] _nv000809rm+0x2f/0x34 [nvidia]
Jan 21 19:25:39 tachyon [<fa0795f0>] _nv003816rm+0xf0/0x104 [nvidia]
Jan 21 19:25:39 tachyon [<fa077c9d>] _nv003795rm+0x4d9/0xaec [nvidia]
Jan 21 19:25:39 tachyon [<f9fe2197>] _nv004046rm+0x3a3/0x3b0 [nvidia]
Jan 21 19:25:39 tachyon [<fa0e3a47>] _nv001476rm+0x277/0x45c [nvidia]
Jan 21 19:25:39 tachyon [<f9fcc2ca>] _nv000896rm+0x4a/0x64 [nvidia]
Jan 21 19:25:39 tachyon [<f9fcdae4>] rm_isr_bh+0xc/0x10 [nvidia]
Jan 21 19:25:39 tachyon [<f9facd93>] nv_kern_isr_bh+0x11/0x15 [nvidia]
Jan 21 19:25:39 tachyon [<c0126576>] tasklet_action+0x46/0x70
Jan 21 19:25:39 tachyon [<c0126390>] do_softirq+0x90/0xa0
Jan 21 19:25:39 tachyon [<c010cced>] do_IRQ+0xfd/0x130
Jan 21 19:25:39 tachyon [<c0107000>] rest_init+0x0/0x60
Jan 21 19:25:39 tachyon [<c03f77d4>] common_interrupt+0x18/0x20
Jan 21 19:25:39 tachyon [<c0107000>] rest_init+0x0/0x60
Jan 21 19:25:39 tachyon [<c0109053>] default_idle+0x23/0x30
Jan 21 19:25:39 tachyon [<c01090bc>] cpu_idle+0x2c/0x40
Jan 21 19:25:39 tachyon [<c05026dc>] start_kernel+0x17c/0x1b0
Jan 21 19:25:39 tachyon [<c0502430>] unknown_bootoption+0x0/0x100
Jan 21 19:25:39 tachyon
Jan 21 19:25:39 tachyon Badness in pci_find_subsys at 
drivers/pci/search.c:132
Jan 21 19:25:39 tachyon Call Trace:
Jan 21 19:25:39 tachyon [<c027a7f8>] pci_find_subsys+0xe8/0xf0
Jan 21 19:25:39 tachyon [<c027a82f>] pci_find_device+0x2f/0x40
Jan 21 19:25:39 tachyon [<c027a6e8>] pci_find_slot+0x28/0x50
Jan 21 19:25:39 tachyon [<f9faf9f9>] os_pci_init_handle+0x35/0x62 [nvidia]
Jan 21 19:25:39 tachyon [<fa0964ff>] _nv001613rm+0x6f/0x7c [nvidia]
Jan 21 19:25:39 tachyon [<f9fc978f>] _nv001243rm+0x1f/0x24 [nvidia]
Jan 21 19:25:39 tachyon [<fa07a8fd>] _nv003797rm+0xa9/0x128 [nvidia]
Jan 21 19:25:39 tachyon [<fa0e7341>] _nv001490rm+0x55/0xe4 [nvidia]
Jan 21 19:25:39 tachyon [<fa10fff4>] _nv000816rm+0x334/0x384 [nvidia]
Jan 21 19:25:39 tachyon [<fa0787cc>] _nv003801rm+0xd8/0x100 [nvidia]
Jan 21 19:25:39 tachyon [<fa10faef>] _nv000809rm+0x2f/0x34 [nvidia]
Jan 21 19:25:39 tachyon [<fa0795f0>] _nv003816rm+0xf0/0x104 [nvidia]
Jan 21 19:25:39 tachyon [<fa077c9d>] _nv003795rm+0x4d9/0xaec [nvidia]
Jan 21 19:25:39 tachyon [<f9fe2197>] _nv004046rm+0x3a3/0x3b0 [nvidia]
Jan 21 19:25:39 tachyon [<fa0e3a47>] _nv001476rm+0x277/0x45c [nvidia]
Jan 21 19:25:39 tachyon [<f9fcc2ca>] _nv000896rm+0x4a/0x64 [nvidia]
Jan 21 19:25:39 tachyon [<f9fcdae4>] rm_isr_bh+0xc/0x10 [nvidia]
Jan 21 19:25:39 tachyon [<f9facd93>] nv_kern_isr_bh+0x11/0x15 [nvidia]
Jan 21 19:25:39 tachyon [<c0126576>] tasklet_action+0x46/0x70
Jan 21 19:25:39 tachyon [<c0126390>] do_softirq+0x90/0xa0
Jan 21 19:25:39 tachyon [<c010cced>] do_IRQ+0xfd/0x130
Jan 21 19:25:39 tachyon [<c0107000>] rest_init+0x0/0x60
Jan 21 19:25:39 tachyon [<c03f77d4>] common_interrupt+0x18/0x20
Jan 21 19:25:39 tachyon [<c0107000>] rest_init+0x0/0x60
Jan 21 19:25:39 tachyon [<c0109053>] default_idle+0x23/0x30
Jan 21 19:25:39 tachyon [<c01090bc>] cpu_idle+0x2c/0x40
Jan 21 19:25:39 tachyon [<c05026dc>] start_kernel+0x17c/0x1b0
Jan 21 19:25:39 tachyon [<c0502430>] unknown_bootoption+0x0/0x100
Jan 21 19:25:39 tachyon
Jan 21 19:25:39 tachyon Badness in pci_find_subsys at 
drivers/pci/search.c:132
Jan 21 19:25:39 tachyon Call Trace:
Jan 21 19:25:39 tachyon [<c027a7f8>] pci_find_subsys+0xe8/0xf0
Jan 21 19:25:39 tachyon [<c027a82f>] pci_find_device+0x2f/0x40
Jan 21 19:25:39 tachyon [<c027a6e8>] pci_find_slot+0x28/0x50
Jan 21 19:25:39 tachyon [<f9faf9f9>] os_pci_init_handle+0x35/0x62 [nvidia]
Jan 21 19:25:39 tachyon [<f9fc978f>] _nv001243rm+0x1f/0x24 [nvidia]
Jan 21 19:25:39 tachyon [<fa10ffb5>] _nv000816rm+0x2f5/0x384 [nvidia]
Jan 21 19:25:39 tachyon [<fa0787cc>] _nv003801rm+0xd8/0x100 [nvidia]
Jan 21 19:25:39 tachyon [<fa10faef>] _nv000809rm+0x2f/0x34 [nvidia]
Jan 21 19:25:39 tachyon [<fa0795f0>] _nv003816rm+0xf0/0x104 [nvidia]
Jan 21 19:25:39 tachyon [<fa077eae>] _nv003795rm+0x6ea/0xaec [nvidia]
Jan 21 19:25:39 tachyon [<f9fe2197>] _nv004046rm+0x3a3/0x3b0 [nvidia]
Jan 21 19:25:39 tachyon [<fa0e3a47>] _nv001476rm+0x277/0x45c [nvidia]
Jan 21 19:25:39 tachyon [<f9fcc2ca>] _nv000896rm+0x4a/0x64 [nvidia]
Jan 21 19:25:39 tachyon [<f9fcdae4>] rm_isr_bh+0xc/0x10 [nvidia]
Jan 21 19:25:39 tachyon [<f9facd93>] nv_kern_isr_bh+0x11/0x15 [nvidia]
Jan 21 19:25:39 tachyon [<c0126576>] tasklet_action+0x46/0x70
Jan 21 19:25:39 tachyon [<c0126390>] do_softirq+0x90/0xa0
Jan 21 19:25:39 tachyon [<c010cced>] do_IRQ+0xfd/0x130
Jan 21 19:25:39 tachyon [<c0107000>] rest_init+0x0/0x60
Jan 21 19:25:39 tachyon [<c03f77d4>] common_interrupt+0x18/0x20
Jan 21 19:25:39 tachyon [<c0107000>] rest_init+0x0/0x60
Jan 21 19:25:39 tachyon [<c0109053>] default_idle+0x23/0x30
Jan 21 19:25:39 tachyon [<c01090bc>] cpu_idle+0x2c/0x40
Jan 21 19:25:39 tachyon [<c05026dc>] start_kernel+0x17c/0x1b0
Jan 21 19:25:39 tachyon [<c0502430>] unknown_bootoption+0x0/0x100
Jan 21 19:25:39 tachyon
Jan 21 19:25:39 tachyon Badness in pci_find_subsys at 
drivers/pci/search.c:132
Jan 21 19:25:39 tachyon Call Trace:
Jan 21 19:25:39 tachyon [<c027a7f8>] pci_find_subsys+0xe8/0xf0
Jan 21 19:25:39 tachyon [<c027a82f>] pci_find_device+0x2f/0x40
Jan 21 19:25:39 tachyon [<c027a6e8>] pci_find_slot+0x28/0x50
Jan 21 19:25:39 tachyon [<f9faf9f9>] os_pci_init_handle+0x35/0x62 [nvidia]
Jan 21 19:25:39 tachyon [<fa0964ff>] _nv001613rm+0x6f/0x7c [nvidia]
Jan 21 19:25:39 tachyon [<f9fc978f>] _nv001243rm+0x1f/0x24 [nvidia]
Jan 21 19:25:39 tachyon [<fa07a8fd>] _nv003797rm+0xa9/0x128 [nvidia]
Jan 21 19:25:39 tachyon [<fa0e7341>] _nv001490rm+0x55/0xe4 [nvidia]
Jan 21 19:25:39 tachyon [<fa10fff4>] _nv000816rm+0x334/0x384 [nvidia]
Jan 21 19:25:39 tachyon [<fa0787cc>] _nv003801rm+0xd8/0x100 [nvidia]
Jan 21 19:25:39 tachyon [<fa10faef>] _nv000809rm+0x2f/0x34 [nvidia]
Jan 21 19:25:39 tachyon [<fa0795f0>] _nv003816rm+0xf0/0x104 [nvidia]
Jan 21 19:25:39 tachyon [<fa077eae>] _nv003795rm+0x6ea/0xaec [nvidia]
Jan 21 19:25:39 tachyon [<f9fe2197>] _nv004046rm+0x3a3/0x3b0 [nvidia]
Jan 21 19:25:39 tachyon [<fa0e3a47>] _nv001476rm+0x277/0x45c [nvidia]
Jan 21 19:25:39 tachyon [<f9fcc2ca>] _nv000896rm+0x4a/0x64 [nvidia]
Jan 21 19:25:39 tachyon [<f9fcdae4>] rm_isr_bh+0xc/0x10 [nvidia]
Jan 21 19:25:39 tachyon [<f9facd93>] nv_kern_isr_bh+0x11/0x15 [nvidia]
Jan 21 19:25:39 tachyon [<c0126576>] tasklet_action+0x46/0x70
Jan 21 19:25:39 tachyon [<c0126390>] do_softirq+0x90/0xa0
Jan 21 19:25:39 tachyon [<c010cced>] do_IRQ+0xfd/0x130
Jan 21 19:25:39 tachyon [<c0107000>] rest_init+0x0/0x60
Jan 21 19:25:39 tachyon [<c03f77d4>] common_interrupt+0x18/0x20
Jan 21 19:25:39 tachyon [<c0107000>] rest_init+0x0/0x60
Jan 21 19:25:39 tachyon [<c0109053>] default_idle+0x23/0x30
Jan 21 19:25:39 tachyon [<c01090bc>] cpu_idle+0x2c/0x40
Jan 21 19:25:39 tachyon [<c05026dc>] start_kernel+0x17c/0x1b0
Jan 21 19:25:39 tachyon [<c0502430>] unknown_bootoption+0x0/0x100
Jan 21 19:25:39 tachyon
Jan 21 19:25:39 tachyon Badness in pci_find_subsys at 
drivers/pci/search.c:132
Jan 21 19:25:39 tachyon Call Trace:
Jan 21 19:25:39 tachyon [<c027a7f8>] pci_find_subsys+0xe8/0xf0
Jan 21 19:25:39 tachyon [<c027a82f>] pci_find_device+0x2f/0x40
Jan 21 19:25:39 tachyon [<c027a6e8>] pci_find_slot+0x28/0x50
Jan 21 19:25:39 tachyon [<f9faf9f9>] os_pci_init_handle+0x35/0x62 [nvidia]
Jan 21 19:25:39 tachyon [<f9fc978f>] _nv001243rm+0x1f/0x24 [nvidia]
Jan 21 19:25:39 tachyon [<fa10ffb5>] _nv000816rm+0x2f5/0x384 [nvidia]
Jan 21 19:25:39 tachyon [<fa0787cc>] _nv003801rm+0xd8/0x100 [nvidia]
Jan 21 19:25:39 tachyon [<fa10faef>] _nv000809rm+0x2f/0x34 [nvidia]
Jan 21 19:25:39 tachyon [<fa0795f0>] _nv003816rm+0xf0/0x104 [nvidia]
Jan 21 19:25:39 tachyon [<fa07802b>] _nv003795rm+0x867/0xaec [nvidia]
Jan 21 19:25:39 tachyon [<f9fe2197>] _nv004046rm+0x3a3/0x3b0 [nvidia]
Jan 21 19:25:39 tachyon [<fa0e3a47>] _nv001476rm+0x277/0x45c [nvidia]
Jan 21 19:25:39 tachyon [<f9fcc2ca>] _nv000896rm+0x4a/0x64 [nvidia]
Jan 21 19:25:39 tachyon [<f9fcdae4>] rm_isr_bh+0xc/0x10 [nvidia]
Jan 21 19:25:39 tachyon [<f9facd93>] nv_kern_isr_bh+0x11/0x15 [nvidia]
Jan 21 19:25:39 tachyon [<c0126576>] tasklet_action+0x46/0x70
Jan 21 19:25:39 tachyon [<c0126390>] do_softirq+0x90/0xa0
Jan 21 19:25:39 tachyon [<c010cced>] do_IRQ+0xfd/0x130
Jan 21 19:25:39 tachyon [<c0107000>] rest_init+0x0/0x60
Jan 21 19:25:39 tachyon [<c03f77d4>] common_interrupt+0x18/0x20
Jan 21 19:25:39 tachyon [<c0107000>] rest_init+0x0/0x60
Jan 21 19:25:39 tachyon [<c0109053>] default_idle+0x23/0x30
Jan 21 19:25:39 tachyon [<c01090bc>] cpu_idle+0x2c/0x40
Jan 21 19:25:39 tachyon [<c05026dc>] start_kernel+0x17c/0x1b0
Jan 21 19:25:39 tachyon [<c0502430>] unknown_bootoption+0x0/0x100
Jan 21 19:25:39 tachyon
Jan 21 19:25:39 tachyon Badness in pci_find_subsys at 
drivers/pci/search.c:132
Jan 21 19:25:39 tachyon Call Trace:
Jan 21 19:25:39 tachyon [<c027a7f8>] pci_find_subsys+0xe8/0xf0
Jan 21 19:25:39 tachyon [<c027a82f>] pci_find_device+0x2f/0x40
Jan 21 19:25:39 tachyon [<c027a6e8>] pci_find_slot+0x28/0x50
Jan 21 19:25:39 tachyon [<f9faf9f9>] os_pci_init_handle+0x35/0x62 [nvidia]
Jan 21 19:25:39 tachyon [<fa0964ff>] _nv001613rm+0x6f/0x7c [nvidia]
Jan 21 19:25:39 tachyon [<f9fc978f>] _nv001243rm+0x1f/0x24 [nvidia]
Jan 21 19:25:39 tachyon [<fa07a8fd>] _nv003797rm+0xa9/0x128 [nvidia]
Jan 21 19:25:39 tachyon [<fa0e7341>] _nv001490rm+0x55/0xe4 [nvidia]
Jan 21 19:25:39 tachyon [<fa10fff4>] _nv000816rm+0x334/0x384 [nvidia]
Jan 21 19:25:39 tachyon [<fa0787cc>] _nv003801rm+0xd8/0x100 [nvidia]
Jan 21 19:25:39 tachyon [<fa10faef>] _nv000809rm+0x2f/0x34 [nvidia]
Jan 21 19:25:39 tachyon [<fa0795f0>] _nv003816rm+0xf0/0x104 [nvidia]
Jan 21 19:25:39 tachyon [<fa07802b>] _nv003795rm+0x867/0xaec [nvidia]
Jan 21 19:25:39 tachyon [<f9fe2197>] _nv004046rm+0x3a3/0x3b0 [nvidia]
Jan 21 19:25:39 tachyon [<fa0e3a47>] _nv001476rm+0x277/0x45c [nvidia]
Jan 21 19:25:39 tachyon [<f9fcc2ca>] _nv000896rm+0x4a/0x64 [nvidia]
Jan 21 19:25:39 tachyon [<f9fcdae4>] rm_isr_bh+0xc/0x10 [nvidia]
Jan 21 19:25:39 tachyon [<f9facd93>] nv_kern_isr_bh+0x11/0x15 [nvidia]
Jan 21 19:25:39 tachyon [<c0126576>] tasklet_action+0x46/0x70
Jan 21 19:25:39 tachyon [<c0126390>] do_softirq+0x90/0xa0
Jan 21 19:25:39 tachyon [<c010cced>] do_IRQ+0xfd/0x130
Jan 21 19:25:39 tachyon [<c0107000>] rest_init+0x0/0x60
Jan 21 19:25:39 tachyon [<c03f77d4>] common_interrupt+0x18/0x20
Jan 21 19:25:39 tachyon [<c0107000>] rest_init+0x0/0x60
Jan 21 19:25:39 tachyon [<c0109053>] default_idle+0x23/0x30
Jan 21 19:25:39 tachyon [<c01090bc>] cpu_idle+0x2c/0x40
Jan 21 19:25:39 tachyon [<c05026dc>] start_kernel+0x17c/0x1b0
Jan 21 19:25:39 tachyon [<c0502430>] unknown_bootoption+0x0/0x100
Jan 21 19:25:39 tachyon

