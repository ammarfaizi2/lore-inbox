Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264836AbUFLPBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264836AbUFLPBD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 11:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264843AbUFLPBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 11:01:03 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:32705 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264836AbUFLPBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 11:01:01 -0400
Date: Sat, 12 Jun 2004 08:00:53 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@muc.de>, Dave Hansen <haveblue@us.ibm.com>
cc: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Permit inode & dentry hash tables to be allocated > MAX_ORDER size
Message-ID: <113620000.1087052452@[10.10.2.4]>
In-Reply-To: <20040612131149.GA28870@colin2.muc.de>
References: <263jX-5RZ-19@gated-at.bofh.it> <262nZ-56Z-5@gated-at.bofh.it> <263jX-5RZ-17@gated-at.bofh.it> <m3d645fwxj.fsf@averell.firstfloor.org> <1087025760.18615.3.camel@nighthawk> <20040612131149.GA28870@colin2.muc.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Since vmalloc() maps the pages with small pagetable entries (unlike most
>> of the rest of the kernel address space), do you think the interleaving
>> will outweigh any negative TLB effects?  
> 
> I think so, yes (assuming you run the benchmark on all CPUs)

On the other hand, there's no reason we can't hack up a version of vmalloc
to use large pages, and interleave only based on that. 

M.

