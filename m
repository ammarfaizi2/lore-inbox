Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbVKEBi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbVKEBi2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 20:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVKEBi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 20:38:28 -0500
Received: from fmr24.intel.com ([143.183.121.16]:23443 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751441AbVKEBi1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 20:38:27 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Fri, 4 Nov 2005 17:37:42 -0800
Message-ID: <01EF044AAEE12F4BAAD955CB75064943051354C4@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Thread-Index: AcXhnPL/BQKDXWXhTD6aBp4FUbK0ewAClthg
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>, "Andi Kleen" <ak@suse.de>
Cc: "Gregory Maxwell" <gmaxwell@gmail.com>,
       "Andy Nelson" <andy@thermo.lanl.gov>, <mingo@elte.hu>, <akpm@osdl.org>,
       <arjan@infradead.org>, <arjanv@infradead.org>, <haveblue@us.ibm.com>,
       <kravetz@us.ibm.com>, <lhms-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
       <mbligh@mbligh.org>, <mel@csn.ul.ie>, <torvalds@osdl.org>
X-OriginalArrivalTime: 05 Nov 2005 01:37:43.0569 (UTC) FILETIME=[84532010:01C5E1A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin Friday, November 04, 2005 4:08 PM


>These are essentially the same problems that the frag patches face as
>well.

>> None of this is very attractive.
>> 

>Though it is simple and I expect it should actually do a really good
>job for the non-kernel-intensive HPC group, and the highly tuned
>database group.

Not sure how applications seamlessly can use the proposed hugetlb zone
based on hugetlbfs.  Depending on the programming language, it might
actually need changes in libs/tools etc.

As far as databases are concerned, I think they mostly already grab vast
chunks of memory to be used as hugepages (particularly for big mem
systems)which is a separate list of pages.  And actually are also glad
that kernel never looks at them for any other purpose.

-rohit
