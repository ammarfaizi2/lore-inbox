Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVEBItM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVEBItM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 04:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVEBItM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 04:49:12 -0400
Received: from rgminet03.oracle.com ([148.87.122.32]:7729 "EHLO
	rgminet03.oracle.com") by vger.kernel.org with ESMTP
	id S261738AbVEBItI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 04:49:08 -0400
Date: Mon, 2 May 2005 01:48:55 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hangcheck-timer: Update to 0.9.0.
Message-ID: <20050502084855.GQ4747@ca-server1.us.oracle.com>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200505011707.j41H7VbY021843@hera.kernel.org> <1114969538.6577.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114969538.6577.21.camel@localhost.localdomain>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2005 at 01:45:37PM -0400, Arjan van de Ven wrote:
> > +
> > +#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
> > +# define HAVE_MONOTONIC
> > +# define TIMER_FREQ 1000000000ULL
> 
> this looks wrong!
> 
> does this work with HZ=100 ?
> also there is a TSC config option which you want to use most likely
> instead of CONFIG_X86 (and x86-64 has CONFIG_X86 defined too)

	It is right, though.  monotonic_clock() is defined as returning
nanoseconds, not a value based on HZ.  It's supported on x86 and x86-64,
hence using CONFIG_X86 to check.  Someday, John will get it implemented
for the other platforms, and we'll have less mess in hangcheck-timer.c.
He already thinks that he should have the prototype in timer.h or so (so
I don't have to extern declare it), but he hasn't gotten around to it
yet.

Joel

-- 

Life's Little Instruction Book #30

	"Never buy a house without a fireplace."

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
