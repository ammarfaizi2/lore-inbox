Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274880AbTGaVim (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274882AbTGaVh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:37:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:59040 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274880AbTGaVhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:37:39 -0400
Date: Thu, 31 Jul 2003 14:25:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: rusty@rustcorp.com.au, andrea@suse.de, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com
Subject: Re: [PATCH] RCU: Reduce size of rcu_head 1 of 2
Message-Id: <20030731142545.7bcb50fb.akpm@osdl.org>
In-Reply-To: <20030731213103.GB17709@in.ibm.com>
References: <20030731185806.GC1990@in.ibm.com>
	<20030731134954.54108d95.akpm@osdl.org>
	<20030731213103.GB17709@in.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> wrote:
>
> The linked-list change is internal enough for a future backport from
> 2.7. The only concern here is the change in call_rcu() API. What would
> be a good way to manage that ?

Oh I'd be okay with merging a change like this into (say) 2.6.3-pre1,
without it having had a run in 2.7.  We need to be able to do things like
that.

But right now we need to be fully focussed upon important features which
are late (cpumask_t, 64-bit dev_t, 4G+4G, etc) and upon stabilisation of the
current tree.

