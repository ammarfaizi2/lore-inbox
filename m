Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTKCIXy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 03:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTKCIXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 03:23:53 -0500
Received: from [200.76.215.158] ([200.76.215.158]:260 "EHLO zion.home.mx")
	by vger.kernel.org with ESMTP id S261294AbTKCIXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 03:23:52 -0500
Date: Mon, 3 Nov 2003 02:23:09 -0600
From: Felipe Contreras <al593181@mail.mty.itesm.mx>
To: linux-kernel@vger.kernel.org
Subject: Debug: sleeping function called from invalid context at mm/slab.c:1856
Message-ID: <20031103082309.GB5878@zion.mshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Probably this is a known issue, and might be I should send this message to the
ACPI list, but I tought that considering the current state of the linux kernel
might be someone could be interested in this.

I'm getting this message about every 10 secconds. It seems to be a debug
warning, but it's annoying.

kernel: Debug: sleeping function called from invalid context at mm/slab.c:1856
kernel: in_atomic():1, irqs_disabled():0
kernel: Call Trace:
kernel:  [<c011ae0f>] __might_sleep+0xab/0xcc
kernel:  [<c013a9a5>] __kmalloc+0x93/0x9a
kernel:  [<c01bad82>] acpi_os_allocate+0x10/0x14
kernel:  [<c01ce618>] acpi_ut_callocate+0x2f/0x73
kernel:  [<c01c80d3>] acpi_ns_internalize_name+0x43/0x77
kernel:  [<c01c79fa>] acpi_ns_evaluate_relative+0x32/0xad
kernel:  [<c01c63e9>] acpi_hw_low_level_read+0x5e/0xa1
kernel:  [<c01c63e9>] acpi_hw_low_level_read+0x5e/0xa1
kernel:  [<c01c735e>] acpi_evaluate_object+0x103/0x1a5
kernel:  [<c01d35c6>] acpi_ec_gpe_query+0xd7/0xf1
kernel:  [<c01c0437>] acpi_ev_gpe_dispatch+0x34/0x109
kernel:  [<c01c02ff>] acpi_ev_gpe_detect+0xc2/0x110
kernel:  [<c01beed3>] acpi_ev_sci_xrupt_handler+0x13/0x1c
kernel:  [<c01baee7>] acpi_irq+0xf/0x1a
kernel:  [<c010b924>] handle_IRQ_event+0x39/0x62
kernel:  [<c01baed8>] acpi_irq+0x0/0x1a
kernel:  [<c010bc57>] do_IRQ+0x99/0x144
kernel:  [<c010a398>] common_interrupt+0x18/0x20
kernel:  [<c01d592b>] acpi_processor_idle+0xe9/0x1e5
kernel:  [<c0105000>] rest_init+0x0/0x60
kernel:  [<c01080b7>] cpu_idle+0x2f/0x38
kernel:  [<c0312680>] start_kernel+0x150/0x15d
kernel:  [<c031240e>] unknown_bootoption+0x0/0xf8
kernel: 

-- 
Felipe Contreras
