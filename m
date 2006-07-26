Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWGZRXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWGZRXm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 13:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWGZRXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 13:23:42 -0400
Received: from mga03.intel.com ([143.182.124.21]:35466 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030238AbWGZRXl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 13:23:41 -0400
X-IronPort-AV: i="4.07,185,1151910000"; 
   d="scan'208"; a="105063818:sNHT2071923315"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: smp + acpi
Date: Wed, 26 Jul 2006 13:22:52 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6011250B3@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: smp + acpi
Thread-Index: Acaw18w7sfnyi23JTLu7S9zn0d6hBwAAC4AA
From: "Brown, Len" <len.brown@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Marco Berizzi" <pupilla@hotmail.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jul 2006 17:22:55.0180 (UTC) FILETIME=[21B878C0:01C6B0D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> CONFIG_ACPI=y is necessary to parse the ACPI tables
>> and discover HT siblings.  Except for the rare BIOS
>> that gives the option to enumerate HT via MPS
>> (thus breaking some versions of Windows),
>> enabling ACPI is the only way to enable HT.
>> 
>> Yes, in the distant past, CONFIG_ACPI=n did not remove
>> all ACPI code from your kernel, and that was a bug.
>
>Ok thanks for the confirmation.
>
>However the proposed change would be still wrong because
>SMP can be without HT.

What proposed change?

I expect that the problem at hand is that CONFIG_SMP=y
is fine, but with CONFIG_ACPI=n, that isn't going to
find the HT threads on an HT system.

-Len
