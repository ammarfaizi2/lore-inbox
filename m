Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbTILWCM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 18:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbTILWCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 18:02:12 -0400
Received: from fmr09.intel.com ([192.52.57.35]:58864 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261933AbTILWCH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 18:02:07 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [2.4.23-pre3] Cache size for Centrino CPU incorrect
Date: Fri, 12 Sep 2003 15:02:03 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304A790@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.4.23-pre3] Cache size for Centrino CPU incorrect
Thread-Index: AcN5bGsEM6rmuwKaSKWTkjRJbdTNtAADDd1w
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Jan De Luyck" <lkml@kcore.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Sep 2003 22:02:03.0823 (UTC) FILETIME=[7FC693F0:01C37979]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a bit old, but try.

Thanks,
Jun
------
--- linux-2.4.21/arch/i386/kernel/setup.c	2003-06-13
07:51:29.000000000 -0700
+++ new/arch/i386/kernel/setup.c	2003-07-08 17:21:48.000000000
-0700
@@ -2246,6 +2249,8 @@
 	{ 0x83, LVL_2,      512 },
 	{ 0x84, LVL_2,      1024 },
 	{ 0x85, LVL_2,      2048 },
+	{ 0x86, LVL_2,      512 },
+	{ 0x87, LVL_2,      1024 },
 	{ 0x00, 0, 0}
 };

> -----Original Message-----
> From: Jan De Luyck [mailto:lkml@kcore.org]
> Sent: Friday, September 12, 2003 1:18 PM
> To: linux-kernel@vger.kernel.org
> Subject: [2.4.23-pre3] Cache size for Centrino CPU incorrect
> 
> Hello List,
> 
> I just noticed this:
> 
> devilkin@precious:~$ cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 9
> model name      : Intel(R) Pentium(R) M processor 1600MHz
> stepping        : 5
> cpu MHz         : 599.511
> cache size      : 0 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov
pat
> clflush dts acpi mmx fxsr sse sse2 tm pbe tm2 est
> bogomips        : 1196.85
> 
> Somehow, the cache size doesn't seem to be correct. Spec info tells me
> that this cpu
> has indeed a 1024kb cache.
> 
> Any patches to test?
> 
> Thankx
> 
> Jan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
