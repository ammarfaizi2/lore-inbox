Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWIJVDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWIJVDz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 17:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWIJVDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 17:03:55 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:6016 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964942AbWIJVDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 17:03:54 -0400
Date: Mon, 11 Sep 2006 02:33:48 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] force_quiescent_state: factor out duplicated code
Message-ID: <20060910210348.GE4690@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060910161810.GA10262@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910161810.GA10262@oleg>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2006 at 08:18:10PM +0400, Oleg Nesterov wrote:
> On top of rcu-simplify-improve-batch-tuning.patch
> 
> Cleanup. Move '#ifdef CONFIG_SMP' check and rdp->bhlimit setting
> into force_quiescent_state().


Pushing the rdp->blimit setting into force_quiescent_state is fine,
but I see no need to insert #ifdef CONFIG_SMP into a routine.
Let us continue to have separate versions of force_quiescent_state()
for CONFIG_SMP and !CONFIG_SMP. It looks cleaner with #ifdefs inserted
in between.

Thanks
Dipankar
