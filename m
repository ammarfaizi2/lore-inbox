Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbUCYPdI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 10:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbUCYPdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 10:33:08 -0500
Received: from fmr06.intel.com ([134.134.136.7]:7143 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263207AbUCYPdB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 10:33:01 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Date: Thu, 25 Mar 2004 07:31:37 -0800
Message-ID: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Thread-Index: AcQSXuO19QT+YV2aRAe+JJ+GlUGdUwAHonUg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Andi Kleen" <ak@suse.de>, "Rick Lindsley" <ricklind@us.ibm.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, <piggin@cyberone.com.au>,
       <linux-kernel@vger.kernel.org>, <akpm@osdl.org>, <kernel@kolivas.org>,
       <rusty@rustcorp.com.au>, <anton@samba.org>,
       <lse-tech@lists.sourceforge.net>, <mbligh@aracnet.com>
X-OriginalArrivalTime: 25 Mar 2004 15:31:38.0321 (UTC) FILETIME=[43A3E410:01C4127E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

Can you be more specific with "it doesn't load balance threads
aggressively enough"? Or what behavior of the base NUMA scheduler is
missing in the sched-domain scheduler especially for NUMA?

Jun

>-----Original Message-----
>From: Andi Kleen [mailto:ak@suse.de]
>Sent: Thursday, March 25, 2004 3:47 AM
>To: Rick Lindsley
>Cc: Andi Kleen; Ingo Molnar; piggin@cyberone.com.au; linux-
>kernel@vger.kernel.org; akpm@osdl.org; kernel@kolivas.org;
>rusty@rustcorp.com.au; Nakajima, Jun; anton@samba.org; lse-
>tech@lists.sourceforge.net; mbligh@aracnet.com
>Subject: Re: [Lse-tech] [patch] sched-domain cleanups,
sched-2.6.5-rc2-mm2-
>A3
>
>On Thu, Mar 25, 2004 at 03:40:22AM -0800, Rick Lindsley wrote:
>>     The main problem it has is that it performs quite badly on
Opteron
>NUMA
>>     e.g. in the OpenMP STREAM test (much worse than the normal
scheduler)
>>
>> Andi, I've got some schedstat code which may help us to understand
why.
>> I'll need to port it to Ingo's changes, but if I drop you a patch in
a
>> day or two can you try your test on sched-domain/non-sched-domain,
>> collecting the stats?
>
>The openmp failure is already pretty well understood - it doesn't load
>balance
>threads aggressively enough over CPUs after startup.
>
>-Andi
