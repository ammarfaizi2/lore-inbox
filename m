Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267195AbUG1PDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUG1PDb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267197AbUG1PDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:03:31 -0400
Received: from jade.spiritone.com ([216.99.193.136]:50391 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267195AbUG1PD1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:03:27 -0400
Date: Wed, 28 Jul 2004 08:01:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: colpatch@us.ibm.com, Jesse Barnes <jbarnes@engr.sgi.com>
cc: Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       LSE Tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] [RFC][PATCH] Change pcibus_to_cpumask() to	pcibus_to_node()
Message-ID: <82510000.1091026879@[10.10.2.4]>
In-Reply-To: <1090953179.18747.19.camel@arrakis>
References: <1090887007.16676.18.camel@arrakis> <20040727105145.A18533@infradead.org> <200407270822.43870.jbarnes@engr.sgi.com> <1090953179.18747.19.camel@arrakis>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I wonder though if we shouldn't add
>> 
>>   ...
>> # ifdef CONFIG_NUMA
>>   int node; /* or nodemask_t if necessary */
>> # endif
>>   ...
>> 
>> to struct pci_bus instead?  That would make the existing code paths a little 
>> faster and avoid the need for a global array, which tends to lead to TLB 
>> misses.
> 
> I like that idea!  Stick a nodemask_t in struct pci_bus, initialize it
> to NODE_MASK_ALL.  If a particular arch wants to put something more
> accurate in there, then great, if not, we're just in the same boat we're
> in now.
> 
> Anyone else have opinions one way or the other on Jesse's idea?

Sounds great - if it's possible to add it to something more generic than
PCI, that'd be even better, but pci would still be very useful.

M.

