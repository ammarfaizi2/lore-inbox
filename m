Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWEVOrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWEVOrf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 10:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWEVOrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 10:47:35 -0400
Received: from mga03.intel.com ([143.182.124.21]:61244 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750881AbWEVOre convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 10:47:34 -0400
X-IronPort-AV: i="4.05,157,1146466800"; 
   d="scan'208"; a="39839669:sNHT51056537"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: APIC error on CPUx
Date: Mon, 22 May 2006 10:47:30 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB681D44D@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: APIC error on CPUx
Thread-Index: AcZ9m7/Mqny9BjTBSKWKm33xsIge/QAEik+g
From: "Brown, Len" <len.brown@intel.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Vladimir Dvorak" <dvorakv@vdsoft.org>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 May 2006 14:47:31.0738 (UTC) FILETIME=[A7AA5FA0:01C67DAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>The problem goes away with noapic or acpi=off, but of course that also 
>means you don't have IRQs > 15.

"acpi=off" is a superset of "noapic" here, presumably because the
board doesn't have MPS  tables that describe the IOAPIC when ACPI is
off.

"noapic" is a perfectly reasonable thing to use if you don't
have a lot of interrupt sources and there is no more sharing
in PIC mode than IOAPIC mode.

The advantage of using IOAPIC mode is that the system has more interrupt
pins
availalble and this allows sharing to be avoided.  It also allows
the system to target the interrupts to any processor when you
have more than one.

cheers,
-Len
