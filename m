Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751815AbWFWRf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbWFWRf4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 13:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWFWRfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 13:35:55 -0400
Received: from mga03.intel.com ([143.182.124.21]:30224 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751815AbWFWRfz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 13:35:55 -0400
X-IronPort-AV: i="4.06,169,1149490800"; 
   d="scan'208"; a="56571092:sNHT33017901"
Subject: RE: [PATCH] Fix cpufreq_{conservative,ondemand} compilation
Date: Fri, 23 Jun 2006 10:20:23 -0700
Message-ID: <EB12A50964762B4D8111D55B764A84541D47D3@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Thread-Topic: [PATCH] Fix cpufreq_{conservative,ondemand} compilation
Thread-Index: AcaWraUXbrrROngjRhiC/8G4HD5W2wAO4i2A
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Content-class: urn:content-classes:message
To: "Jean Delvare" <khali@linux-fr.org>
X-MimeOLE: Produced By Microsoft Exchange V6.5
Cc: "LKML" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Jun 2006 17:35:54.0197 (UTC) FILETIME=[7A6B4850:01C696EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the patch. Yes, I had missed this warning as some other patch
in my local tree was adding cpu.h to cpufreq_ondemand.c

Thanks,
Venki 

>-----Original Message-----
>From: Jean Delvare [mailto:khali@linux-fr.org] 
>Sent: Friday, June 23, 2006 3:13 AM
>To: Pallipadi, Venkatesh
>Cc: LKML
>Subject: [PATCH] Fix cpufreq_{conservative,ondemand} compilation
>
>Fix cpufreq_conservative and cpufreq_ondemand, which were using
>{lock,unlock}_cpu_hotplug without including linux/cpu.h which defines
>them.
>
>Signed-off-by: Jean Delvare <khali@linux-fr.org>
>---
> drivers/cpufreq/cpufreq_conservative.c |    1 +
> drivers/cpufreq/cpufreq_ondemand.c     |    1 +
> 2 files changed, 2 insertions(+)
>
>--- 
>linux-2.6.17-git.orig/drivers/cpufreq/cpufreq_conservative.c	
>2006-06-23 10:24:17.000000000 +0200
>+++ linux-2.6.17-git/drivers/cpufreq/cpufreq_conservative.c	
>2006-06-23 12:07:42.000000000 +0200
>@@ -17,6 +17,7 @@
> #include <linux/init.h>
> #include <linux/interrupt.h>
> #include <linux/ctype.h>
>+#include <linux/cpu.h>
> #include <linux/cpufreq.h>
> #include <linux/sysctl.h>
> #include <linux/types.h>
>--- linux-2.6.17-git.orig/drivers/cpufreq/cpufreq_ondemand.c	
>2006-06-23 10:24:17.000000000 +0200
>+++ linux-2.6.17-git/drivers/cpufreq/cpufreq_ondemand.c	
>2006-06-23 12:07:34.000000000 +0200
>@@ -16,6 +16,7 @@
> #include <linux/init.h>
> #include <linux/interrupt.h>
> #include <linux/ctype.h>
>+#include <linux/cpu.h>
> #include <linux/cpufreq.h>
> #include <linux/sysctl.h>
> #include <linux/types.h>
>
>
>-- 
>Jean Delvare
>
