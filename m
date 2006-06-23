Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932965AbWFWJ4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932965AbWFWJ4P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932983AbWFWJ4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:56:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:43400 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932965AbWFWJ4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:56:14 -0400
Date: Fri, 23 Jun 2006 11:51:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [patch 37/61] lock validator: special locking: dcache
Message-ID: <20060623095111.GF4889@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212608.GK3155@elte.hu> <20060529183539.08d3463c.akpm@osdl.org> <1149022268.21827.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149022268.21827.4.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 2006-05-29 at 18:35 -0700, Andrew Morton wrote:

> > DENTRY_D_LOCK_NORMAL isn't used anywhere.
> 
> I guess it is implied with the normal spin_lock.  Since 
>   spin_lock(&target->d_lock) and
>   spin_lock_nested(&target->d_lock, DENTRY_D_LOCK_NORMAL)
> are equivalent. (DENTRY_D_LOCK_NORMAL == 0)
> 
> Probably this deserves a comment.

i have added a comment to dcache.h explaining this better.

	Ingo
