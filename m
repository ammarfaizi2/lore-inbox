Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbUJ1Ssn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbUJ1Ssn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 14:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbUJ1SoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 14:44:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57486 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262898AbUJ1SmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 14:42:19 -0400
Date: Thu, 28 Oct 2004 14:42:54 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: Sergey Vlasov <vsu@altlinux.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.4.28-pre3 tty/ldisc fixes
In-Reply-To: <20041028183551.GC3253@sirius.home>
Message-ID: <Pine.LNX.4.44.0410281440200.13340-100000@dhcp83-105.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Oct 2004, Sergey Vlasov wrote:

> On Fri, 24 Sep 2004 13:49:33 -0400, Jason Baron wrote:
> 
> > Here is a first attempt at bringing Alan's 2.6 tty/ldisc fixes to 2.4.  
> > I've done some testing with it, but was hoping for broader
> > testing/feedback while all the issues get ironed out. The most notable
> > change is the addition of a wakeup at the end of tty_set_ldisc, for
> > threads waiting for the TTY_LDISC bit to be set.
> 
> > +
> > +	/* Defer ldisc switch */
> > +	/* tty_deferred_ldisc_switch(N_TTY);
> > +
> >  	read_lock(&tasklist_lock);
> >   	for_each_task(p) {
> >  		if ((tty->session > 0) && (p->session == tty->session) &&
> 
> Here the comment is unclosed; is this intentional?  Simply closing it
> at the same line gives a kernel which cannot complete the system boot
> process: it prints "init_dev but no ldisc", and then init hangs in
> uninterruptible sleep with this backtrace:

That comment should be closed. oops. I'm working on a fixed up patch now 
(for that and a few other things).

-Jason


