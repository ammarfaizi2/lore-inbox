Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751669AbWAKQ2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbWAKQ2d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 11:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbWAKQ2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 11:28:33 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:15577 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751667AbWAKQ2c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 11:28:32 -0500
Date: Wed, 11 Jan 2006 08:28:55 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       vatsa@in.ibm.com
Subject: Re: [PATCH 3/3] rcu: join rcu_ctrlblk and rcu_state
Message-ID: <20060111162855.GD21885@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43C3BB12.B5523F2C@tv-sign.ru> <20060111043557.GM18252@us.ibm.com> <43C4A867.7080408@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C4A867.7080408@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 07:40:39AM +0100, Manfred Spraul wrote:
> Paul E. McKenney wrote:
> 
> >On Tue, Jan 10, 2006 at 04:48:02PM +0300, Oleg Nesterov wrote:
> > 
> >
> >>This patch moves rcu_state into the rcu_ctrlblk. I think there
> >>are no reasons why we should have 2 different variables to control
> >>rcu state. Every user of rcu_state has also "rcu_ctrlblk *rcp" in
> >>the parameter list.
> >>   
> >>
> >
> >Looks good to me, passes one-hour RCU torture test.
> >
> >Manfred, does the ____cacheline_internodealigned_in_smp take care
> >of your cache-line alignment concerns?
>
> Yes.

Sounds good, we should be set on this one then!

							Thanx, Paul
