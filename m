Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266053AbUAUEir (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 23:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266056AbUAUEgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 23:36:05 -0500
Received: from dp.samba.org ([66.70.73.150]:26081 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265964AbUAUEfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 23:35:53 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tim Hockin <thockin@hockin.org>
Cc: Nick Piggin <piggin@cyberone.com.au>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org, rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR 
In-reply-to: Your message of "Mon, 19 Jan 2004 23:54:09 -0800."
             <20040120075409.GA13897@hockin.org> 
Date: Wed, 21 Jan 2004 11:00:02 +1100
Message-Id: <20040121043608.5D98F2C0B1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040120075409.GA13897@hockin.org> you write:
> Basically, RT tasks + CPU affinity + hotplug CPUs do not play nicely
> together.  I don't see much that can be done to solve that.  With the
> procstate stuff I did, and with planned CPU unplugs we *do* have time before
> the CPU really goes offline in which to act.  With unplanned CPU offlining,
> we don't.

This can't be done with the hotplug scripts.  I originally ran hotplug
synchronous before taking the CPU offline, and Greg KH said that
constitutes abuse 8(

Userspace can agree on a protocol *before* initiating the offline, of
course, in which case it's not a kernel problem.

You make an excellent point though: if you need 2 cpus on your system
to meet requirements, and you go down to one cpu, you have a problem.
But I think that's a "don't do that".

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
