Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbUCIPX7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 10:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbUCIPX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 10:23:59 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:61188
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262001AbUCIPX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 10:23:57 -0500
Date: Tue, 9 Mar 2004 16:24:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309152438.GE8193@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random> <Pine.LNX.4.58.0403081238060.9575@ppc970.osdl.org> <20040308132305.3c35e90a.akpm@osdl.org> <20040308230247.GC12612@dualathlon.random> <20040308152126.54f4f681.akpm@osdl.org> <20040308234014.GG12612@dualathlon.random> <20040309083103.GB8021@elte.hu> <20040309090326.GA10039@elte.hu> <20040309145130.GC8193@dualathlon.random> <20040309150942.GA8224@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309150942.GA8224@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 04:09:42PM +0100, Ingo Molnar wrote:
> 
> * Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > first of all that this algorithm is running in production just fine in
> > the workloads you're talking about, it's not like I didn't even try
> > it, even the ones that have to swap (see the end of the email).
> 
> could you just try test-mmap2.c on such a box, and hit swap?

I will try, to see what happens. But please write an exploit for
truncate too since you obviously can, blaming on the vm is a
red-herring, if the vm has an issue, truncate always had an issue in any
kernel out there since 1997 (the first time I rememeber).

Unless it crashes the machine I don't care, it's totally wrong in my
opinion to hurt everything useful to save cpu while running an exploit.
there are easier ways to waste cpu (rewrite the exploit with truncate
please!!!)
