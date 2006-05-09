Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWEIVFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWEIVFb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 17:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWEIVFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 17:05:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:17442 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750808AbWEIVFa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 17:05:30 -0400
X-IronPort-AV: i="4.05,107,1146466800"; 
   d="scan'208"; a="33858613:sNHT2316935341"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 2/3] swiotlb: create __alloc_bootmem_low_nopanic and add support in SWIOTLB
Date: Tue, 9 May 2006 14:04:08 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0670403C@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/3] swiotlb: create __alloc_bootmem_low_nopanic and add support in SWIOTLB
Thread-Index: AcZzp3+Hah+p0LzQS060rOsybR08rQAA/5zQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Jon Mason" <jdmason@us.ibm.com>
Cc: "Muli Ben-Yehuda" <muli@il.ibm.com>, <linux-kernel@vger.kernel.org>,
       <ak@suse.de>, <linux-ia64@vger.kernel.org>, <mulix@mulix.org>
X-OriginalArrivalTime: 09 May 2006 21:04:09.0779 (UTC) FILETIME=[1DC70830:01C673AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I "fixed" it with the hack below.  Please let me know if this is not
> palatable for you.

Not really.  The only use of platform_dma_init() that I can see is in
arch/ia64/mm/init.c:mem_init() ...

	platform_dma_init();

so "void" looks to be the right return value.  Why did it get changed to
be "int" (here's where I admit that I've only looked superficially at your
patch).

-Tony
