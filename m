Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318419AbSGSBkl>; Thu, 18 Jul 2002 21:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318422AbSGSBkl>; Thu, 18 Jul 2002 21:40:41 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:10402 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318419AbSGSBkk>;
	Thu, 18 Jul 2002 21:40:40 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Robert Love <rml@tech9.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-cpu patch 2/3 
In-reply-to: Your message of "18 Jul 2002 10:05:26 MST."
             <1027011926.1086.118.camel@sinai> 
Date: Fri, 19 Jul 2002 11:36:20 +1000
Message-Id: <20020719014425.9F57E4109@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1027011926.1086.118.camel@sinai> you write:
> On Wed, 2002-07-17 at 20:48, Rusty Russell wrote:
> > Given the ongoing races with smp_processor_id() and preempt, this
> > makes sense to me.  this_cpu() was too generic a name anyway.
> 
> Very nice, although:
> 
> How do you reenable preemption?

I think you are confused: this patch is an enhancement of the per-cpu
variable infrastructure.  I was making an analogy with
smp_processor_id().

+#define get_cpu_var(var) ({ preempt_disable(); __get_cpu_var(var); })
+#define put_cpu_var(var) preempt_enable()

Clear?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
