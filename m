Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031329AbWK3UTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031329AbWK3UTv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031341AbWK3UTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:19:51 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:15077 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1031329AbWK3UTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:19:50 -0500
Date: Thu, 30 Nov 2006 21:19:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, Avi Kivity <avi@qumranet.com>,
       kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/38] KVM: Create kvm-intel.ko module
Message-ID: <20061130201935.GA14696@elte.hu>
References: <456AD5C6.1090406@qumranet.com> <20061127121136.DC69A25015E@cleopatra.q> <20061127123606.GA11825@elte.hu> <20061130142435.GA13372@infradead.org> <20061130154425.GB28507@elte.hu> <20061130115957.c3761331.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130115957.c3761331.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> It's a fat, complex, presumably arch-specific, presumably 
> frequently-changing API.  So whatever we do will be unpleasant - 
> that's unavoidable in this case, I suspect.
> 
> (hmm, the interface isn't versioned at present - should it be?)
> 
> Maybe, perhaps, one day it _should_ be a syscall API.  But right now 
> if we did that it would become a versioned syscall API with obsolete 
> slots and various other warts.

yeah, very much agreed. For example the paravirtualization/accelerator 
downcalls/upcalls in KVM dont exist yet, so there's little to 
standardize. Once we see it from lhype & KVM how these things look like 
we can design a sane kernel interface around it. But i'm against the 
notion that KVM is 'just' a device. It's not, and it /will/ grow into 
something fundamental.

> I get the feeling we'd be best off if we were to revisit this in a 
> year or so.

yeah. I'd suggest merging it as-is into v2.6.20. In a year we'll have 
some real APIs to think about.

	Ingo
