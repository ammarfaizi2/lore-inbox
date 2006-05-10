Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWEJNJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWEJNJe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 09:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWEJNJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 09:09:34 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:53686 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751190AbWEJNJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 09:09:33 -0400
Date: Wed, 10 May 2006 09:09:14 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Gleb Natapov <gleb@minantech.com>
cc: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Document futex PI design
In-Reply-To: <20060510124600.GN5319@minantech.com>
Message-ID: <Pine.LNX.4.58.0605100854540.3282@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605090954150.7007@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605100331290.31598@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605100429220.436@gandalf.stny.rr.com> <20060510101729.GB31504@elte.hu>
 <Pine.LNX.4.58.0605100657510.2485@gandalf.stny.rr.com> <20060510124600.GN5319@minantech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 May 2006, Gleb Natapov wrote:

> On Wed, May 10, 2006 at 06:59:49AM -0400, Steven Rostedt wrote:
> > +lock	 - In this document from now on, the term lock and spin lock will
> > +	   be synonymous.  These are locks that are used for SMP as well
> > +	   as turning off preemption to protect areas of code on SMP machines.
> Should the last SMP be UP?
>

Grmb, I should fix that definition.

No, it should still be SMP but the definition is awkward.  I need to state
that really, when I refer to "lock" I mean that I'm talking about raw spin
locks.  So it mainly protects SMP code, but also UP by disabling
preemption.  So I'm talking about a normal spin_lock.

I wrote this document generically so that it works for both the vanilla
kernel when talking about the PI of futexes, as well as when talking about
the -rt patch with its kernel mutexes.  In the -rt patch, spin locks turn
into mutexes, so I was stumbling over not mentioning spin_locks per se,
but was trying to explain them as just spinning locks.

Anyway, I should rewrite that definition.

Thanks for the feedback,

-- Steve

