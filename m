Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274982AbTHAXCi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 19:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274984AbTHAXCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 19:02:38 -0400
Received: from dp.samba.org ([66.70.73.150]:9373 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S274982AbTHAXCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 19:02:36 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: dipankar@in.ibm.com, andrea@suse.de, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com
Subject: Re: [PATCH] RCU: Reduce size of rcu_head 1 of 2 
In-reply-to: Your message of "Thu, 31 Jul 2003 14:25:45 MST."
             <20030731142545.7bcb50fb.akpm@osdl.org> 
Date: Sat, 02 Aug 2003 07:16:07 +1000
Message-Id: <20030801230235.E67442C286@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030731142545.7bcb50fb.akpm@osdl.org> you write:
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> >
> > The linked-list change is internal enough for a future backport from
> > 2.7. The only concern here is the change in call_rcu() API. What would
> > be a good way to manage that ?
> 
> Oh I'd be okay with merging a change like this into (say) 2.6.3-pre1,
> without it having had a run in 2.7.  We need to be able to do things like
> that.

No, Andrew, no.

	Gratuitous change to API during stable series BAD BAD BAD.  If
you drop this it stays as is until 2.8.  The extra arg in
unneccessary, but breaking it is worse.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
