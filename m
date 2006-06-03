Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbWFCOk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWFCOk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 10:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWFCOk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 10:40:57 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:16609 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030311AbWFCOk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 10:40:57 -0400
Date: Sat, 3 Jun 2006 16:41:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060603144121.GA3701@elte.hu>
References: <20060601014806.e86b3cc0.akpm@osdl.org> <986ed62e0606011758w348080ebn6e8430ec9e5b2ed3@mail.gmail.com> <20060601183836.d318950e.akpm@osdl.org> <986ed62e0606020614j363bd71bn7d1fba23b78571f3@mail.gmail.com> <20060602142009.GA10236@elte.hu> <986ed62e0606021101t6701d095ycd29c91885aaeec9@mail.gmail.com> <20060602205332.GA5022@elte.hu> <986ed62e0606021533n4c8954eeifd71f97611a4c7f@mail.gmail.com> <20060603071301.GB19257@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060603071301.GB19257@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > added (for figuring out the warning at boot time), my kernel is about 
> > 50-60K too large to fit on a 1.6MB floppy. I first need to see if I 
> > can trim or modularize some fat from my kernel without affecting the 
> > reproducibility of these bugs... (If all else fails, I'll probably add 
> > a CD-RW drive to this box and boot kernels from that.)
> 
> just disable FORCED_INLINING in the .config, turn on EMBEDDED and 
> select OPTIMIZE_FOR_SIZE, and that should give you 30-40% of kernel 
> size savings.

also, the latest combo patch:

  http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc5-mm2.patch

should have the floppy bug(s) fixed.

	Ingo
