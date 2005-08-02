Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVHBEH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVHBEH7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 00:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVHBEH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 00:07:59 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27122 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261269AbVHBEH6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 00:07:58 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1122954935.6759.69.camel@localhost.localdomain>
References: <20050730160345.GA3584@elte.hu>
	 <1122920564.6759.15.camel@localhost.localdomain>
	 <1122931238.4623.17.camel@dhcp153.mvista.com>
	 <1122954935.6759.69.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 21:07:42 -0700
Message-Id: <1122955662.5035.33.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 23:55 -0400, Steven Rostedt wrote:
> On Mon, 2005-08-01 at 14:20 -0700, Daniel Walker wrote:
> > It means that IRQ 14 is running for a long time as an RT task 
> 
> Oh yeah, I forgot to comment on this.  Yes IRQ 14 is rather slow. It's
> the IDE drive interrupt and it gets pretty busy.  Actually the check
> doesn't really see if it is running for a long time, since it gets
> scheduled out.  But I'm running this on a slow 368MHz machine and it
> takes some time. There's cases where every second the interrupt just
> happened to be running, since that is what it checks.  It doesn't check
> to see if the thread actual sleeps.
> 
> I may add something to your patch to see if a thread actually goes to
> sleep. If it doesn't then to flag it as possible stuck.

I was offering to do that earlier , but I assumed your other patch was
sufficient .. Feel free to add it if you think it's needed..

Daniel

