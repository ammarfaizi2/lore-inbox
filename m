Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261386AbSJDBqf>; Thu, 3 Oct 2002 21:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261435AbSJDBqf>; Thu, 3 Oct 2002 21:46:35 -0400
Received: from momus.sc.intel.com ([143.183.152.8]:35320 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S261386AbSJDBqe>; Thu, 3 Oct 2002 21:46:34 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C78052F7466@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'EricAltendorf@orst.edu'" <EricAltendorf@orst.edu>,
       linux-kernel@vger.kernel.org
Subject: RE: 2.5.40: sleeping function called from illegal context
Date: Thu, 3 Oct 2002 18:51:24 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Eric Altendorf [mailto:EricAltendorf@orst.edu]
 
> [5.] Output of Oops.. message (if applicable) with symbolic 
> information resolved (see Documentation/oops-tracing.txt)
> 
> No oops, but here's the debug info:

I see something similar, but from another context:

Debug: sleeping function called from illegal context at slab.c:1374
c20f3e9c c0118b44 c02d9280 c02ddeb7 0000055e 00000000 c0136aae c02ddeb7 
       0000055e c0489834 c04897fc f7ff7c80 00000000 00000046 c0218af0
f7de47a0 
       000001d0 c04897fc c04897ec f7ff7c80 00000000 00000000 c0218b81
c04897fc 
Call Trace:
 [<c0118b44>]__might_sleep+0x54/0x58
 [<c0136aae>]kmem_cache_alloc+0x22/0x18c
 [<c0218af0>]blk_init_free_list+0x4c/0xd0
 [<c0218b81>]blk_init_queue+0xd/0xe8
 [<c0222680>]ide_init_queue+0x28/0x68
 [<c0228e40>]do_ide_request+0x0/0x18
 [<c022296d>]init_irq+0x2ad/0x36c
 [<c0222ce6>]hwif_init+0x10a/0x250
 [<c02225ac>]probe_hwif_init+0x1c/0x6c
 [<c023303d>]ide_setup_pci_device+0x3d/0x68
 [<c0221663>]svwks_init_one+0x37/0x40
 [<c01050ab>]init+0x47/0x1bc
 [<c0105064>]init+0x0/0x1bc
 [<c0105521>]kernel_thread_helper+0x5/0xc

There is no sound at all compiled in this kernel :)

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]

