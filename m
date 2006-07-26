Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbWGZRIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbWGZRIz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 13:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbWGZRIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 13:08:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:3407 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030345AbWGZRIx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 13:08:53 -0400
X-IronPort-AV: i="4.07,185,1151910000"; 
   d="scan'208"; a="105048772:sNHT1550372712"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: smp + acpi
Date: Wed, 26 Jul 2006 13:07:42 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB60112506C@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: smp + acpi
Thread-Index: AcawymM2wt98mf1ZRpiImDIzWImzXQACqVMQ
From: "Brown, Len" <len.brown@intel.com>
To: "Marco Berizzi" <pupilla@hotmail.com>, <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jul 2006 17:07:47.0154 (UTC) FILETIME=[047EB320:01C6B0D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Since 2.6.15 smp doesn't work anymore without ACPI
>> > May be possible to have a note in "Symmetric multi processing
>> > support" help dialog? Or is it possible to enable ACPI when
>> > SMP is selected?
>>
>>It's probably specific to your system, nothing general.
>
>Hi Andi,
>
>Thanks for the reply. I'm compiling linux on a pentinum
>4 HT 3GHz. 2.6.14 did detect both processor, but all
>kernels > 2.6.15 did not. (at least till 2.6.17.7)

CONFIG_ACPI=y is necessary to parse the ACPI tables
and discover HT siblings.  Except for the rare BIOS
that gives the option to enumerate HT via MPS
(thus breaking some versions of Windows),
enabling ACPI is the only way to enable HT.

Yes, in the distant past, CONFIG_ACPI=n did not remove
all ACPI code from your kernel, and that was a bug.

thanks,
-Len
