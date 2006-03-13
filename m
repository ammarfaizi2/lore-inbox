Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWCMJ2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWCMJ2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 04:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWCMJ2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 04:28:35 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:40893 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932392AbWCMJ2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 04:28:35 -0500
Date: Mon, 13 Mar 2006 10:25:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, cc@ccrma.Stanford.EDU,
       Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Re: 2.6.15-rt20, "bad page state", jackd (alsa 1.0.10 vs. recent kernels)
Message-ID: <20060313092553.GF5780@elte.hu>
References: <1141846564.5262.20.camel@cmn3.stanford.edu> <20060309084746.GB9408@osiris.boeblingen.de.ibm.com> <1141938488.22708.28.camel@cmn3.stanford.edu> <4410B2D7.4090806@yahoo.com.au> <1141958866.22708.69.camel@cmn3.stanford.edu> <441109BC.9070705@yahoo.com.au> <1142016627.6124.33.camel@cmn3.stanford.edu> <44121351.2050703@yahoo.com.au> <1142210977.7471.27.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142210977.7471.27.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> Well, I found it. Finally. I diffed memalloc.c in the alsa kernel tree
> with alsa stable 1.0.10 and googled for the obvious two chunks that
> stood out :-)
> 
> It's apparently an old issue, see here and follow the thread:
>   http://lkml.org/lkml/2005/11/21/9
> So, 1.0.10 obviously did not include these two patches:

ah, great detective work! FYI, current upstream has the fix included, so 
2.6.16-rc6-rt2 should not have this particular problem.

	Ingo
