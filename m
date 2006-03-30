Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWC3MD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWC3MD3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 07:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWC3MD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 07:03:29 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37357 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932180AbWC3MD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 07:03:28 -0500
Date: Thu, 30 Mar 2006 14:00:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] splice support #2
Message-ID: <20060330120055.GA10402@elte.hu>
References: <20060330100630.GT13476@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330100630.GT13476@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jens Axboe <axboe@suse.de> wrote:

> Hi,
> 
> This patch should resolve all issues mentioned so far. I'd still like 
> to implement the page moving, but that should just be a separate 
> patch.

neat stuff. One question: why do we require fdin or fdout to be a pipe?  
Is there any fundamental problem with implementing what Larry's original 
paper described too: straight pagecache -> socket transfers? Without a
pipe intermediary forced inbetween. It only adds unnecessary overhead.

	Ingo
