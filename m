Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161053AbWIGROB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbWIGROB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 13:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWIGROB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 13:14:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:26250 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1161053AbWIGRN6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 13:13:58 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,226,1154934000"; 
   d="scan'208"; a="127167646:sNHT2912357980"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: + acpi-mwait-c-state-fixes.patch added to -mm tree
Date: Thu, 7 Sep 2006 10:13:19 -0700
Message-ID: <EB12A50964762B4D8111D55B764A84548CCE12@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: + acpi-mwait-c-state-fixes.patch added to -mm tree
Thread-Index: AcbQdLGIM+03dcrbR+WV1GhvnhD6cACKnOsg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Alexey Dobriyan" <adobriyan@gmail.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Sep 2006 17:13:20.0305 (UTC) FILETIME=[EAD4C210:01C6D2A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Alexey Dobriyan [mailto:adobriyan@gmail.com] 
>Sent: Monday, September 04, 2006 3:52 PM
>To: linux-kernel@vger.kernel.org
>Cc: Pallipadi, Venkatesh
>Subject: Re: + acpi-mwait-c-state-fixes.patch added to -mm tree
>
>On Sun, Sep 03, 2006 at 05:52:20PM -0700, akpm@osdl.org wrote:
>> The patch titled
>>
>>      acpi: mwait/C-state support
>>
>> has been added to the -mm tree.
>
>> --- a/arch/i386/kernel/acpi/cstate.c~acpi-mwait-c-state-fixes
>> +++ a/arch/i386/kernel/acpi/cstate.c
>
>> +/* The code below handles cstate entry with monitor-mwait 
>pair on Intel*/
>> +
>> +struct cstate_entry_s {
>
>If suffix "_s" stands for "struct", it should be removed. 
>You've already
>typed "struct".

Agreed. The dangling _s is a redundant carry over from an earlier
version of the patch. It was there as I had used same name cstate_entry
for a variable and I wanted to make sure differentiate the structure and
variable and not to inadvarently misuse them. It can be safely removed
now.

>
>> +	struct {
>> +		unsigned int eax;
>> +		unsigned int ecx;
>> +	} states[ACPI_PROCESSOR_MAX_POWER];
>> +};
>
>> +static inline void acpi_processor_ffh_cstate_enter(
>> +		struct acpi_processor_cx *cstate)
>> +{
>> +	return;
>> +}
>
>Just
>	{
>	}
>

Agreed again. Infact, just '{}' will do as well.. As both the issues are
coding style/cosmetic kind I will hold onto sending a updates until the
patch goes mainline. Will send changes through trivial list at that
time.

Thanks for reviewing.
Venki
