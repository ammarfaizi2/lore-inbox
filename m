Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265135AbUGIKlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265135AbUGIKlN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 06:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUGIKlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 06:41:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:40900 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265135AbUGIKlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 06:41:05 -0400
Date: Fri, 9 Jul 2004 03:39:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm7
Message-Id: <20040709033950.6c7cf111.akpm@osdl.org>
In-Reply-To: <1089369159.3198.4.camel@paragon.slim>
References: <20040708235025.5f8436b7.akpm@osdl.org>
	<1089369159.3198.4.camel@paragon.slim>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurgen Kramer <gtm.kramer@inter.nl.net> wrote:
>
> On Fri, 2004-07-09 at 08:50, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/
> > 
> My EHCI controller still won't come back to life. I have tried 
> various boot options to no avail. I still gives:

Did you try "acpi=off"?

Try reverting bk-acpi.patch


> ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
> ehci_hcd 0000:00:1d.7: EHCI Host Controller
> ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 1010001)
> ehci_hcd 0000:00:1d.7: can't reset
> ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -95
> ehci_hcd: probe of 0000:00:1d.7 failed with error -95
> USB Universal Host Controller Interface driver v2.2

Try reverting bk-usb.patch, see if it fixes this one.

> Booting with 'nosmp' make it stop booting at:
> 
> <snip>
> ICH5: chipset revision 2
> ICH5: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
> hda: WDC WD1200JB-00EVA0, ATA DISK drive
> Using anticipatory io scheduler
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> 
> Jurgen
