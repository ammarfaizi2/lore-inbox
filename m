Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269589AbTHFPst (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 11:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269639AbTHFPst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 11:48:49 -0400
Received: from fmr03.intel.com ([143.183.121.5]:56319 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S269589AbTHFPsr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 11:48:47 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: 2.6.0-test2 on Dell PE2650, ACPI_HT_ONLY strangeness
Date: Wed, 6 Aug 2003 11:48:43 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FC08@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.0-test2 on Dell PE2650, ACPI_HT_ONLY strangeness
Thread-Index: AcNcKVXdiGRAbjJBRX+ds8312sFa0wACAznA
From: "Brown, Len" <len.brown@intel.com>
To: "Mikael Pettersson" <mikpe@csd.uu.se>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Aug 2003 15:48:45.0312 (UTC) FILETIME=[37F04800:01C35C32]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're right.

This was an ill-fated attempt at backwards compatibility.
I removed acpismp=force in an ACPI cleanup a short time ago, and it
should
hit the tree via the ACPI maintainer after Andy returns from vacation.

Cheers,
-Len

> -----Original Message-----
> From: Mikael Pettersson [mailto:mikpe@csd.uu.se] 
> Sent: Wednesday, August 06, 2003 10:40 AM
> To: linux-kernel@vger.kernel.org
> Subject: 2.6.0-test2 on Dell PE2650, ACPI_HT_ONLY strangeness
> 
> 
> Before upgrading our PowerEdge 2650 (dual HT Xeons, Tigon3,
> aic7899, workspace on sw raid5 over 4 disks, ext3) to RH9,
> I gave 2.6.0-test2 a spin. Worked fine, except for one thing.
> 
> In 2.4, CONFIG_SMP automatically uses acpitable.c to detect
> secondary threads via the MADT (since MPS doesn't handle them).
> 
> In 2.6.0-test2, with CONFIG_SMP and CONFIG_ACPI_HT_ONLY, this
> doesn't happen, _unless_ I also pass acpismp=force on the command
> line. Without acpismp=force, it only finds two CPUs.
> 
> The logic in arch/i386/kernel/setup.c, which defaults acpi to
> disabled if HT_ONLY is chosen, seems backwards. Surely if I
> configure HT_ONLY it's because I want to use it, no?
> 
> /Mikael
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
