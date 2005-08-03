Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVHCOtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVHCOtD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 10:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbVHCOtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 10:49:02 -0400
Received: from fmr15.intel.com ([192.55.52.69]:29569 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261938AbVHCOtA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 10:49:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Automatically enable bigsmp when we have more than 8 CPUs
Date: Wed, 3 Aug 2005 07:48:18 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6005598C0A@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Automatically enable bigsmp when we have more than 8 CPUs
Thread-Index: AcWYFPjBTxDp+YoYRs6jJ/4OvkImkwAJKOkg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Andrew Morton" <akpm@osdl.org>, "Shah, Rajesh" <rajesh.shah@intel.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
X-OriginalArrivalTime: 03 Aug 2005 14:48:20.0387 (UTC) FILETIME=[640A9F30:01C5983A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Andi Kleen [mailto:ak@suse.de] 
>Sent: Wednesday, August 03, 2005 3:20 AM
>To: Pallipadi, Venkatesh
>Cc: Andrew Morton; Andi Kleen; Shah, Rajesh; linux-kernel
>Subject: Re: [PATCH] Automatically enable bigsmp when we have 
>more than 8 CPUs
>
>On Thu, Jul 28, 2005 at 11:51:42AM -0700, Venkatesh Pallipadi wrote:
>>  				smp_found_config = 1;
>> -				clustered_apic_check();
>
>Removing that here will break x86-64.
>

Yes. Ashok sent another patch to fix this part. Lkml subjectline
[patch 1/8] x86_64: Reintroduce clustered_apic_check() for x86_64

>>  
>> +#ifdef CONFIG_X86_GENERICARCH
>> +	generic_apic_probe(*cmdline_p);
>> +#endif        
>
>This move looks risky because ACPI can already switch subarchs. Are you
>sure the command line option still works? Testing on summit and es7000
>would be good.
>

Yes. We also saw some potential issues with ACPI ioapic detection on
other sub-archs after this change, late yesteraday. I am right now 
reworking this patch.

Andrew: Until I send a reworked patch can you remove these two patces
from 
the mm. Thanks.
1) [PATCH] Automatically enable bigsmp when we have more than 8 CPUs
2) [patch 1/8] x86_64: Reintroduce clustered_apic_check() for x86_64

Thanks,
Venki
