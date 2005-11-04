Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161089AbVKDHo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbVKDHo0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 02:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161092AbVKDHo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 02:44:26 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:28829 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1161089AbVKDHoZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 02:44:25 -0500
Message-ID: <436B1150.2010001@cosmosbay.com>
Date: Fri, 04 Nov 2005 08:44:16 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, andy@thermo.lanl.gov,
       mbligh@mbligh.org, akpm@osdl.org, arjan@infradead.org,
       arjanv@infradead.org, haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mel@csn.ul.ie, mingo@elte.hu,
       nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <20051104010021.4180A184531@thermo.lanl.gov>	<Pine.LNX.4.64.0511032105110.27915@g5.osdl.org> <20051103221037.33ae0f53.pj@sgi.com>
In-Reply-To: <20051103221037.33ae0f53.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson a écrit :
> Linus wrote:
> 
>>Maybe you'd be willing on compromising by using a few kernel boot-time 
>>command line options for your not-very-common load.
> 
> 
> If we were only a few options away from running Andy's varying load
> mix with something close to ideal performance, we'd be in fat city,
> and Andy would never have been driven to write that rant.

I found hugetlb support in linux not very practical/usable on NUMA machines, 
boot-time parameters or /proc/sys/vm/nr_hugepages.

With this single integer parameter, you cannot allocate 1000 4MB pages on one 
specific node, letting small pages on another node.

I'm not an astrophysician, nor a DB admin, I'm only trying to partition a dual 
node machine between one (numa aware) memory intensive job and all others 
(system, network, shells).
At least I can reboot it if needed, but I feel Andy pain.

There is a /proc/buddyinfo file, maybe we need a /proc/sys/vm/node_hugepages 
with a list of integers (one per node) ?

Eric
