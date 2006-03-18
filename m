Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWCRIzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWCRIzL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 03:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWCRIzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 03:55:11 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:64155 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932308AbWCRIzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 03:55:10 -0500
Date: Sat, 18 Mar 2006 09:52:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.16-rc6 patch] fix interactive task starvation
Message-ID: <20060318085259.GB23317@elte.hu>
References: <1142658480.8262.38.camel@homer> <20060318000549.4bb35800.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318000549.4bb35800.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> I ended up with the below.
> 
> Which do we think is more likely to be true - batch_task(p) or 
> expired_starving(rq)?  batch_task() looks cheaper to evaluate so I put 
> that first.  But I guess it's less likely to be true.  hmm.

it doesnt really matter - scheduler_tick() is a slowpath. Putting 
batch_task() first is ok.

	Ingo
