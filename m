Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275284AbTHSBPy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 21:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275298AbTHSBPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 21:15:53 -0400
Received: from fmr03.intel.com ([143.183.121.5]:12277 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S275284AbTHSBPv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 21:15:51 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [SOLVED] RE: 2.6.0-test3 latest bk hangs when enabling IO-APIC
Date: Mon, 18 Aug 2003 21:15:47 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FC78@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [SOLVED] RE: 2.6.0-test3 latest bk hangs when enabling IO-APIC
Thread-Index: AcNl3iKY+5v7Tof2ToGndsU6XE+i+QAEDM8g
From: "Brown, Len" <len.brown@intel.com>
To: "Stian Jordet" <liste@jordet.nu>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Aug 2003 01:15:49.0221 (UTC) FILETIME=[6CB9C950:01C365EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_ACPI_HT is mostly just an alias for CONFIG_ACPI_BOOT -- the early
boot part of ACPI without the run-time events included in the full ACPI
implementation.  Unless I screwed up the config dependencies, it should
be impossible to enable the full CONFIG_ACPI without including
CONFIG_ACPI_HT.

When full CONFIG_ACPI is used, the cmdline "acpi=ht" can be used to
revert to just the CONFIG_ACPI_HT behaviour.

The help built into config should explain this clearly, let me know if
it doesn't.

Thanks,
-Len

Ps. The "noapic" flag is actually broken in the baseline kernel in some
cases (ACPI enabled), a fix will come with the next batch...

> -----Original Message-----
> From: Stian Jordet [mailto:liste@jordet.nu] 
> Sent: Monday, August 18, 2003 7:12 PM
> To: Brown, Len
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [SOLVED] RE: 2.6.0-test3 latest bk hangs when 
> enabling IO-APIC
> 
> 
> tir, 19.08.2003 kl. 01.06 skrev Stian Jordet:
> > man, 18.08.2003 kl. 22.06 skrev Stian Jordet:
> > > man, 18.08.2003 kl. 21.23 skrev Stian Jordet:
> > > > man, 18.08.2003 kl. 19.53 skrev Brown, Len: 
> > > > > Try booting with pci=noacpi, and if that doesn't work acpi=off
> > > > > If either of those work, then file in bugzilla with 
> component=ACPI and
> > > > > assign it to len.brown@intel.com
> > > > 
> > > > It works when booting with noapic, but not with 
> acpi=off nor pci=noapic.
> > > > Does that mean I can't blame you for it?
> > > 
> > > Just to confuse myself (and whoever reading my mails). 
> When I disabled
> > > the second onboard ide-port, the kernel booted, but usb 
> didn't work.
> > > Absolutely no problem what so ever with -test3.
> > 
> > I had to enable CONFIG_ACPI_HT=y. But you must have screwed 
> something
> > up, since my P3's really, really don't have any Hyper 
> Threading :) ACPI
> > was already enabled, and from the help texts, there shouldn't be any
> > difference with ACPI_HT then. Nevermind, I'm happy :)
> 
> Sorry for spamming, but when I think of it, I don't think acpi is
> enabled at all without the CONFIG_ACPI_HT. Because my 
> computer actually
> uses to hang when enabling io-apic without acpi support enabled (in
> other words, my pc is useless without acpi enabled).
> 
> Once again, sorry for flooding.
> 
> Best regards,
> Stian
> 
> 
