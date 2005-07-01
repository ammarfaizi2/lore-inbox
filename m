Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263174AbVGAVRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbVGAVRa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 17:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVGAVRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 17:17:05 -0400
Received: from palrel13.hp.com ([156.153.255.238]:64915 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261576AbVGAVI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 17:08:28 -0400
Date: Fri, 1 Jul 2005 14:06:57 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org, perfmon@napali.hpl.hp.com, akpm@osdl.org,
       mikpe@csd.uu.se, david@gibson.dropbear.id.au, maynardj@us.ibm.com,
       bill.brantley@amd.com, mucci@cs.utk.edu, reeja.john@amd.com,
       brad.chen@intel.com, charles.spirakis@intel.com,
       Stephane Eranian <eranian@hpl.hp.com>,
       "Lynn, Brian" <brian_lynn@hp.com>
Subject: 2.6.12-mm2 perfmon2 patch and beta libpfm-3.2 available
Message-ID: <20050701210657.GA26014@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I am pleased to announce that I have now released an updated version
of the perfmon2 new code base. This release includes some major improvements
such as better kernel integration and a preliminary port to PPC64. This new
patch is against Andrew Morton's 2.6.12-mm2 kernel. 

As some of you know, 2.6.12-mm2 already includes the perfctr subsystem by Mikael
Pettersson on X86-64, IA-32 and PPC64.  The new perfmon patch provides seamless
integration with perfctr. In particular, the kernel hooks have been unified
between the two subsystems. On X86-64, IA-32 and also on PPC64, you can chose
which subsystem you want at kernel compile time (see Processor type and
features options).

The goal is for people to evaluate side by side the benefits of perfmon2
compared to perfctr. The short term goal is to unify the two subsystems
as we believe it is not practical, especially for developers and Linux
distributors, to have two interfaces to access the same hardware resource.

See the included ChangeLog for a summary of the many changes that went into
this new release.

I would like to thank all the people who have contributed feedback and
patches, especially David Gibson for a preliminary patch for PPC64.

In order for people to better evaluate what the perfmon interface can do
I have also released a beta version for libpfm-3.2, a helper library which
can be used by performance tools to setup the PMU counters. The library
supports all Itanium processors, X86-64 and the P6 processors (incl Pentium M).
Note that the library does NOT make any perfmon call per se, all it does is given a set
of events it returns how they should be assigned to the various counters.
Applications then make the perfmon system calls to actually access the counters.

The library is not required to access the interface. But it is used by tools such
as pfmon and PAPI on IA-64. The package comes with lots of examples
of how the library and the kernel interfaces can be used to build tools.
The examples used the exact same code for all platforms. The package includes man
pages for all entry points. 

At this point, the event tables for X86-64 and P6 processor family are partial
but there is enough to evaluate the interface. There is currently no PPC64 support
for libpfm. For practical reasons, the package also contains the header files to
program the kernel interface.

You can download the two packages at:

	ftp://ftp.hpl.hp.com/pub/linux-ia64/perfmon-new-base-050701.tar.gz
	MD5SUM: 4d6f34ddecfd9542790a06386db4f708

	ftp://ftp.hpl.hp.com/pub/linux-ia64/libpfm-3.2-050701.tar.gz
	MD5SUM: 297c3e2e536860ce3f7b6b6e1521f002

Enjoy,

-- 
-Stephane
