Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVKDREL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVKDREL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 12:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVKDREL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 12:04:11 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:64072 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S1750729AbVKDREK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 12:04:10 -0500
To: torvalds@osdl.org
Subject: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Cc: akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie, mingo@elte.hu,
       nickpiggin@yahoo.com.au
Message-Id: <20051104170359.80947184684@thermo.lanl.gov>
Date: Fri,  4 Nov 2005 10:03:59 -0700 (MST)
From: andy@thermo.lanl.gov (Andy Nelson)
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







>On Fri, 4 Nov 2005, Andy Nelson wrote:
>> 
>> My measurements of factors of 3-4 on more than one hw arch don't
>> mean anything then?
>
>When I _know_ that modern hardware does what you tested at least two 
>orders of magnitude better than the hardware you tested?


Ok. In other posts you have skeptically accepted Power as a
`modern' architecture. I have just now dug out some numbers
of a slightly different problem running on a Power 5. Specifically
a IBM p575 I think. These tests were done in June, while the others
were done more than 2.5 years ago. In other words, there may be 
other small tuning optimizations that have gone in since then too.

The problem is a different configuration of particles, and about
2 times bigger (7Million) than the one in comp.arch (3million I think).
I would estimate that the data set in this test spans something like
2-2.5GB or so.

Here are the results:

cpus    4k pages   16m pages
1       4888.74s   2399.36s
2       2447.68s   1202.71s
4       1225.98s    617.23s
6        790.05s    418.46s
8        592.26s    310.03s
12       398.46s    210.62s
16       296.19s    161.96s
 

These numbers were on a recent Linux. I don't know which one.

Now it looks like it is down to a factor 2 or slightly more. That
is a totally different arch, that I think you have accepted as 
`modern', running the OS that you say doesn't need big page support. 

Still a bit more than insignificant I would say.


>Think about it. 

Likewise.


Andy





  
  

