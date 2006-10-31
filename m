Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423710AbWJaRYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423710AbWJaRYR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423703AbWJaRYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:24:17 -0500
Received: from mail-dub.bigfish.com ([213.199.154.10]:48525 "EHLO
	mail36-dub-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1423711AbWJaRYP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:24:15 -0500
X-BigFish: VP
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: x86-64 with nvidia MCP51 chipset: kernel does not find HPET
Date: Tue, 31 Oct 2006 11:24:02 -0600
Message-ID: <1449F58C868D8D4E9C72945771150BDF153784@SAUSEXMB1.amd.com>
In-Reply-To: <1162234845.27037.37.camel@mindpipe>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: x86-64 with nvidia MCP51 chipset: kernel does not find
 HPET
Thread-Index: Acb8Vjl53HD0tZWxSGC/r5MMqP/NLQAuuZOw
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: "Lee Revell" <rlrevell@joe-job.com>
cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Clemens Ladisch" <clemens@ladisch.de>
X-OriginalArrivalTime: 31 Oct 2006 17:24:02.0092 (UTC)
 FILETIME=[5BAC2EC0:01C6FD11]
X-WSS-ID: 695959380Z41149297-02-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > > If the hardware is not providing the HPET description in ACPI,
> > there's little you can do, and most vendors do not provide
> > the HPET description.
> > 
> > Do you know if there's an entry for HPET in the ACPI?
> 
> I'm not exactly an ACPI expert, but I do not think there is 
> an entry for HPET in the ACPI, as the check in
> arch/x86_64/kernel/io_apic.c fails:
>
> But, with some help from anonymous sources, I have been able 
> to find the HPET and make it work using a userspace driver
> that pokes registers by mmap'ing /dev/mem.  So we just need
> a way to tell the kernel it's there.
> Presumably this would require a PCI quirk.
> 
> Is this likely to be worth the trouble?

It's not a general purpose solution, but if you can write
up the quirk, Andi might be willing to white list the 
machine in question.

-Mark Langsdorf
AMD, Inc.


