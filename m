Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWCBTSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWCBTSy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWCBTSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:18:53 -0500
Received: from fmr17.intel.com ([134.134.136.16]:23175 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932508AbWCBTSv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:18:51 -0500
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 14:18:35 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30063F9006@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16rc5 'found' an extra CPU.
Thread-Index: AcY+Fq1MbJWu1+xORdqMSEc7i8B47wAF0Jxg
From: "Brown, Len" <len.brown@intel.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: "Dave Jones" <davej@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
       "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 02 Mar 2006 19:18:40.0767 (UTC) FILETIME=[1D4D70F0:01C63E2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>I have a dual core + HT platform. I disabled HT to have the 
>same situation as Dave.
>
>ACPI DSDT dump shows 4 objects in \_PR scope as below.
>
>    Scope (\_PR)
>    {
>        Processor (CPU0, 0x01, 0x00000410, 0x06) {}
>        Processor (CPU1, 0x02, 0x00000410, 0x06) {}
>        Processor (CPU2, 0x03, 0x00000410, 0x06) {}
>        Processor (CPU3, 0x04, 0x00000410, 0x06) {}
>    }
>
>Only 2 are marked enabled in the ACPI MADT..
>
>From boot log
>
>ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
>Processor #0 15:4 APIC version 20
>ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
>Processor #2 15:4 APIC version 20
>ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
>ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
>
>But proc/acpi/processor also lists just 2 entries.
>
>[root@araj-sfield-2 tmp]# ls /proc/acpi/processor/
>CPU0  CPU2


This system looks totally correct to me.
Do you see something wrong with it?

-Len
