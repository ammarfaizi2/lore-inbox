Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946105AbWJSR04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946105AbWJSR04 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423083AbWJSR04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:26:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:51529 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1423081AbWJSR04 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:26:56 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="149065825:sNHT24424806"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Inspiron 6000 and CPU power saving
Date: Thu, 19 Oct 2006 10:26:54 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454C1A3F3@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Inspiron 6000 and CPU power saving
Thread-Index: AcbwyYksoiLhaho2RSOiXU388We4GwC2fF8Q
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Michael \(Micksa\) Slade" <micksa@knobbits.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Oct 2006 17:26:55.0129 (UTC) FILETIME=[C5DA8890:01C6F3A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Michael (Micksa) Slade
>Sent: Sunday, October 15, 2006 7:18 PM
>To: linux-kernel@vger.kernel.org
>Subject: Inspiron 6000 and CPU power saving
>
>I recently discovered that my Inspiron 6000 uses about 50% more power 
>idling in linux than in windows XP.  This means its battery life is 
>about 2/3 of what it could/should be.
>
>I guessed it might be the CPU, and did some tests.  The 
>results strongly 
>suggest as much.  These are the results I got for power consumption in 
>various situations.
>
>linux idle at 800MHz: 27W        
>linux idle at 1600MHz: 36W        
>linux raytracing at 800: 30W
>linux raytracing at 1600: 42W 
>
>windows idle (presumably 800MHz): 16W
>windows raytracing (presumably 1600MHz): 36W
>
>I've tried ubuntu dapper and ubuntu edgy, and RIP 10 (rescue disk) and 
>BBC 2.1 (rescue disk), and they all appear to have the same 
>issue.  The 
>machine's BIOS has no APM so I can't try it for comparison.
>
>I've tried noapic and "echo n > 
>/sys/module/processor/parameters/max_cstate", where n is 1 thru 4.  
>Neither appear to have any affect.
>
>I need help digging deeper.  I guess /proc/acpi/processor/CPU0/power 
>could give some insight but I'm not sure how to read the 
>numbers.  That 
>and "learn about ACPI" is all I can figure out so far.
>
>So where to from here?  I am prepared to spend a significant amount of 
>time researching and resolving the issue, so feel free to suggest 
>reading the ACPI spec or whatever if that's what it's going to take.
>
>Mick.
>

Output of 
#cat /proc/acpi/processor/CPU0/power/*
And
#cat /sys/devices/system/cpu/cpu0/cpufreq/*
Will be a good starting point.

Also, open a issue at bugme.osdl.org. It makes tracking the issues
easier that way.

Thanks,
Venki
