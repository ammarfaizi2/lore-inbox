Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbVH2V75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbVH2V75 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 17:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVH2V75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 17:59:57 -0400
Received: from fmr14.intel.com ([192.55.52.68]:57781 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751326AbVH2V74 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 17:59:56 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [PATCH] acpi: Handle cpu_index greater than 256 properly in processor_core.c
Date: Mon, 29 Aug 2005 14:59:25 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB60059052BE@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] acpi: Handle cpu_index greater than 256 properly in processor_core.c
Thread-Index: AcWrAiLe4OWj9RF8TOWopi501nX+jgB4hOLw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Ingo Oeser" <ioe-lkml@rameria.de>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 29 Aug 2005 21:59:26.0148 (UTC) FILETIME=[EBFA0840:01C5ACE4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-----Original Message-----
>From: Ingo Oeser [mailto:ioe-lkml@rameria.de] 
>Sent: Saturday, August 27, 2005 5:23 AM
>To: Pallipadi, Venkatesh
>Cc: linux-kernel; Andrew Morton; Brown, Len
>Subject: Re: [PATCH] acpi: Handle cpu_index greater than 256 
>properly in processor_core.c
>
>Hi Venkatesh,
>
>On Saturday 27 August 2005 02:07, Venkatesh Pallipadi wrote:
>> Fix convert_acpiid_to_cpu function to handle cpu_index 
>greater than 256. This 
>> patch also prevents a warning in IA64 cross-compile of this file 
>> (drivers/acpi/processor_core.c:517: warning: comparison is 
>always false due 
>> to limited range of data type).
>
>Why don't you just change the datatype to "unsigned int" and 
>the return failure value to NR_CPUS?
>
>That reduces the code changes and leaves the code quite clear.
>It should also reduce compiled code size by some bytes, but I'm not
>sure about that one.
>

Yes. It can be done. But to me, the current patch is more cleaner. 
I don't think we should mix up the cpu_index and error return value. 

Thanks,
Venki

