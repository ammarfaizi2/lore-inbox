Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263222AbTJURPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 13:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263224AbTJURPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 13:15:48 -0400
Received: from fmr06.intel.com ([134.134.136.7]:4322 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263222AbTJURPq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 13:15:46 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] 1/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Date: Tue, 21 Oct 2003 10:15:31 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6007791A@scsmsx403.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 1/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Thread-Index: AcOX03ix0oxFgZQMSYuAb4AGRwiKfQAIK3tA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Ducrot Bruno" <ducrot@poupinou.org>
Cc: <cpufreq@www.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       "linux-acpi" <linux-acpi@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Dominik Brodowski" <linux@brodo.de>
X-OriginalArrivalTime: 21 Oct 2003 17:15:32.0818 (UTC) FILETIME=[EF3FA320:01C397F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Ducrot Bruno [mailto:ducrot@poupinou.org] 
> 
> There is already a patch from Dominik Brodowski for the apci 
> p-state which IMHO
> is better at least by design.  

Are you referring to cleanup of ACPI P-state driver by Dominik?
That patch is indeed nice and clean. But that is mostly 
orthogonal to this patch. I mean, 
- SMP awareness in P-state driver 
- P-state coordination between HT siblings
will still be required even after Dominik's patch. Though exact 
location of these changes will change when applied over Dominik's 
patch.

There is a small overlap in handling MSR based P-state transitions, 
but that is a real minor change in my patch and I am reusing most 
of the existing IO based transitions code for MSR based ones.


> Your do not handle correctly 
> other processors
> than Intel.  

I am sorry. I do not understand this comment. 
- Major part of Patch 1 is adding SMP awareness, which has
nothing specific to Intel at all.
- A part of patch 1 adds MSR based transition capability. 
This is based on ACPI spec. It will work any processor 
that is ACPI compatible and again there are no specific 
checks for Intel here.


> But the HT stuff may be interresting, though.

Thanks. 
-Venkatesh
