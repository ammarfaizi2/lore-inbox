Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbTCEELQ>; Tue, 4 Mar 2003 23:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267084AbTCEELQ>; Tue, 4 Mar 2003 23:11:16 -0500
Received: from fmr09.intel.com ([192.52.57.35]:15598 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id <S267083AbTCEELP> convert rfc822-to-8bit;
	Tue, 4 Mar 2003 23:11:15 -0500
content-class: urn:content-classes:message
Subject: RE: [PATCH][IO_APIC] 2.5.63bk7 irq_balance improvments / bug-fixes
Date: Tue, 4 Mar 2003 20:21:10 -0800
Message-ID: <E88224AA79D2744187E7854CA8D9131DA8B7E0@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][IO_APIC] 2.5.63bk7 irq_balance improvments / bug-fixes
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcLiqZwk7ECO2Tr9TBKYEw35VbF7dQAI1jTg
From: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
To: "Andrew Morton" <akpm@digeo.com>
Cc: <linux-kernel@vger.kernel.org>, <kai.bankett@ontika.net>,
       <mingo@redhat.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
X-OriginalArrivalTime: 05 Mar 2003 04:21:10.0638 (UTC) FILETIME=[A69F18E0:01C2E2CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are few issues we found with the user level daemon approach.
  
   Static binding compatibility: With the user level daemon, users can
not  
use the /proc/irq/i/smp_affinity interface for the static binding of
interrupts.

  There is some information which is only available in the kernel today,
Also the future implementation might need more kernel data. This is
important for interfaces such as NAPI, where interrupts handling changes
on the fly.

Thanks,
Nitin

> Now there has been some discssion as to whether these algorithmic
> decisions
> can be moved out of the kernel altogether.  And with periods of one
and
> five
> seconds that does appear to be feasible.
> 
> I believe that you have looked at this before and encountered some
problem
> with it.  Could you please describe what happened there?
