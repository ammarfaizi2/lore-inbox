Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263679AbUEWWUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUEWWUQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 18:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbUEWWUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 18:20:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25315 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263679AbUEWWUK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 18:20:10 -0400
Message-ID: <40B1238C.6060605@pobox.com>
Date: Sun, 23 May 2004 18:19:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7-rc1
References: <200405231619.i4NGJBe18903@pincoya.inf.utfsm.cl> <40B0EE6C.70400@pobox.com> <20040523211154.GC1833@holomorphy.com> <40B1180F.8000501@pobox.com> <20040523215330.GG1833@holomorphy.com>
In-Reply-To: <20040523215330.GG1833@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>I wouldn't qualify either of the major VM patch series merged as
>>>rewrites. I saw:
>>>(1) move unmapping function/helpers to different algorithm to save space
>>>(2) NUMA API and support functions
> 
> 
> On Sun, May 23, 2004 at 05:30:55PM -0400, Jeff Garzik wrote:
> 
>>You missed the pte chains going away, a fundamental change in the way 
>>reverse mapping is done?
> 
> 
> (1) describes that in more detail than "pte_chains going away". It's
> just a search algorithm. For anonymous pages, anon_vma just strobes
> offsets into vma inheritance chains, and anonmm just strobes vaddrs in
> all forks between execs, for file-backed memory they both use ->i_mmap.
> Yes, they can both be summarized in the same sentence. The scope of the
> changes are very limited and the presentation of them is a very clearly
> documented and incremental series of small changes.


You're getting lost in the details...  the scope of the anonvma change 
is _everybody_.  If you accept the premise that we are in a _stable_ 
kernel series, the core goal should be stability.  Non-trivial VM 
changes like this do not enhance stability in the short term, even if 
they are a good idea in the long run.  It's the whole idea behind 
minimizing changes and breakage in a stable series.

You've got all the major Linux vendors preparing (or releasing) 
2.6.x-based product and IMO the 2.6 kernel is still a moving target, 
with non-trivial behavior (and sometimes API) changes every couple of 
kernel versions.

	Jeff


