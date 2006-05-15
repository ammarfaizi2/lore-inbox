Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWEOSnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWEOSnb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWEOSnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:43:31 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:46997 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751022AbWEOSn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:43:29 -0400
Date: Mon, 15 May 2006 20:43:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, apw@shadowen.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 NUMA panic compile error
Message-ID: <20060515184319.GA19576@elte.hu>
References: <20060515005637.00b54560.akpm@osdl.org> <20060515175306.GA18185@elte.hu> <20060515110814.11c74d70.akpm@osdl.org> <200605152013.53728.ak@suse.de> <20060515113439.457f5809.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515113439.457f5809.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > But testing on a 64bit box - even with numa emulation - would be much
> > better because on 32bit ZONE_NORMAL often is node 0 only and you won't 
> > get much numaness for kernel objects.
> 
> That's an excellent point - most developers who are likely to want to 
> test NUMA have x86_64 boxes and x86_64 has NUMA-emulation-on-SMP.  I'd 
> semi-forgotten that it existed.
> 
> This rather weakens the reasons for retaining support for 
> NUMA-on-non-summit-x86.  Ingo?

my 64-bit boxes (half of the testbed) are busy ones used for daily 
testing that i just cannot keep running for days doing stress-tests. 
Neither can they wait 10 minutes to boot up an allyesconfig kernel. So 
at least as long as my testconfig is concerned, 32-bit boxes and i386 
NUMA still has some place.

(and i'm not at all arguing it's a big thing - it's a minor thing. But i 
absolutely resist Andi's approach on conceptual grounds. It's backwards, 
for the reasons i outlined before. Had Andi's patch been in place the 
zone alignment bug had probably not been found - simple as that. 
Reducing choice artificially is the kind of thing that decreases the 
kernel's quality. Improving the quality of the kernel starts with making 
sure everyone understands how to achieve it - and Andi is one of the 
largest and most important contributors so i'd really like to make sure 
he understands my point :-)

	Ingo
