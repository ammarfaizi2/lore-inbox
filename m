Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbSIXX5X>; Tue, 24 Sep 2002 19:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbSIXX5W>; Tue, 24 Sep 2002 19:57:22 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:4778 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261854AbSIXX5W>;
	Tue, 24 Sep 2002 19:57:22 -0400
Message-ID: <3D90FC6C.2060301@us.ibm.com>
Date: Tue, 24 Sep 2002 16:59:40 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Erich Focht <efocht@ess.nec.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
References: <200209211159.41751.efocht@ess.nec.de> <73440311.1032684750@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> A few comments ... mainly just i386 arch things (which aren't
> really your fault, was just a lack of the mechanisms being in
> mainline), and a request to push a couple of things down into
> the arch trees from rearing their ugly head into generic code ;-)


<SNIP>

>>+extern int pnode_to_lnode[NR_NODES];
>>+extern char lnode_number[NR_CPUS] __cacheline_aligned;
> 
> Can't you push all this down into the arch ....
> 
>>+#define CPU_TO_NODE(cpu) lnode_number[cpu]
> 
> ... by letting them define cpu_to_node() themselves?
> (most people don't have lnodes and pnodes, etc).
Yep... Sorry to get into the thread late, but Erich, you should really 
look at the latest in-kernel topology API stuff in the mm tree.  I'd be 
happy to discuss it with you over email...  Plus, I'd get another user 
of the topology (to help push it into mainline) and ia64 support, and 
you'd get a generic topology mechanism that works (err, will work?) for 
all architectures.  Email me for more info, or just check out the patch 
that Martin pointed to! :)

Cheers!

-Matt

