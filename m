Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWGEJhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWGEJhi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 05:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWGEJhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 05:37:37 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:18828 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932415AbWGEJhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 05:37:36 -0400
Date: Wed, 5 Jul 2006 11:32:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
Message-ID: <20060705093259.GA11237@elte.hu>
References: <20060705084914.GA8798@elte.hu> <20060705023120.2b70add6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705023120.2b70add6.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> shrinks fs/select.o by eight bytes.  (More than I expected).  So it 
> does appear to be a space win, but a pretty slim one.

there are 855 calls to these functions in the allyesconfig vmlinux i 
did, and i measured a combined size reduction of 34791 bytes. That 
averages to a 40 bytes win per call site. (on i386.)

	Ingo
