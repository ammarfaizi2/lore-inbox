Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268688AbTBZJML>; Wed, 26 Feb 2003 04:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268689AbTBZJML>; Wed, 26 Feb 2003 04:12:11 -0500
Received: from bi-01pt1.bluebird.ibm.com ([129.42.208.186]:49086 "EHLO
	bigbang.in.ibm.com") by vger.kernel.org with ESMTP
	id <S268688AbTBZJMK>; Wed, 26 Feb 2003 04:12:10 -0500
Date: Wed, 26 Feb 2003 15:06:26 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: "Mark F." <daracerz@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.63] Kernel Panic During Boot (Swap???)
Message-ID: <20030226093626.GA1080@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <BAY2-DAV37gUSp3sJWG0000bad4@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY2-DAV37gUSp3sJWG0000bad4@hotmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 10:28:11PM +0000, Mark F. wrote:
> hello, heres the situation.  Compiled 2.5.63 with the mod-utils 0.9.9
> version.  Kernel worked the first couple of times using it.  but then, while
> trying to loaded some changes to it.  It now crashes each time with a Kernel
> Panic.  Reverting back to the my saved 2.4.21-pre3 I can still boot.  Also,
> undoing the kernel changes isn't kelping me.   Heres some of the code snip
> the kernel boot out.  and the location where:  (sorry if there are a couple
> of typos, typing it on another machine):  This is redhat 8 based on a Compaq
> 900z which runs off of the Radeon IGP 320M Chipset.
> 
> 
> Enabling local filesystem quotas:            [ OK ]
> Enabling swap space:                            [ OK ]
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:        0060:[<00000000>]    Not tainted
> EFLAGS: 00010246
> eax:  c037a640    ebc: c037a6ec    ecx: c1380040    edx: 00000174
> esi:    ce538700    edi: c1380040    ebp: 00000001    esp: c031beb4
> ds: 007b    es: 007b    ss: 0068
> Process swapper (pid: 0, threadinfo=c031a000 task=c02d3500
> Stack: cf8bbd06 c037a6ec 00000174 ce538740 c037a6ec c138b818 c037a6ec
> 00000000
>            c138b0c0 0000000f c020e419 c037a6ec ce538700 00000000 00000088
> 0000001e
>             cee8ad80 c138b0c0 c037a6ec cee8ad80 c020e619 c037a6ec c138b0c0
> c037a820
> Call Trace:  [<cf8bbd06>] [<c020e419>] [<c020e619>] [<c020ec08>]
> [<cf8bb760>]
>     [<c010cd78>] [<c010cfa7>] [<c0108af0>] [<c0108af0>] [<c010b94c>]
> [<c0108af0>]
>     [<c0108af0>] [<c0108b14>] [<c0108b8e>] [<c0105000>]
> Code:    Bad EIP value.
>     <0> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
> 
> 
> I can reproduce this consistantly so far, so will give any information I can
> give ya.  I'm gonna go and continue modding the kernel to see if i can break
> it down or see the solution.
> Mark

Hi Mark,

Can you try with "Load all Symbols" in kernel hacking config option or use 
ksymoops to decode this oops message?

Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
