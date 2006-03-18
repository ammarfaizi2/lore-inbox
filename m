Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWCRUeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWCRUeE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 15:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWCRUeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 15:34:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26523 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750949AbWCRUeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 15:34:03 -0500
Date: Sat, 18 Mar 2006 12:31:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, trini@kernel.crashing.org
Subject: Re: [patch 1/2] Validate itimer timeval from userspace
Message-Id: <20060318123102.7d8c048a.akpm@osdl.org>
In-Reply-To: <1142712975.17279.131.camel@localhost.localdomain>
References: <20060318142827.419018000@localhost.localdomain>
	<20060318142830.607556000@localhost.localdomain>
	<20060318120728.63cbad54.akpm@osdl.org>
	<1142712975.17279.131.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, 2006-03-18 at 12:07 -0800, Andrew Morton wrote:
> 
> > From my reading, 2.4's sys_setitimer() will normalise the incoming timeval
> > rather than rejecting it.  And I think 2.6.13 did that too.
> > 
> > It would be bad of us to change this behaviour, even if that's what the
> > spec says we should do - because we can break existing applications.
> > 
> > So I think we're stuck with it - we should normalise and then accept such
> > timevals.  And we should have a big comment explaining how we differ from
> > the spec, and why.
> 
> Hmm. How do you treat a negative value ?
> 

In the same way as earlier kernels did!

Unless, of course, those kernels did something utterly insane.  In that
case we'd need to have a little think.

