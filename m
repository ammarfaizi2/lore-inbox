Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268063AbUH1BGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268063AbUH1BGt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 21:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268049AbUH1BF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 21:05:57 -0400
Received: from colin2.muc.de ([193.149.48.15]:42511 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268048AbUH1BFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 21:05:44 -0400
Date: 28 Aug 2004 03:05:42 +0200
Date: Sat, 28 Aug 2004 03:05:42 +0200
From: Andi Kleen <ak@muc.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@osdl.org>, clameter@sgi.com, ak@suse.de,
       wli@holomorphy.com, davem@redhat.com, raybry@sgi.com,
       benh@kernel.crashing.org, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64 support added
Message-ID: <20040828010542.GB50329@muc.de>
References: <20040816143903.GY11200@holomorphy.com> <B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com> <B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com> <B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com> <20040827233602.GB1024@wotan.suse.de> <Pine.LNX.4.58.0408271717400.15597@schroedinger.engr.sgi.com> <20040827172337.638275c3.davem@davemloft.net> <20040827173641.5cfb79f6.akpm@osdl.org> <20040827174038.67b9cbce.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827174038.67b9cbce.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 05:40:38PM -0700, David S. Miller wrote:
> On Fri, 27 Aug 2004 17:36:41 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > This reminds me - where's that 4-level pagetable patch got to?
> 
> I've never seen that.

It's not really finished yet...

> 
> Wow, with that thing we'd _REALLY_ need the clear_page_range()
> optimizations as 4-levels will be extremely sparse to access
> on address space teardown.

I would expect most programs to be not have that many holes, so
it will probably not make that much difference for them. But for extreme 
cases like ElectricFenced agreed it may need some optimizations later.  
First implementation is minimal changes only though.

Also BTW most archs will continue to use 2 or 3 levels, you only have
to switch to 4 levels if you want to.

-Andi
