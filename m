Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbUAUEgA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 23:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266056AbUAUEgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 23:36:00 -0500
Received: from dp.samba.org ([66.70.73.150]:24545 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261799AbUAUEfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 23:35:53 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tim Hockin <thockin@hockin.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, vatsa@in.ibm.com,
       lhcs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR 
In-reply-to: Your message of "Mon, 19 Jan 2004 22:52:07 -0800."
             <20040120065207.GA10993@hockin.org> 
Date: Wed, 21 Jan 2004 10:51:11 +1100
Message-Id: <20040121043608.571732C094@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040120065207.GA10993@hockin.org> you write:
> On Tue, Jan 20, 2004 at 05:43:59PM +1100, Nick Piggin wrote:
> > Seems less robust and more ad hoc than SIGPWR, however.
> 
> Disagree.  SIGPWR will kill any process that doesn't catch it.  That's
> policy.  It seems more robust to let the hotplug script decide what to do.
> If it wants to kill each unrunnable task with SIGPWR, it can.  But if it
> wants to let them live, it can.

The proposal was to send SIGPWR only if they don't have it set to the
default, for this reason.

I think that if your patch goes in, it will complement this solution
nicely.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
