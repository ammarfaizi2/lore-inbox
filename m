Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265249AbUHIEIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265249AbUHIEIB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 00:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUHIEIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 00:08:01 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:56168 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265249AbUHIEH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 00:07:56 -0400
Message-ID: <bec878da04080821071647a846@mail.gmail.com>
Date: Sun, 8 Aug 2004 21:07:52 -0700
From: "Kevin O'Shea" <mastergoon@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: nvidia oops 2.6.8-rc3-mm2
In-Reply-To: <cone.1092022093.780511.26660.502@pc.kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <bec878da04080819361445af2c@mail.gmail.com> <cone.1092022093.780511.26660.502@pc.kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That fixed it.

I now have a new error in my dmesg however (thought I'd add it here
incase its related):

kobject_register failed for sata_via (-17)
[<c0232bdb>] kobject_register+0x5b/0x60
[<c028dd00>] bus_add_driver+0x50/0xd0
[<c028e31f>] driver_register+0x2f/0x40
[<c023daec>] pci_register_driver+0x5c/0x90
[<e10bb00f>] svia_init+0xf/0x1d [sata_via]
[<c013157e>] sys_init_module+0x12e/0x280
[<c0104135>] sysenter_past_esp+0x52/0x71


Thanks for the help so far!

Kevin O'Shea
MyUID.com

On Mon, 09 Aug 2004 13:28:13 +1000, Con Kolivas <kernel@kolivas.org> wrote:
> Kevin O'Shea writes:
> 
> > I hope its ok to post about this here, but I thought it might be a
> > kernel bug not nvidia.
> >
> > This is the oops with the new 6111 driver (it worked fine on mm1).
> >
> > Thanks,
> > Kevin
> 
> > Call Trace:
> >  [<c0114375>] io_apic_set_pci_routing+0x1e5/0x210
> 
> I quote from akpm's announcement:
> 
> - If some devices mysteriously stop working, try booting with pci=routeirq.
>   If that fixes it, please send a report, Cc'ing bjorn.helgaas@hp.com.  See
>   remove-unconditional-pci-acpi-irq-routing.patch
> 
> That looks like it might help your issue too since the oops talks about pci
> routing.
> 
> Cheers,
> Con
> 
>
