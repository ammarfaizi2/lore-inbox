Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264354AbTKZWTg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 17:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbTKZWTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 17:19:36 -0500
Received: from web40909.mail.yahoo.com ([66.218.78.206]:46504 "HELO
	web40909.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264354AbTKZWTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 17:19:33 -0500
Message-ID: <20031126221933.93553.qmail@web40909.mail.yahoo.com>
Date: Wed, 26 Nov 2003 14:19:33 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: Beaver In Detox AND IEEE1394 badness message
To: Ben Collins <bcollins@debian.org>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Collins,

After loading the detoxed beaver kernel, I noticed that the IEEE1394 badness message
has changed location:

ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[e8207000-e82077ff]  Max
Packet=[2048]
Debug: sleeping function called from invalid context at mm/slab.c:1856
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c01217dc>] __might_sleep+0xab/0xcb
 [<c0153164>] kmem_cache_alloc+0x1c8/0x1cd
 [<c01221b7>] dup_task_struct+0x28/0xc9
 [<c01239d3>] copy_process+0xd9/0x10c8
 [<c014bba1>] mempool_free+0xe2/0x214
 [<c027f3db>] freed_request+0xa0/0xa8
 [<c0124a1e>] do_fork+0x5c/0x1f3
 [<c0125ec4>] call_console_drivers+0x69/0x11f
 [<c010733d>] kernel_thread+0x8e/0x96
 [<e08ded8f>] nodemgr_host_thread+0x0/0x1a8 [ieee1394]
 [<c01072a4>] kernel_thread_helper+0x0/0xb
 [<e08df2aa>] nodemgr_add_host+0x186/0x1d2 [ieee1394]
 [<e08ded8f>] nodemgr_host_thread+0x0/0x1a8 [ieee1394]
 [<e08da629>] highlevel_add_host+0x6b/0x6f [ieee1394]
 [<e08d9c40>] hpsb_add_host+0x6d/0x95 [ieee1394]
 [<e0894b43>] ohci1394_pci_probe+0x512/0x620 [ohci1394]
 [<e0891b0d>] ohci_irq_handler+0x0/0x1129 [ohci1394]
 [<c02176df>] pci_device_probe_static+0x52/0x63
 [<c021772b>] __pci_device_probe+0x3b/0x4e
 [<c021776a>] pci_device_probe+0x2c/0x4a
 [<c027a952>] bus_match+0x3f/0x6a
 [<c027aa64>] driver_attach+0x56/0x80
 [<c027ad36>] bus_add_driver+0x9f/0xb1
 [<c027b19a>] driver_register+0x8c/0x90
 [<c0217956>] pci_register_driver+0x8c/0xab
 [<e0886013>] ohci1394_init+0x13/0x3d [ohci1394]
 [<c0145b7b>] sys_init_module+0x213/0x3e6
 [<c0172a0f>] sys_read+0x42/0x63
 [<c010a171>] sysenter_past_esp+0x52/0x71

blk: queue dfd658cc, I/O limit 4095Mb (mask 0xffffffff)

The badness message appears AFTER this line:

ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[e8207000-e82077ff]  Max
Packet=[2048]

It used to appear BEFORE this line. Do the IEEE1394 fixes in the detoxed beaver
kernel have something to do with that? Or was it a fix in an earlier kernel?

TIA

Brad

=====


__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
