Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268721AbUHTUYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268721AbUHTUYK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268723AbUHTUYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:24:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4042 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268721AbUHTUXi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:23:38 -0400
Message-ID: <41265DBD.8020103@pobox.com>
Date: Fri, 20 Aug 2004 16:23:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bero@arklinux.org
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1 "modprobe tg3" oopses with gcc 3.4.1
References: <200408201148.48206.bero@arklinux.org>
In-Reply-To: <200408201148.48206.bero@arklinux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bero@arklinux.org wrote:
> EIP is at add_pin_to_irq+0x0/0x60
> eax: 00000014   ebx: 00000001   ecx: 00000080  edx: 00000020
> esi: 00000014   edi: ccba0de0   ebp: 00000000  esp: ccba0db0
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 7179, threadinfo=ccba0000 task=dad64030)
> Stack: c01175a4 00000014 00000000 00000014 00200292 c1482640 00000001 c027df3d
>         00000000 00000000 0001a900 01000000 00000014 00000014 00000000 0000000
>         c01154a7 00000000 00000014 00000014 00000001 00000001 00100000 
> 00000000
> Call Trace:
> [<c01175a4>] io_apic_set_pci_routing+0x1f4/0x220
> [<c027df3d>] pci_read+0x3d/0x50
> [<c01154a7>] mp_register_gsi+0x177/0x180
> [<c01131f9>] acpi_register_gsi+0x89/0x90
> [<c01fbf30>] acpi_pci_irq_enable+0x100/0x160
> [<c01db988>] pci_enable_device_bars+0x28/0x40
> [<c01db9bf>] pci_enable_device+0x1f/0x40
> [<e0d18465>] tg3_init_one+0x25/0x770 [tg3]


Something in the irq resource path...

	Jeff


