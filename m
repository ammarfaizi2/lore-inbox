Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268317AbTCFTvV>; Thu, 6 Mar 2003 14:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268321AbTCFTvV>; Thu, 6 Mar 2003 14:51:21 -0500
Received: from fmr01.intel.com ([192.55.52.18]:21222 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S268317AbTCFTvS> convert rfc822-to-8bit;
	Thu, 6 Mar 2003 14:51:18 -0500
content-class: urn:content-classes:message
Subject: RE: [PATCH][IO_APIC] 2.5.63bk7 irq_balance improvments / bug-fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Thu, 6 Mar 2003 12:01:45 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB5640133881D@fmsmsx407.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][IO_APIC] 2.5.63bk7 irq_balance improvments / bug-fixes
Thread-Index: AcLjROCRnA5p0HDsQUqTSruafYdzsQA1bVZA
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Arjan van de Ven" <arjan@fenrus.demon.nl>,
       "Kamble, Nitin A" <nitin.a.kamble@intel.com>
Cc: "Andrew Morton" <akpm@digeo.com>, <linux-kernel@vger.kernel.org>,
       <kai.bankett@ontika.net>, <mingo@redhat.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
X-OriginalArrivalTime: 06 Mar 2003 20:01:45.0679 (UTC) FILETIME=[36F0B5F0:01C2E41B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think tuning for NUMA issues are different. The intention/scope of this patch was to provide an efficient interrupt routing in software that would work for dual/SMP P4P based systems.  Although we found this improved older systems as well, there was no need to do this earlier since it was done by the chipsets in the platform and software did not have any thing to do. 

Jun

> -----Original Message-----
> From: Arjan van de Ven [mailto:arjan@fenrus.demon.nl]
> Sent: Wednesday, March 05, 2003 10:27 AM
> To: Kamble, Nitin A
> Cc: Andrew Morton; linux-kernel@vger.kernel.org; kai.bankett@ontika.net;
> mingo@redhat.com; Nakajima, Jun; Mallick, Asit K; Saxena, Sunil
> Subject: RE: [PATCH][IO_APIC] 2.5.63bk7 irq_balance improvments / bug-
> fixes
> 
> On Wed, 2003-03-05 at 05:21, Kamble, Nitin A wrote:
> > There are few issues we found with the user level daemon approach.
> >
> >    Static binding compatibility: With the user level daemon, users can
> > not
> > use the /proc/irq/i/smp_affinity interface for the static binding of
> > interrupts.
> 
> no they can just write/change the config file, with a gui if needed
> 
> >
> >   There is some information which is only available in the kernel today,
> 
> there's also some information only available to userspace today that the
> userspace daemon can and does use.
> 
> > Also the future implementation might need more kernel data. This is
> > important for interfaces such as NAPI, where interrupts handling changes
> > on the fly.
> 
> ehm. almost. but napi isn't it ....
> 
> and the userspace side can easily have a system vendor provided file
> that represents all kinds of very specific system info about the numa
> structure..... working with every kernel out there.

