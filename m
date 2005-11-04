Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030580AbVKDBRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030580AbVKDBRD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030573AbVKDBRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 20:17:02 -0500
Received: from dvhart.com ([64.146.134.43]:176 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1030504AbVKDBRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 20:17:00 -0500
Date: Thu, 03 Nov 2005 17:16:55 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andy Nelson <andy@thermo.lanl.gov>, torvalds@osdl.org
Cc: akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mel@csn.ul.ie, mingo@elte.hu,
       nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <58210000.1131067015@flay>
In-Reply-To: <20051104010021.4180A184531@thermo.lanl.gov>
References: <20051104010021.4180A184531@thermo.lanl.gov>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus writes:
> 
>> Just face it - people who want memory hotplug had better know that 
>> beforehand (and let's be honest - in practice it's only going to work in 
>> virtualized environments or in environments where you can insert the new 
>> bank of memory and copy it over and remove the old one with hw support).
>> 
>> Same as hugetlb.
>> 
>> Nobody sane _cares_. Nobody sane is asking for these things. Only people 
>> with special needs are asking for it, and they know their needs.
> 
> 
> Hello, my name is Andy. I am insane. I am one of the CRAZY PEOPLE you wrote
> about.

To provide a slightly shorter version ... we had one customer running
similarly large number crunching things in Fortran. Their app ran 25%
faster with large pages (not a typo). Because they ran a variety of
jobs in batch mode, they need large pages sometimes, and small pages
at others - hence they need to dynamically resize the pool. 

That's the sort of thing we were trying to fix with dynamically sized
hugepage pools. It does make a huge difference to real-world customers.

M.

