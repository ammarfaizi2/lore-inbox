Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbUADBum (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 20:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUADBum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 20:50:42 -0500
Received: from dp.samba.org ([66.70.73.150]:23483 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264477AbUADBuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 20:50:40 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       mingo@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-reply-to: Your message of "Fri, 02 Jan 2004 19:43:37 -0800."
             <Pine.LNX.4.44.0401021919240.825-100000@bigblue.dev.mdolabs.com> 
Date: Sat, 03 Jan 2004 22:47:58 +1100
Message-Id: <20040104015037.AE9A62C0AB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0401021919240.825-100000@bigblue.dev.mdolabs.com> you write:
> On Sat, 3 Jan 2004, Rusty Russell wrote:
> 
> > In message <Pine.LNX.4.44.0401020856150.2278-100000@bigblue.dev.mdolabs.com
> you write:
> > > Rusty, you still have to use global static data when there is no need.
> > 
> > And you're still putting obscure crap in the task struct when there's
> > no need.  Honestly, I'd be ashamed to post such a patch.
> 
> Ashamed !? Take a look at your original patch and then define shame. You 
> had a communication mechanism that whilst being a private 1<->1 
> communication among two tasks, relied on a single global message 
> strucure, lock and mutex.

Still do.  It's *simple*, and I refuse to be ashamed of that.

My words were harsh, but I completely disagree with you.  I believe
you are wrong.  I would never have coded it the way you did.  I read
your code and I still think you are wrong, and find your code both
bloated and ugly.

It's not about space, it's about taste.  And placing random stuff in
an unrelated structure because you can't think of a better way to do
it is TASTELESS.  If it were the only way, it might be forgivable, but
it's not, and I far prefer a little localized messiness to global
messiness.

Now, on something we do agree: I dislike the global structure myself.
By all means try changing the code to use a pipe between child and
parent for the initfn result.  But I've told you that I will not
submit any solution which adds to a generic structure for a specific
problem.

I'm very, very sorry this has gotten a little heated: I generally
enjoy our discussions.  But I don't think I should have to say "no"
four times.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
