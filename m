Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbSLTPjV>; Fri, 20 Dec 2002 10:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbSLTPjV>; Fri, 20 Dec 2002 10:39:21 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:1958 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S262602AbSLTPjS>; Fri, 20 Dec 2002 10:39:18 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C0101F55D@usslc-exch-4.slc.unisys.com>
From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mbligh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with m
	ore than 8 CPUs
Date: Fri, 20 Dec 2002 09:46:19 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Dec 19, 2002 at 06:04:55PM -0800, James Cleverdon wrote:
> >>> A generic patch should also support Unisys' new box, the ES7000 or
> >>> some such.
> 
> On Fri, Dec 20, 2002 at 08:00:50AM +0000, Christoph Hellwig wrote:
> >> That box needs more changes than just the apic setup.  Unfortunately
> >> unisys thinks they shouldn't send their patches to lkml, but when you
see
> >> them e.g. in the suse tree it's a bit understandable that they don't
want
> >> anyone to really see their mess :)

No need to sugar-coat anything :-)

Natalie is the engineer who added support for the ES7000 to Linux.
Fortunately she is in the cube next to me.

She has sent the patches to SuSe/United Linux, and is in the final process
of testing them on 2.5.5x before submitting them to LKML for comment.

> >> And btw, the box isn't that new, but three years ago or so when they
first
> >> showed it on cebit they even refused to talk about linux due to their
> >> restrictive agreements with Microsoft..
>
> On Fri, Dec 20, 2002 at 03:24:01AM -0800, William Lee Irwin III wrote:
> > Kevin, you're the only lkml-posting contact point I know of within
Unisys.
> > Is there any chance you could flag down some of the ia32 crew there for
> > some commentary on this stuff? (or do so yourself if you're in it)

I mostly work on our 16-32p IA64 machines.  Natalie or someone else will
have to comment on the clustered-apic code.

I do know that a lot of the code for the ES7000 is optional, and only
required to support value-added management functionality, which is
especially useful if you are running more than one OS instance on the
machine (it supports 8 fully-independent partitions).

Also, as a clarification, our 32-processor systems are NOT NUMA: there
is a full non-blocking crossbar to memory.  So clustered APIC support
should not be dependant on NUMA.

Kevin
