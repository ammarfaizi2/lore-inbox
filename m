Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbULHJFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbULHJFF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 04:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbULHJFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 04:05:05 -0500
Received: from mx2.elte.hu ([157.181.151.9]:51164 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261156AbULHJEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 04:04:51 -0500
Date: Wed, 8 Dec 2004 10:04:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Dimitri Sivanich <sivanich@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@sgi.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] isolcpus option broken in 2.6.10-rc2-bk2
Message-ID: <20041208090400.GA14022@elte.hu>
References: <20041206185221.GA23917@sgi.com> <20041206211817.GB10235@elte.hu> <41B6C200.50807@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B6C200.50807@cyberone.com.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <piggin@cyberone.com.au> wrote:

> Actually, this is wrong. And I was wrong to say that the fix was to
> initialize the dummy domain (because its ->flags are 0, there is no
> need for it to have anything else set up).
> 
> The isolated domains don't need to be set up because they correctly
> point to the dummy domain, which is already set up properly (zeroed).
> The oops is just a problem with sched_domain_debug.

(ah ... indeed, good catch. Dimitri's patch ended up working around the
'break' bug in sched_domain_debug() :-| At least this case shows that it
was right to keep SCHED_DOMAIN_DEBUG defined.)

> Andrew and/or Linus, please make sure Dimitri's patch gets reverted
> and the attached one applied before 2.6.10.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
