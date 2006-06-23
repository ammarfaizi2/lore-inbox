Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932992AbWFWKMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932992AbWFWKMX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932993AbWFWKMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:12:23 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:56215 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932992AbWFWKMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:12:21 -0400
Date: Fri, 23 Jun 2006 12:07:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 52/61] lock validator: special locking: af_unix
Message-ID: <20060623100726.GK4889@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212719.GZ3155@elte.hu> <20060529183608.19308b7c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529183608.19308b7c.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5003]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > -			spin_lock(&sk->sk_receive_queue.lock);
> > +			spin_lock_bh(&sk->sk_receive_queue.lock);
> 
> Again, a bit of a show-stopper.  Will the real fix be far off?

ok, this should be solved in recent -mm, via:

 lock-validator-special-locking-af_unix-undo-af_unix-_bh-locking-changes-and-split-lock-type.patch

	Ingo
