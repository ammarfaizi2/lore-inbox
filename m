Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274871AbTHKWmp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 18:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274896AbTHKWmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 18:42:45 -0400
Received: from fmr03.intel.com ([143.183.121.5]:64726 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S274871AbTHKWmn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 18:42:43 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Intel ICH5 APIC, ACPI problems in 2.4
Date: Mon, 11 Aug 2003 18:42:38 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FC2D@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel ICH5 APIC, ACPI problems in 2.4
Thread-Index: AcNgL1EeiqG+lZUURBGp6+1mw1zZsAAJ/NVA
From: "Brown, Len" <len.brown@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>, "LKML" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Aug 2003 22:42:40.0517 (UTC) FILETIME=[DEF09350:01C36059]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,
I've seen word of a similar failure on VIA 8235, but on those I've got
neither the hardware nor the chipset documentation -- it would be great
if I could get this to fail on hardware I actually have...

BTW. The latest stuff in
http://linux-acpi.bkbits.net:8080/linux-acpi-2.4 should be able to boot
with acpi=ht, or you can build with just CONFIG_ACPI_HT, and that will
give you HT without any other parts of ACPI.  Though if the platform has
no MPS, this option leaves the platform in XT-PIC mode since it doesn't
do IOAPIC discovery.

Feel free to dump the usual info into a kernel.org bug under
component=ACPI and assign it to me.

Thanks,
-Len

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com] 
> Sent: Monday, August 11, 2003 1:24 PM
> To: LKML
> Subject: Intel ICH5 APIC, ACPI problems in 2.4
> 
> 
> I have a couple uniprocessor ICH5 systems from different 
> vendors, with 
> similar behavior:
> 
> 2.6:  HyperThreading works, ACPI works, all irqs properly routed
> 
> 2.4:  HT works only works with ACPI enabled, but,
>        ACPI kills the irq routing for the external PCI slots.
>        pci=noacpi or whatever doesn't work.  !CONFIG_ACPI + "noapic"
>        fixes irq routing, but then no HT sibling appears.
> 
> It seems like kernel 2.4.22-rc is missing some ACPI and possibly some 
> APIC fixes?
> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
