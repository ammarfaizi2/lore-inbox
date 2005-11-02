Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751519AbVKBFnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbVKBFnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 00:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbVKBFnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 00:43:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55965 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751516AbVKBFnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 00:43:46 -0500
Date: Tue, 1 Nov 2005 21:43:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
cc: Andrew Morton <akpm@osdl.org>, zippel@linux-m68k.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
In-Reply-To: <52y847abjm.fsf@cisco.com>
Message-ID: <Pine.LNX.4.64.0511012142200.27915@g5.osdl.org>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
 <20051031001647.GK2846@flint.arm.linux.org.uk> <20051030172247.743d77fa.akpm@osdl.org>
 <200510310341.02897.ak@suse.de> <Pine.LNX.4.61.0511010039370.1387@scrub.home>
 <20051031160557.7540cd6a.akpm@osdl.org> <Pine.LNX.4.64.0510311611540.27915@g5.osdl.org>
 <20051031163408.41a266f3.akpm@osdl.org> <52y847abjm.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Nov 2005, Roland Dreier wrote:
> 
> On an x86_64 allnoconfig kernel, I see the following sizes:
> 
> 	   text	   data	    bss	    dec	    hex	filename
> 	 795683	 197356	 116384	1109423	 10edaf	vmlinux-before
> 	 794894	 197420	 116384	1108698	 10eada	vmlinux-after

I really don't see the point of shaving less than a kB with ugly calling 
convention magic, when switching to -Os can save us much more, and when 
the networking code is several hundred kB.

If we start doing size optimizations, we need to think big.

		Linus
