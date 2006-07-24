Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWGXTTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWGXTTs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 15:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWGXTTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 15:19:48 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:7402 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751289AbWGXTTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 15:19:47 -0400
Date: Mon, 24 Jul 2006 21:14:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Reuben Farrelly <reuben-lkml@reub.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       John McCutchan <john@johnmccutchan.com>, Andrew Morton <akpm@osdl.org>,
       rml@novell.com, viro@zeniv.linux.org.uk
Subject: Re: [patch] inotify: fix deadlock found by lockdep
Message-ID: <20060724191400.GA14809@elte.hu>
References: <20060713224800.6cbdbf5d.akpm@osdl.org> <44C2C90B.6090108@reub.net> <1153761671.3043.89.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153761671.3043.89.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@linux.intel.com> wrote:

> Subject: [patch] inotify: fix deadlock found by lockdep
> From: Arjan van de Ven <arjan@linux.intel.com>
> 
> This is a real deadlock, a nice complex one:
> (warning: long explanation follows so that Andrew can have a complete
> patch description)
> 
> it's an ABCDA deadlock:
> 
> A iprune_mutex 
> B inode->inotify_mutex
> C ih->mutex
> D dev->ev_mutex

wow!

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
