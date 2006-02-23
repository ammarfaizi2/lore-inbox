Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751640AbWBWTdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbWBWTdE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbWBWTdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:33:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35980 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751640AbWBWTdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:33:02 -0500
Date: Thu, 23 Feb 2006 11:32:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
In-Reply-To: <Pine.LNX.4.61.0602231400430.4226@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0602231127260.3771@g5.osdl.org>
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> 
 <1140707358.4672.67.camel@laptopd505.fenrus.org>  <200602231700.36333.ak@suse.de>
 <1140713001.4672.73.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
 <Pine.LNX.4.61.0602231400430.4226@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Feb 2006, linux-os (Dick Johnson) wrote:
> >
> > Does anybody want to run benchmarks? (Totally untested, may not boot,
> > might physically accost your pets for all I know).
> >
> > 		Linus
> 
> I just reconfigured and rebuilt linux-2.6.15.4 to put PHYSICAL_START
> at 0x00400000, unconditionally and it booted fine and is working so
> a 'boot' shouldn't be a problem.

I ended up doing even more.

For me, running lmbench with this, it seems to improve some things by up 
to 20% (pipe bandwidth and latency, small file delete), some other things 
by 10% (larger file delete), and others not at all.

Still, that 20% is _huge_. 

HOWEVER. I didn't compare very strictly. I should have done many more runs 
(I only did three), and more importantly, I should have compared the exact 
same kernel (I compared the new results against a kernel that was a couple 
of weeks old, so there were other differences). So it's a bit suspect. 
Finally, it might depend on the core a lot, and other cores might not get 
the same results.

So somebody should do a much better test. I'm too lazy.

		Linus
