Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbUEBIOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUEBIOR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 04:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbUEBIOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 04:14:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:53151 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262434AbUEBIOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 04:14:16 -0400
Date: Sun, 2 May 2004 01:13:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: vandrove@vc.cvut.cz, cw@f00f.org, koke@amedias.org,
       linux-kernel@vger.kernel.org
Subject: Re: strange delays on console logouts (tty != 1)
Message-Id: <20040502011337.2b0b3ca3.akpm@osdl.org>
In-Reply-To: <20040502090059.A9605@flint.arm.linux.org.uk>
References: <20040430195351.GA1837@amedias.org>
	<20040501214617.GA6446@taniwha.stupidest.org>
	<20040501232448.GA4707@vana.vc.cvut.cz>
	<20040501180347.31f85764.akpm@osdl.org>
	<20040502090059.A9605@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Sat, May 01, 2004 at 06:03:47PM -0700, Andrew Morton wrote:
> > Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
> > >
> > > (2) tty hangup is scheduled for work_queue.
> > 
> > This is the problem, isn't it?
> > 
> > >From what context is tty_hangup() invoked?  (stick a dump_stack() in there>?)
> 
> >From IRQ context.  It's tty_vhangup() which is invoked from user context,
> and calls do_tty_hangup() synchronously.
> 

But Chris and Petr are talking about virtual terminals on the local
console, are they not?

If so, how is tty_hangup() getting involved?
