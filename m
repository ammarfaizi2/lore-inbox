Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbTJXVIm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 17:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbTJXVIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 17:08:42 -0400
Received: from fmr06.intel.com ([134.134.136.7]:14243 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262617AbTJXVIl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 17:08:41 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: Re: Avoid Pagefaults -- Variable Size Pages
Date: Fri, 24 Oct 2003 14:07:52 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0F36E8@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: Avoid Pagefaults -- Variable Size Pages
Thread-Index: AcOacuMsC18etbNHT42n9W4WktNHDw==
From: "Luck, Tony" <tony.luck@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Oct 2003 21:07:53.0287 (UTC) FILETIME=[E3A7A570:01C39A72]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Also, at least with Intel boxes, there is one page size, period.
> There is no such thing as a large page and a small page.

Intel (x86) mmu allows you to put a page table entry in the linux
upper level table.  Which provides for a page size of 4MB (2MB when
using PAE).  This mechanism is used by the HUGETLB page code in
Linux, which can provide substanstial performance gains by reducing
the number of TLB misses for applications that randomly access large
amounts of memory.

Intel Itanium systems support a boatload of page sizes from 4K to 4G.

-Tony Luck  

