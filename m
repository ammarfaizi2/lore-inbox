Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbVI1KNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVI1KNj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 06:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVI1KNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 06:13:39 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:17848 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751209AbVI1KNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 06:13:39 -0400
Date: Wed, 28 Sep 2005 19:08:22 +0900 (JST)
Message-Id: <20050928.190822.105167368.taka@valinux.co.jp>
To: kurosawa@valinux.co.jp
Cc: nickpiggin@yahoo.com.au, pj@sgi.com, magnus.damm@gmail.com,
       dino@in.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH 1/3] CPUMETER: add cpumeter framework to the CPUSETS
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20050928063501.89B5A70041@sv1.valinux.co.jp>
References: <20050927013751.47cbac8b.pj@sgi.com>
	<1127812937.5174.6.camel@npiggin-nld.site>
	<20050928063501.89B5A70041@sv1.valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > It could have come a long way since then, but this code looks
> > much neater than the code I reviewed.
> 
> I'm glad to hear that!  But the cpu resource controller has
> some problems, for example:

These are issues to be improved.

> - The controller only controls the time_slice value and doesn't
>   care the balance of cpus (the controller leaves balancing to 
>   the existing balancing code in the scheduler).  So far I don't
>   have any good idea to solve this.

Is there any problem to enhance load_balance()? Applying some weight
to each process, it would be used for calculating load of each runqueue.

> - The controller holds a spinlock once per 1 second.  I don't
>   know this is permissive or not, but the current scheduler
>   doesn't hold any spinlocks normally, so...

I think each runqueue has its own spinlock, which is held quite often.


Thanks,
Hirokazu Takahashi.
