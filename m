Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbVKDVv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbVKDVv2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 16:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbVKDVv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 16:51:28 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:16319 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S1750954AbVKDVv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 16:51:28 -0500
To: gmaxwell@gmail.com
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Cc: akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie, mingo@elte.hu,
       nickpiggin@yahoo.com.au, torvalds@osdl.org
Message-Id: <20051104215103.E5C6C18476F@thermo.lanl.gov>
Date: Fri,  4 Nov 2005 14:51:03 -0700 (MST)
From: andy@thermo.lanl.gov (Andy Nelson)
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,

It sound like in principle I (`I'=generic HPC person) could be
happy with this sort of solution. The proof of the pudding is
in the eating however, and various perversions and misunderstanding
can still always crop up. Hopefully they can be solved or avoided
if the do show up though. Also, other folk might not be so satisfied.
I'll let them speak for themselves though.

One issue remaining is that I don't know how this hugetlbfs stuff 
that was discussed actually works or should work, in terms of 
the interface to my code. What would work for me is something to 
the effect of

f90 -flag_that_turns_access_to_big_pages_on code.f

That then substitutes in allocation calls to this hugetlbfs zone
instead of `normal' allocation calls to generic memory, and perhaps
lets me fall back to normal memory up to whatever system limits may
exist if no big pages are available.

Or even something more simple like 

setenv HEY_OS_I_WANT_BIG_PAGES_FOR_MY_JOB  

or alternatively, a similar request in a batch script.
I don't know that any of these things really have much to do
with the OS directly however.


Thanks all, and have a good weekend.

Andy




