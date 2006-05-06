Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWEFDhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWEFDhY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 23:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWEFDhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 23:37:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:47434 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750780AbWEFDhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 23:37:24 -0400
Message-Id: <4sur0l$vjssd@fmsmga001.fm.intel.com>
X-IronPort-AV: i="4.05,94,1146466800"; 
   d="scan'208"; a="33158029:sNHT14898079"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Brian Twichell'" <tbrian@us.ibm.com>,
       "Dave McCracken" <dmccr@us.ibm.com>
Cc: "Hugh Dickins" <hugh@veritas.com>,
       "Linux Memory Management" <linux-mm@kvack.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>, <slpratt@us.ibm.com>
Subject: RE: [PATCH 0/2][RFC] New version of shared page tables
Date: Fri, 5 May 2006 20:37:22 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZweeDqzIek7EM8T2Gn+33yBpU68AAQyudA
In-Reply-To: <445BA6B2.4030807@us.ibm.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Twichell wrote on Friday, May 05, 2006 12:26 PM
> We also measured the benefit of shared pagetables on our larger setups.  
> On our 4-way x86-64 setup with 64 GB memory, using small pages for the 
> bufferpools, shared pagetables provided a 33% increase in transaction 
> throughput.  Using hugepages for the bufferpools, shared pagetables 
> provided a 3% increase.  Performance with small pages and shared 
> pagetables was within 4% of the performance using hugepages without 
> shared pagetables.
> 
> On our ppc64 setups we used both Oracle and DB2 to evaluate the benefit 
> of shared pagetables.  When database bufferpools were in small pages, 
> shared pagetables provided an increase in database transaction 
> throughput in the range of 60-65%, while in the hugepage case the 
> improvement was up to 2.4%.


I would also like to add that I have run this set of patches on ia64 and
observed similar performance upside. We have multiple data points showing
that this feature benefits several architectures.  I'm advocating for the
upstream inclusion.

- Ken
