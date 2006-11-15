Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030792AbWKOSGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030792AbWKOSGd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030782AbWKOSGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:06:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:25726 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1030792AbWKOSGb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:06:31 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,425,1157353200"; 
   d="scan'208"; a="162118897:sNHT2099281093"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.19-rc5-mm2
Date: Wed, 15 Nov 2006 10:06:23 -0800
Message-ID: <EB12A50964762B4D8111D55B764A8454E4128E@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.19-rc5-mm2
Thread-Index: AccI3i108w6wtlELTx27H5wAkWDkMQAAeUTQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Mattia Dongili" <malattia@linux.it>
Cc: <ego@in.ibm.com>, "Reuben Farrelly" <reuben-linuxkernel@reub.net>,
       "Andrew Morton" <akpm@osdl.org>, <davej@redhat.com>,
       <linux-kernel@vger.kernel.org>,
       "CPUFreq Mailing List" <cpufreq@lists.linux.org.uk>,
       "Sadykov, Denis M" <denis.m.sadykov@intel.com>
X-OriginalArrivalTime: 15 Nov 2006 18:06:25.0953 (UTC) FILETIME=[C420D110:01C708E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Mattia Dongili [mailto:malattia@linux.it] 
>Sent: Wednesday, November 15, 2006 9:47 AM
>To: Pallipadi, Venkatesh
>Cc: ego@in.ibm.com; Reuben Farrelly; Andrew Morton; 
>davej@redhat.com; linux-kernel@vger.kernel.org; CPUFreq 
>Mailing List; Sadykov, Denis M
>Subject: Re: 2.6.19-rc5-mm2
>
>On Wed, Nov 15, 2006 at 06:09:47AM -0800, Pallipadi, Venkatesh wrote:
>[...]
>> >data->cpu_feature == ACPI_ADR_SPACE_FIXED_HARDWARE.
>> 
>> Yes. Patch from Mattia is indeed required for acpi-cpufreq. 
>> Mattia: Can you please send the patch towards Andrew (With signed off
>> etc) for inclusion.
>
>Venki, I'm a little worried about the switch/case in question (line
>702): the data->cpu_feature is set either to SYSTEM_IO_CAPABLE or
>SYSTEM_INTEL_MSR_CAPABLE just a few lines above so it seems the switch
>variable is wrong and none of the 2 cases will ever get a chance to
>execute.
>

The variable is set few lines before. So, it should be OK to switch on
that 
variable set and one of the two cases will execute. isn't it? Or am 
I missing something?

>Unfortunately I don't have enough knowledge to tell if it's simply
>necessary to fix the switch variable as 

Get_cur_freq_on_cpu will not work on SYSTEM_IO space as ACPI does not
have an interface to get the current frequency. It only has a interface
to say whether the last transitions tried was successful or not.
So, if indeed a change in switch is required, first option should be
good...

Thanks,
Venki
