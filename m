Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262631AbTCYNYm>; Tue, 25 Mar 2003 08:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262633AbTCYNYm>; Tue, 25 Mar 2003 08:24:42 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:55488 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262631AbTCYNYm>; Tue, 25 Mar 2003 08:24:42 -0500
Date: Tue, 25 Mar 2003 14:35:25 +0100
From: Andi Kleen <ak@muc.de>
To: Dave Jones <davej@codemonkey.org.uk>, Andi Kleen <ak@muc.de>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: cacheline size detection code in 2.5.66
Message-ID: <20030325133525.GA30321@averell>
References: <20030325071532.GA19217@averell> <20030325143310.A3487@jurassic.park.msu.ru> <20030325121527.GA29965@averell> <20030325124333.GB28451@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325124333.GB28451@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > Broken in i386 too.
> 
> I don't see anything broken there. The K7 / K8 feature flags are not
> bit for bit compatible though iirc (can't find my K8 cpuid manuals right now).

Umm - they should be. Otherwise CPUID would be completely useless.

I double checked both the Intel and the x86-64 manual now and bit 19 
of 0000_0001 is CLFLUSH 

So cpufeature.h and the x86-64 test is correct

0000_0001 is supposed to be globally compatible. 8000_0001 
is supposed to be compatible inside AMD CPUs (and 19 is reserved here)

Ivan confused me.  Either he read the application note wrong or it is wrong.

-Andi
