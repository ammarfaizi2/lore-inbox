Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269066AbUIHTwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269066AbUIHTwH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 15:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268686AbUIHTuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 15:50:39 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:57005 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269066AbUIHTuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 15:50:00 -0400
Message-ID: <413F6362.6000001@sgi.com>
Date: Wed, 08 Sep 2004 14:54:10 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
       piggin@cyberone.com.au
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
References: <413CB661.6030303@sgi.com> <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <cone.1094513660.210107.6110.502@pc.kolivas.org> <20040907000304.GA8083@logos.cnet> <20040907212051.GC3492@logos.cnet> <413F1518.7050608@sgi.com> <5860000.1094664673@flay>
In-Reply-To: <5860000.1094664673@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:
>>It seems to me that the 5% number in there is more or less arbitrary. 
>>If we are on a big memory Altix (4 TB), 5% of memory would be 200 GB. 
>>That is a lot of page cache.
> 
> 
> For HPC, maybe. For a fileserver, it might be far too little. That's the
> trouble ... it's all dependant on the workload. Personally, I'd prefer
> to get rid of manual tweakables (which are a pain in the ass in the field
> anyway), and try to have the kernel react to what the customer is doing.
> I guess we can leave them there for overrides, but a self-tunable default
> would be most desirable.
> 

I agree that tunables are a pain in the butt, but a quick fix would to be at 
least to add that 5% to the set of stuff settable in /proc/sys/vm.  Most
workloads/systems won't need to change it.  Very large Altix systems could 
change it if needed.

I don't think that is at the root of the swappiness problems with 
2.6.9-rc1-mm3, though.

> For instance, would be nice if we started doing writeback to the spindles
> that weren't busy much earlier than if the disks were thrashing.
> 
> M.
> 
> 

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

