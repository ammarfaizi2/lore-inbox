Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVIFPQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVIFPQm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 11:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVIFPQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 11:16:42 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:58005 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750710AbVIFPQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 11:16:41 -0400
Date: Tue, 6 Sep 2005 08:16:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@elte.hu, dwalker@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RT: Invert some TRACE_BUG_ON_LOCKED tests
Message-ID: <20050906151640.GA3966@smtp.west.cox.net>
References: <1125691250.2709.2.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050902200856.GY3966@smtp.west.cox.net> <1125700852.5601.16.camel@localhost.localdomain> <1125701636.5601.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125701636.5601.19.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 06:53:56PM -0400, Steven Rostedt wrote:
> On Fri, 2005-09-02 at 18:40 -0400, Steven Rostedt wrote:
> > On Fri, 2005-09-02 at 13:08 -0700, Tom Rini wrote:
> > > With 2.6.13-rt4 I had to do the following in order to get my paired down
> > > config booting on my x86 whitebox (defconfig works fine, after I enable
> > > enet/8250_console/nfsroot).  Daniel Walker helped me trace this down.
> > 
> 
> > 
> > Ingo, I guess we need a TRACE_BUG_ON_LOCKED_SMP() macro.
> 
> 
> Tom,
> 
> try this patch instead.  It removes the tests of the spin_is_locked on
> UP.

This of course works too, thanks!

-- 
Tom Rini
http://gate.crashing.org/~trini/
