Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030735AbWKORfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030735AbWKORfW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030737AbWKORfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:35:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:63126 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1030735AbWKORfT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:35:19 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,425,1157353200"; 
   d="scan'208"; a="162102916:sNHT20649342"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: CPUFREQ does not get enabled
Date: Wed, 15 Nov 2006 09:35:15 -0800
Message-ID: <EB12A50964762B4D8111D55B764A8454E4122C@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CPUFREQ does not get enabled
Thread-Index: AccI22dvvIBvzKJ6RZCxIVgv01qc8wAAGfPA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Dhaval Giani" <dhaval.giani@gmail.com>
Cc: <davej@codemonkey.org.uk>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Nov 2006 17:35:17.0542 (UTC) FILETIME=[6A77EC60:01C708DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Dhaval Giani [mailto:dhaval.giani@gmail.com] 
>Sent: Wednesday, November 15, 2006 9:28 AM
>To: Pallipadi, Venkatesh
>Cc: davej@codemonkey.org.uk; linux-kernel@vger.kernel.org
>Subject: Re: CPUFREQ does not get enabled
>
>Hey
>
>On 11/15/06, Pallipadi, Venkatesh 
><venkatesh.pallipadi@intel.com> wrote:
>>
>> Can you compile in this option
>> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
>> And try again.
>>
>
>Done and it still does not work. BTW, the help says that
>X86_SPEEDSTEP_CENTRINO is deprecated and to use X86_ACPI_CPUFREQ which
>is why I did not enable it.
>

Yes. It is different in different kernels. If you are using base 2.6.18,
then you still need both the drivers.
If you are using mm (slated to go to base kernel in future) then both
are required.

Couple of things that will help in root causing this:
1) Enable CPU_FREQ_DEBUG and boot with "cpufreq.debug=7" and capture the
dmesg.
2) Capture acpidump (You can find acpidump in latest version of pmtools
here http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/ )
and send the output to me.

Better still, open a bug in bugme.osdl.org in ACPI category. That will
help us to track this failure better and close on it quicker.

Thanks,
Venki
