Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292838AbSCJRNp>; Sun, 10 Mar 2002 12:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293111AbSCJRNf>; Sun, 10 Mar 2002 12:13:35 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:57283 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S292838AbSCJRNX>; Sun, 10 Mar 2002 12:13:23 -0500
Date: Sun, 10 Mar 2002 09:13:58 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Samuel Ortiz <sortiz@dbear.engr.sgi.com>
cc: =?ISO-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrea Arcange <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>,
        Robert Love <rml@tech9.net>, Oleg Drokin <green@namesys.com>
Subject: Re: 23 second kernel compile (aka which patches help scalibility on NUMA)
Message-ID: <210438344.1015751637@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.33.0203100120290.26154-100000@dbear.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.33.0203100120290.26154-100000@dbear.engr.sgi.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Martin, I wrote a patch in order to have a kswap daemon per node. Each
> daemon swaps pages out only from its node. It might be of some interest
> for your scalability problem, so let me know if you're interested in it (I
> can't paste it here because it has also some other stuffs in it, and I

How does this interact with the virtual scanning stuff? I
was under the impression that we scanned for suitable pages
on a per-process basis ... so I'm confused as to how you'd
have a per-node kswapd without rmap's physical scanning
(unless you assume all processes on a node have all their
mem on that node). Could you explain? 

> have to split the patch in several parts. I also need to port it to -rmap).

I'd certainly be interested to see / try it - I think Bill Irwin
had an implementation of multiple kswapd's for rmap - you might
want to look at that before you port.

Thanks,

M

