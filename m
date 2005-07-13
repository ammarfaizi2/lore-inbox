Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262750AbVGMU0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbVGMU0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbVGMUYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:24:19 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:54790 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S262758AbVGMUWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 16:22:43 -0400
Date: Wed, 13 Jul 2005 13:30:58 -0700
To: Steven Rostedt <rostedt@goodmis.org>
Cc: paulmck@us.ibm.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       dipankar@in.ibm.com, shemminger@osdl.org, rusty@au1.ibm.com
Subject: Re: [RFC] RCU and CONFIG_PREEMPT_RT progress, part 3
Message-ID: <20050713203058.GA27292@nietzsche.lynx.com>
References: <20050713184800.GA1983@us.ibm.com> <1121281598.25810.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121281598.25810.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 03:06:38PM -0400, Steven Rostedt wrote:
> > 3.	Since SPIN_LOCK_UNLOCKED now takes the lock itself as an
> > 	argument, what is the best way to initialize per-CPU
> > 	locks?  An explicit initialization function, or is there
> > 	some way that I am missing to make an initializer?
> 
> Ouch, I just notice that (been using an older version for some time). 
> 
> Ingo, is this to force the initialization of the lists instead of at
> runtime?

ANSI C99 is missing a concept of "self" during auto-intialization. The
explicit passing of the lvalue is needed so that it can be propagated
downward to other macros in the initialization structure. list_head
initialization is one of those things if I remember correctly.

bill

