Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266152AbUALL4V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 06:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUALL4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 06:56:21 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:43931 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266152AbUALL4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 06:56:18 -0500
Date: Mon, 12 Jan 2004 17:30:38 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Jan Ischebeck <mail@jan-ischebeck.de>
Cc: akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-mm2: BUG in kswapd?
Message-ID: <20040112120038.GE1404@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <1073842387.3720.5.camel@JHome.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073842387.3720.5.camel@JHome.uni-bonn.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 08:13:40PM +0000, Jan Ischebeck wrote:
> Hi Andrew,
> 
> After 24 hours running 2.6.1-mm2 I got the following BUG in kswapd:
> 
> Jan 11 06:27:41 JHome kernel: ------------[ cut here ]------------
> Jan 11 06:27:41 JHome kernel: kernel BUG at include/linux/list.h:148!
> Jan 11 06:27:41 JHome kernel: invalid operand: 0000 [#1]
> Jan 11 06:27:41 JHome kernel: PREEMPT 
> Jan 11 06:27:41 JHome kernel: CPU:    0
> Jan 11 06:27:41 JHome kernel: EIP:    0060:[<c016fc36>]    Tainted: GF  VLI
> Jan 11 06:27:41 JHome kernel: EFLAGS: 00010206
> Jan 11 06:27:41 JHome kernel: EIP is at prune_dcache+0x1d6/0x1f0
> Jan 11 06:27:41 JHome kernel: eax: 00000000   ebx: dc3b06c0   ecx: dc3b06d4   edx: dca6585c
> Jan 11 06:27:41 JHome kernel: esi: dc3b0730   edi: dfdd8000   ebp: 00000067   esp: dfdd9e7c
> Jan 11 06:27:41 JHome kernel: ds: 007b   es: 007b   ss: 0068
> Jan 11 06:27:41 JHome kernel: Process kswapd0 (pid: 8, threadinfo=dfdd8000 task=dfddece0)
> Jan 11 06:27:41 JHome kernel: Stack: df683cc0 00000000 00000080 dfdd8000 000001ac dffeeb60 c01700f3 00000080 
> Jan 11 06:27:41 JHome kernel: c0146dde 00000080 000000d0 000159b5 07a9b6c8 00000000 000005ac 00000000 
> Jan 11 06:27:41 JHome kernel: 00000162 c034d674 00000001 ffffff4f c01481b2 00000162 000000d0 000000d0 
> Jan 11 06:27:41 JHome kernel: Call Trace:
> Jan 11 06:27:41 JHome kernel: [<c01700f3>] shrink_dcache_memory+0x23/0x30
> Jan 11 06:27:41 JHome kernel: [<c0146dde>] shrink_slab+0x11e/0x170
> Jan 11 06:27:41 JHome kernel: [<c01481b2>] balance_pgdat+0x1d2/0x200
> Jan 11 06:27:41 JHome kernel: [<c01482f7>] kswapd+0x117/0x130
> Jan 11 06:27:41 JHome kernel: [<c0120fa0>] autoremove_wake_function+0x0/0x50
> Jan 11 06:27:41 JHome kernel: [<c02f0b5e>] ret_from_fork+0x6/0x14
> Jan 11 06:27:41 JHome kernel: [<c0120fa0>] autoremove_wake_function+0x0/0x50
> Jan 11 06:27:41 JHome kernel: [<c01481e0>] kswapd+0x0/0x130
> Jan 11 06:27:41 JHome kernel: [<c010b289>] kernel_thread_helper+0x5/0xc
> Jan 11 06:27:41 JHome kernel: 

Hi Jan,

I guess you are getting this without tainters also.
Can you give some more details like .config, what filesystems
you have etc. 

Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
