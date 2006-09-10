Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWIJVNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWIJVNz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 17:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWIJVNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 17:13:54 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:63968 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1750785AbWIJVNy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 17:13:54 -0400
Date: Mon, 11 Sep 2006 01:13:44 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] force_quiescent_state: factor out duplicated code
Message-ID: <20060910211344.GA188@oleg>
References: <20060910161810.GA10262@oleg> <20060910210348.GE4690@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910210348.GE4690@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11, Dipankar Sarma wrote:
>
> On Sun, Sep 10, 2006 at 08:18:10PM +0400, Oleg Nesterov wrote:
> > On top of rcu-simplify-improve-batch-tuning.patch
> > 
> > Cleanup. Move '#ifdef CONFIG_SMP' check and rdp->bhlimit setting
> > into force_quiescent_state().
> 
> 
> Pushing the rdp->blimit setting into force_quiescent_state is fine,
> but I see no need to insert #ifdef CONFIG_SMP into a routine.

Otherwise we need to push the rdp->blimit setting into both versions
of force_quiescent_state(), for CONFIG_SMP and !CONFIG_SMP.

> Let us continue to have separate versions of force_quiescent_state()
> for CONFIG_SMP and !CONFIG_SMP. It looks cleaner with #ifdefs inserted
> in between.

I personally think exactly opposite :)

Ok, let's forget about this patch, it was only cleanup.

Oleg.

