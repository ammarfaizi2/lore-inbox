Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbSLVGuu>; Sun, 22 Dec 2002 01:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbSLVGuu>; Sun, 22 Dec 2002 01:50:50 -0500
Received: from fmr01.intel.com ([192.55.52.18]:45002 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S264818AbSLVGut> convert rfc822-to-8bit;
	Sun, 22 Dec 2002 01:50:49 -0500
content-class: urn:content-classes:message
Subject: [PATCHSET][2.4]  generic support for systems with more than 8 CPUs (0/2)
Date: Sat, 21 Dec 2002 22:58:54 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1912E1B1@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-MS-Has-Attach: 
Content-Transfer-Encoding: 7BIT
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.4]  generic cluster APIC support for systems with more than 8 CPUs
Thread-Index: AcKoq5AZeN8SXBSdEdewVABQi2jYqAA19A6g
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "James Cleverdon" <jamesclv@us.ibm.com>,
       "John Stultz" <johnstul@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
X-OriginalArrivalTime: 22 Dec 2002 06:58:55.0070 (UTC) FILETIME=[97B50FE0:01C2A987]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Second attempt at 2.4 patch to support more than 8 CPU, non-NUMA systems in a generic way.

The main change since the first version is to use the physical destination APIC mode 
on such systems (reusing the summit code). This has made the patch simple, small and confined.

Now, I will only be looking at using the clustered APIC mode in the context of 2.5,
mainly due to the amount of change that it requires.

The patch set is as follows:
1/2 : checking for xAPIC support in the system
2/2 : switching to physical mode APIC setup in case of more than 8 CPU system

Thanks,
-Venkatesh


