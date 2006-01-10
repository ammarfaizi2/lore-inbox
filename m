Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWAJSJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWAJSJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWAJSJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:09:29 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:61635 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932323AbWAJSJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:09:28 -0500
Date: Tue, 10 Jan 2006 23:39:54 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/5] rcu: join rcu_ctrlblk and rcu_state
Message-ID: <20060110180954.GA5387@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <43C165CE.AF913697@tv-sign.ru> <20060110002818.GD15083@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110002818.GD15083@us.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 04:28:18PM -0800, Paul E. McKenney wrote:
> On Sun, Jan 08, 2006 at 10:19:42PM +0300, Oleg Nesterov wrote:
> > This patch moves rcu_state into the rcu_ctrlblk. I think there
> > are no reasons why we should have 2 different variables to control
> > rcu state. Every user of rcu_state has also "rcu_ctrlblk *rcp" in
> > the parameter list.
> 
> This patch looks sane to me.  It passes a short one-hour rcutorture
> on ppc64 and x86, firing up some overnight runs as well.
> 
> Dipankar, Manfred, any other concerns?  Cacheline alignment?  (Seems
> to me this code is far enough from the fastpath that this should not
> be a problem, but thought I should ask.)
> 

rcu_state came over from Manfred's RCU_HUGE patch IIRC. I don't
think it is necessary to allocate rcu_state separately in the
current mainline RCU code. So, the patch looks OK to me, but
Manfred might see something that I am not seeing.

Thanks
Dipankar
