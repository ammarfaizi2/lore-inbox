Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUDHXWS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 19:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbUDHXWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 19:22:18 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19921
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261326AbUDHXWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 19:22:16 -0400
Date: Fri, 9 Apr 2004 01:22:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040408232215.GY31667@dualathlon.random>
References: <20040407230140.GT26888@dualathlon.random> <29510000.1081380104@flay> <20040407231806.GV26888@dualathlon.random> <33900000.1081380891@flay> <20040408001845.GX26888@dualathlon.random> <1479132704.1081405456@[10.10.2.4]> <20040408215946.GU31667@dualathlon.random> <29690000.1081462791@flay> <20040408221915.GV31667@dualathlon.random> <32730000.1081466048@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32730000.1081466048@flay>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 04:14:08PM -0700, Martin J. Bligh wrote:
> Me confused. Are you saying it's worse compared to pte_highmem? or to 
> shoving ptes in lowmem?

worse than pte_highmem if booting with mem=800m

> Ah. You're worried about the distro situation, where PTE_HIGHMEM would
> be turned on for a non-highmem machine, right? Makes more sense I guess.

it's not just a distro situation, it's about not having to recompile the
kernel for every machine I own, even gentoo has an option to have a
compile server in the network that build packages and you install the
binaries from it, so there must be some value in being able to share a
binary on more than one machine (this is especially true for me since I
upgrade kernel quite fast).

it's not just about non-highmem machines, on 1G/2G boxes the probability
that pte-highmem cause you any slowdown is an order of magnitude smaller
than on a 32G machine (where ptes should never hit lowmem or it means my
classzone lowmem_reserve_ratio algorithms have not yet been ported to 2.6)
with your model you'd have no way to boost when you are lucky to get a
lowmem page.
