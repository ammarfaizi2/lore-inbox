Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314141AbSDQVuZ>; Wed, 17 Apr 2002 17:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314143AbSDQVuZ>; Wed, 17 Apr 2002 17:50:25 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:59033 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314141AbSDQVuW>; Wed, 17 Apr 2002 17:50:22 -0400
Date: Wed, 17 Apr 2002 15:48:48 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>,
        "'Robert Love'" <rml@tech9.net>
cc: James Bourne <jbourne@MtRoyal.AB.CA>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org
Subject: RE: Hyperthreading
Message-ID: <1844830000.1019083728@flay>
In-Reply-To: <61DB42B180EAB34E9D28346C11535A78177F04@nocmail101.ma.tmpw.net>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've seen some Intel bench's and they are specing an increase of 0% to 30%

I think I'd be less cynical about benchmark results that didn't come from the
people trying to sell  the product ;-)

> (Though check Anandtech, he did a benchmark on his DB, and got a small
> performance Decrease on a test!)

;-)
Thanks for the pointer.

> After looking at the Hyperthreading Doc's, It looks like they are trying to
> utilize some of the idle time the Execution engine has while waiting for
> other ops to happen,  Trace code misses, and such.  Strap on an extra
> processor state, and get some extra oomph.  Hey, the P4 can use all the
> extra oomph it can get!

It sounds like a good idea in theory, but the fact that they share the TLB
cache and other things makes me rather dubious about whether it's really
worth it. I'm not saying it's necessarily bad, I'm just not convinced it's good
yet. Introducing more processors to the OS has it's own problems to deal 
with (ones we're interested in solving anyway).

Real world benchmarks from people other than Intel should make interesting
reading .... I think we need some more smarts in the OS to take real advantage
of this (eg using the NUMA scheduling mods to create cpu pools of 2 "procs"
for each pair, etc) ... will be fun ;-)

M.

