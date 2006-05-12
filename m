Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWELNqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWELNqf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 09:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWELNqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 09:46:35 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:46056 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932069AbWELNqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 09:46:35 -0400
Date: Fri, 12 May 2006 09:46:09 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Molnar <mingo@elte.hu>
cc: Mark Hounschell <markh@compro.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, akpm@osdl.org
Subject: Re: 3c59x vortex_timer rt hack (was: rt20 patch question)
In-Reply-To: <20060512133627.GA30447@elte.hu>
Message-ID: <Pine.LNX.4.58.0605120945270.30264@gandalf.stny.rr.com>
References: <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
 <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com>
 <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com>
 <20060512081628.GA26736@elte.hu> <Pine.LNX.4.58.0605120435570.28581@gandalf.stny.rr.com>
 <20060512092159.GC18145@elte.hu> <Pine.LNX.4.58.0605120904110.30264@gandalf.stny.rr.com>
 <20060512133627.GA30447@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 May 2006, Ingo Molnar wrote:

> >
> > BTW, I originally thought about having Mark do this, but I'm nervious
> > about the side effects that this might have.  Basically, it's doing
> > ioreads from the device while the interrupt could be doing iowrites.
>
> yes, that can happen - but since this is a timeout, this is rather
> unlikely in practice. Nevertheless it's possible, so i marked the code a
> hack.
>

Yes, but this is the source of Mark's bug, so he is definitely hitting it.

-- Steve

