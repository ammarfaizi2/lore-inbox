Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264806AbSLVGLR>; Sun, 22 Dec 2002 01:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264814AbSLVGLQ>; Sun, 22 Dec 2002 01:11:16 -0500
Received: from fmr01.intel.com ([192.55.52.18]:8694 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S264806AbSLVGLQ> convert rfc822-to-8bit;
	Sun, 22 Dec 2002 01:11:16 -0500
content-class: urn:content-classes:message
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with m ore than 8 CPUs
Date: Sat, 21 Dec 2002 22:19:20 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1912E1B0@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-MS-Has-Attach: 
Content-Transfer-Encoding: 7BIT
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.4]  generic cluster APIC support for systems with m ore than 8 CPUs
Thread-Index: AcKpb13RUqcwRRViEdeNCQBQi+Bs2AAEfAJg
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: "Christoph Hellwig" <hch@infradead.org>,
       "James Cleverdon" <jamesclv@us.ibm.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "John Stultz" <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
       "Andi Kleen" <ak@suse.de>, "Hubert Mantel" <mantel@suse.de>,
       "Kamble, Nitin A" <nitin.a.kamble@intel.com>
X-OriginalArrivalTime: 22 Dec 2002 06:19:21.0242 (UTC) FILETIME=[10CBA7A0:01C2A982]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Martin J. Bligh [mailto:mbligh@aracnet.com]
> > Yes, our feeling it is possible to handle all non-NUMAQ 
> systems pretty
> > generically in terms of APIC setup and interrupt routing. We can use
> > either logical clustered or physical destination modes. But 
> for NUMAQ
> > systems, interrupt routing has to know about the local 
> nodes and have
> > necessary logic to do the routing withing local node.
> 
> NUMA-Q doesn't have to know about the local nodes. I set it up to use
> physical delivery broadcast, which is a node-local broadcast ... gave
> me NUMA affinity for free. I could also use logical clustered 
> (p3 style)
> addressing, and work out all the node locality, but I don't 
> see the point.
> 

I actually meant interrupt distribution (rather than interrupt routing). AFAIK, interrupt distribution right now assumes flat logical setup and tries to distribute the interrupt. And is disabled in case of clustered APIC mode. 
I was just thinking loud, about the changes interrupt distribution code should have for systems using clustered APIC/physical mode (NUMAQ and non-NUMAQ).

Thanks,
-Venkatesh
