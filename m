Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbSLUDTA>; Fri, 20 Dec 2002 22:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbSLUDTA>; Fri, 20 Dec 2002 22:19:00 -0500
Received: from fmr01.intel.com ([192.55.52.18]:65259 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261868AbSLUDS6> convert rfc822-to-8bit;
	Fri, 20 Dec 2002 22:18:58 -0500
content-class: urn:content-classes:message
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with more than 8 CPUs
Date: Fri, 20 Dec 2002 19:27:00 -0800
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB564419EF9@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
X-MS-Has-Attach: 
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.4]  generic cluster APIC support for systems with more than 8 CPUs
Thread-Index: AcKoRSi5V+1JNxQ4EdeNCQBQi+Bs2AAUgv7Q
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "James Cleverdon" <jamesclv@us.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "John Stultz" <johnstul@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
X-OriginalArrivalTime: 21 Dec 2002 03:27:00.0740 (UTC) FILETIME=[D2F68440:01C2A8A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I share the same concerns and comments with Martin. 

As far as xAPIC mode is concerned, the changes for ES7000 in SuSe/United Linux are simply activating physical mode. And we are confident the patch we provided should work for the machine as well. Looks like ES7000 requires changes in other areas as well, though. 

Since Martin already has code in place in 2.5, we should reuse his code as much as possible. And our current plan is:

For 2.5:

- Martin posts a new patch (that moves IBM-specifc stuff to subarch, for example) next week.
- Venkatesh merges the generic cluster APIC support for systems (with more than 8 CPUs) to it, testing it on some OEM machines (I cannot tell which)

For 2.4:
- Venkatesh will post a confined patch to support APIC physical mode.

Thanks,
Jun


> -----Original Message-----
> From: Martin J. Bligh [mailto:mbligh@aracnet.com]
> Sent: Friday, December 20, 2002 8:30 AM
> To: Van Maren, Kevin; 'William Lee Irwin III'; Christoph Hellwig; James
> Cleverdon; Pallipadi, Venkatesh; Linux Kernel; John Stultz; Nakajima, Jun;
> Mallick, Asit K; Saxena, Sunil
> Cc: Protasevich, Natalie
> Subject: RE: [PATCH][2.4] generic cluster APIC support for systems with m
> ore than 8 CPUs
> 
> > Natalie is the engineer who added support for the ES7000 to Linux.
> > Fortunately she is in the cube next to me.
> >
> > She has sent the patches to SuSe/United Linux, and is in the final
> process
> > of testing them on 2.5.5x before submitting them to LKML for comment.
> 
> Are they under subarch or somehow abstracted this time, or are there
> going to be 10,000 ifdef's again? If the latter, I can predict what
> the first set of review comments you get are going to be ;-)
> 
> M.
