Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUATGwU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 01:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265193AbUATGwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 01:52:19 -0500
Received: from [66.35.79.110] ([66.35.79.110]:5290 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S265212AbUATGwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 01:52:18 -0500
Date: Mon, 19 Jan 2004 22:52:07 -0800
From: Tim Hockin <thockin@hockin.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Rusty Russell <rusty@au1.ibm.com>, vatsa@in.ibm.com,
       lhcs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
Message-ID: <20040120065207.GA10993@hockin.org>
References: <20040116174446.A2820@in.ibm.com> <20040120060027.91CC717DE5@ozlabs.au.ibm.com> <20040120063316.GA9736@hockin.org> <400CCE2F.2060502@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400CCE2F.2060502@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 05:43:59PM +1100, Nick Piggin wrote:
> >I think the sanest thing for a CPU removal is to migrate everything off the
> >processor in question, move unrunnable tasks into TASK_UNRUNNABLE state,
> >then notify /sbin/hotplug.  The hotplug script can then find and handle the
> >unrunnable tasks.  No SIGPWR grossness needed.
> >
> >Code against 2.4 at http://www.hockin.org/~thockin/procstate - it was
> >heavily tested and I *think* it is all correct (for that kernel snapshot).
> 
> Seems less robust and more ad hoc than SIGPWR, however.

Disagree.  SIGPWR will kill any process that doesn't catch it.  That's
policy.  It seems more robust to let the hotplug script decide what to do.
If it wants to kill each unrunnable task with SIGPWR, it can.  But if it
wants to let them live, it can.

Tim
