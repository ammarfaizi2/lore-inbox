Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264625AbUF1BgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264625AbUF1BgN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 21:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264627AbUF1BgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 21:36:13 -0400
Received: from fmr05.intel.com ([134.134.136.6]:3776 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S264625AbUF1BgK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 21:36:10 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Subject: RE: [ACPI] No APIC interrupts after ACPI suspend
Date: Mon, 28 Jun 2004 09:35:55 +0800
Message-ID: <B44D37711ED29844BEA67908EAF36F032D5361@pdsmsx401.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] No APIC interrupts after ACPI suspend
Thread-Index: AcRcZF641UwOCqemSn+kQC5S4Z2nDAAR9R0A
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Matthew Garrett" <mjg59@srcf.ucam.org>
Cc: <linux-kernel@vger.kernel.org>, <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 28 Jun 2004 01:35:56.0242 (UTC) FILETIME=[41E01320:01C45CB0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have no suspend/resume code for IOAPIC, we should add it.
For PIC mode, current 8259 resume code ignored IRQ level/edge trigger,
and it should be added.

Thanks,
Shaohua
>-----Original Message-----
>From: acpi-devel-admin@lists.sourceforge.net [mailto:acpi-devel-
>admin@lists.sourceforge.net] On Behalf Of Matthew Garrett
>Sent: Monday, June 28, 2004 12:28 AM
>To: David Eriksson
>Cc: linux-kernel@vger.kernel.org; acpi-devel@lists.sourceforge.net
>Subject: Re: [ACPI] No APIC interrupts after ACPI suspend
>
>On Sat, 2004-06-26 at 18:42 +0200, David Eriksson wrote:
>
>> Maybe you've found this bug?
>>
>> http://bugme.osdl.org/show_bug.cgi?id=2643
>
>Yeah, that one was biting me, but it's not the one causing this bug.
>cat /proc/interrupts shows that the ACPI interrupt is correctly set to
>level triggered, but the ioapic isn't set up correctly so no interrupts
>make it through. The same seems to be true for all other
level-triggered
>interrupts.
>
>--
>Matthew Garrett | mjg59@srcf.ucam.org
>
>
>
>-------------------------------------------------------
>This SF.Net email sponsored by Black Hat Briefings & Training.
>Attend Black Hat Briefings & Training, Las Vegas July 24-29 -
>digital self defense, top technical experts, no vendor pitches,
>unmatched networking opportunities. Visit www.blackhat.com
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/acpi-devel

