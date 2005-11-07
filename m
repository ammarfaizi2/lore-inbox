Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbVKGQnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbVKGQnn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 11:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbVKGQnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 11:43:42 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:16038 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964870AbVKGQnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 11:43:42 -0500
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
From: Adam Litke <agl@us.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Paul Jackson <pj@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       andy@thermo.lanl.gov, mbligh@mbligh.org, akpm@osdl.org,
       arjan@infradead.org, arjanv@infradead.org, haveblue@us.ibm.com,
       kravetz@us.ibm.com, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mel@csn.ul.ie,
       mingo@elte.hu, nickpiggin@yahoo.com.au
In-Reply-To: <436B1150.2010001@cosmosbay.com>
References: <20051104010021.4180A184531@thermo.lanl.gov>
	 <Pine.LNX.4.64.0511032105110.27915@g5.osdl.org>
	 <20051103221037.33ae0f53.pj@sgi.com>  <436B1150.2010001@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-15
Organization: IBM
Date: Mon, 07 Nov 2005 10:42:54 -0600
Message-Id: <1131381774.25133.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-04 at 08:44 +0100, Eric Dumazet wrote:
> Paul Jackson a écrit :
> > Linus wrote:
> > 
> >>Maybe you'd be willing on compromising by using a few kernel boot-time 
> >>command line options for your not-very-common load.
> > 
> > 
> > If we were only a few options away from running Andy's varying load
> > mix with something close to ideal performance, we'd be in fat city,
> > and Andy would never have been driven to write that rant.
> 
> I found hugetlb support in linux not very practical/usable on NUMA machines, 
> boot-time parameters or /proc/sys/vm/nr_hugepages.
> 
> With this single integer parameter, you cannot allocate 1000 4MB pages on one 
> specific node, letting small pages on another node.
> 
> I'm not an astrophysician, nor a DB admin, I'm only trying to partition a dual 
> node machine between one (numa aware) memory intensive job and all others 
> (system, network, shells).
> At least I can reboot it if needed, but I feel Andy pain.
> 
> There is a /proc/buddyinfo file, maybe we need a /proc/sys/vm/node_hugepages 
> with a list of integers (one per node) ?

Or perhaps /sys/devices/system/node/nodeX/nr_hugepages triggers that
work like the current /proc trigger but on a per node basis?

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

