Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267386AbTACFCD>; Fri, 3 Jan 2003 00:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267388AbTACFCD>; Fri, 3 Jan 2003 00:02:03 -0500
Received: from dp.samba.org ([66.70.73.150]:47525 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267386AbTACFCC>;
	Fri, 3 Jan 2003 00:02:02 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: kronos@kronoz.cjb.net
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: [RFC] Migrating net/sched to new module interface 
In-reply-to: Your message of "Thu, 02 Jan 2003 23:50:10 BST."
             <20030102225010.GA1197@dreamland.darkstar.lan> 
Date: Fri, 03 Jan 2003 16:10:19 +1100
Message-Id: <20030103051033.1A2AA2C003@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030102225010.GA1197@dreamland.darkstar.lan> you write:
> Hi,
> 
> I'm  working on  net/sched to  convert it  to new  module interface. I'm
> going to add a new field  'owner' to struct Qdisc_ops.

Hmm, I thought the sched stuff all runs under the network brlock?  If
so, it doesn't need to be held in, since it's not preemptible.

I haven't checked, though...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
