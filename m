Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263193AbUCYPQb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 10:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263197AbUCYPQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 10:16:31 -0500
Received: from fmr06.intel.com ([134.134.136.7]:54748 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263196AbUCYPQ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 10:16:28 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Date: Thu, 25 Mar 2004 07:15:15 -0800
Message-ID: <7F740D512C7C1046AB53446D3720017301119907@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Thread-Index: AcQSRuLJRmOAInKpT2GffMxlCepNxAAM6y/g
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Andi Kleen" <ak@suse.de>, "Ingo Molnar" <mingo@elte.hu>
Cc: <piggin@cyberone.com.au>, <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <kernel@kolivas.org>, <rusty@rustcorp.com.au>, <ricklind@us.ibm.com>,
       <anton@samba.org>, <lse-tech@lists.sourceforge.net>,
       <mbligh@aracnet.com>
X-OriginalArrivalTime: 25 Mar 2004 15:15:16.0012 (UTC) FILETIME=[FA236EC0:01C4127B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have found some performance regressions (e.g. SPECjbb) with the
scheduler on a large IA-64 NUMA machine, and we are debugging it. On SMP
machines, we haven't seen performance regressions.

Jun

>-----Original Message-----
>From: Andi Kleen [mailto:ak@suse.de]
>Sent: Wednesday, March 24, 2004 8:56 PM
>To: Ingo Molnar
>Cc: piggin@cyberone.com.au; linux-kernel@vger.kernel.org;
akpm@osdl.org;
>kernel@kolivas.org; rusty@rustcorp.com.au; Nakajima, Jun;
>ricklind@us.ibm.com; anton@samba.org; lse-tech@lists.sourceforge.net;
>mbligh@aracnet.com
>Subject: Re: [Lse-tech] [patch] sched-domain cleanups,
sched-2.6.5-rc2-mm2-
>A3
>
>On Thu, 25 Mar 2004 09:28:09 +0100
>Ingo Molnar <mingo@elte.hu> wrote:
>
>> i've reviewed the sched-domains balancing patches for upstream
inclusion
>> and they look mostly fine.
>
>The main problem it has is that it performs quite badly on Opteron NUMA
>e.g. in the OpenMP STREAM test (much worse than the normal scheduler)
>
>-Andi
