Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUDHXbC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 19:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbUDHXbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 19:31:02 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:32754 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261706AbUDHXa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 19:30:59 -0400
Date: Thu, 08 Apr 2004 16:42:37 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <39780000.1081467757@flay>
In-Reply-To: <20040408232215.GY31667@dualathlon.random>
References: <20040407230140.GT26888@dualathlon.random> <29510000.1081380104@flay> <20040407231806.GV26888@dualathlon.random> <33900000.1081380891@flay> <20040408001845.GX26888@dualathlon.random> <1479132704.1081405456@[10.10.2.4]> <20040408215946.GU31667@dualathlon.random> <29690000.1081462791@flay> <20040408221915.GV31667@dualathlon.random> <32730000.1081466048@flay> <20040408232215.GY31667@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, April 09, 2004 01:22:15 +0200 Andrea Arcangeli <andrea@suse.de> wrote:

> On Thu, Apr 08, 2004 at 04:14:08PM -0700, Martin J. Bligh wrote:
>> Me confused. Are you saying it's worse compared to pte_highmem? or to 
>> shoving ptes in lowmem?
> 
> worse than pte_highmem if booting with mem=800m
> 
>> Ah. You're worried about the distro situation, where PTE_HIGHMEM would
>> be turned on for a non-highmem machine, right? Makes more sense I guess.
> 
> it's not just a distro situation, it's about not having to recompile the
> kernel for every machine I own, even gentoo has an option to have a
> compile server in the network that build packages and you install the
> binaries from it, so there must be some value in being able to share a
> binary on more than one machine (this is especially true for me since I
> upgrade kernel quite fast).
> 
> it's not just about non-highmem machines, on 1G/2G boxes the probability
> that pte-highmem cause you any slowdown is an order of magnitude smaller
> than on a 32G machine (where ptes should never hit lowmem or it means my
> classzone lowmem_reserve_ratio algorithms have not yet been ported to 2.6)
> with your model you'd have no way to boost when you are lucky to get a
> lowmem page.

OK, I think I understand your concern now - I was being slow ;-)
I guess there are a few more PTEs to set up on exec, you're right.
I still think it's faster than pte_highmem, which was a static config 
option anyway (so it's better in all cases than pte_highmem, when enabled)
but still not perfect. Hmm. I'll go think about it ;-)

m.

