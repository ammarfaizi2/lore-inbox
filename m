Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWCNXnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWCNXnl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 18:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWCNXnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 18:43:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34503 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750781AbWCNXnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 18:43:40 -0500
Date: Tue, 14 Mar 2006 15:45:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: rdunlap@xenotime.net, rmk+serial@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: soft lockup in serial8250_console_write(?)
Message-Id: <20060314154545.060fac2c.akpm@osdl.org>
In-Reply-To: <20060314232515.GA21782@elte.hu>
References: <20060314134110.3470fc63.rdunlap@xenotime.net>
	<20060314214049.GA29536@elte.hu>
	<20060314151812.2779ed4b.rdunlap@xenotime.net>
	<20060314232515.GA21782@elte.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Randy.Dunlap <rdunlap@xenotime.net> wrote:
> 
> > > > This function calls wait_for_xmitr() [inline], which in worst case can 
> > > > spin for 1.010 seconds.  Could this be the cause of a soft lockup?
> > > 
> > > hm, it shouldnt cause that. Could you try the attached patch [which is 
> > > the next-gen softlockup detector], do you get the message even with that 
> > > one applied?
> > 
> > 5/5 good boots with your new patch.
> > 5/5 soft lockups without it.
> > 
> > Is this scheduled for post-2.6.16 ?
> 
> yes, in theory. Andrew?
> 

Which?  timer-irq-driven-soft-watchdog-cleanups.patch?  Yup.
