Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbULOAXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbULOAXH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbULOAW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:22:27 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:10375
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261745AbULOAQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 19:16:25 -0500
Subject: Re: [PATCH] fix spurious OOM kills
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Martin =?iso-8859-2?Q?MOKREJ=A9?= 
	<mmokrejs@ribosome.natur.cuni.cz>,
       Andrew Morton <akpm@osdl.org>, piggin@cyberone.com.au,
       chris@tebibyte.org, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Rik van Riel <riel@redhat.com>
In-Reply-To: <20041214235549.GT16322@dualathlon.random>
References: <419FB4CD.7090601@ribosome.natur.cuni.cz>
	 <1101037999.23692.5.camel@thomas> <41A08765.7030402@ribosome.natur.cuni.cz>
	 <1101045469.23692.16.camel@thomas>
	 <1101120922.19380.17.camel@tglx.tec.linutronix.de>
	 <41A2E98E.7090109@ribosome.natur.cuni.cz>
	 <1101205649.3888.6.camel@tglx.tec.linutronix.de>
	 <41BF0F0D.4000408@ribosome.natur.cuni.cz>
	 <20041214173858.GJ16322@dualathlon.random>
	 <1103067018.5420.37.camel@npiggin-nld.site>
	 <20041214235549.GT16322@dualathlon.random>
Content-Type: text/plain
Date: Wed, 15 Dec 2004 01:16:23 +0100
Message-Id: <1103069783.3406.97.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,

On Wed, 2004-12-15 at 00:55 +0100, Andrea Arcangeli wrote:
> On Wed, Dec 15, 2004 at 10:30:18AM +1100, Nick Piggin wrote:
> > Was there some swap-token (or can anyone think of any relevant)
> > changes recently?
> 
> The only thing I know about recent swap-token changes, is that Andrew
> fixed a bug by ignoring the token thing at priority 0, this the
> early-oom failures in my queue (the VM bug was introduced sometime
> before or during 2.6.9-rc). The fix is already in mainline according to
> my out of sync copy of kernel CVS.

cset 1.2055.40.21
vmscan: ignore swap token when in trouble 

It solves one of the problems, but your fix is really the only complete
fix I have in hands since this thread(s) started. + my simple changes to
the whom to kill selection :)

Also your modification slow down the machine in case of low memory. This
makes sense and does not hurt anybody. But it's still better than the
crappy oom kills which I still have with rc3 even in "normal" desktop
usage.

<RANT exclude="andrea">
We are discussing this since nearly two month. Is there a final fixup in
sight before christmas ? And I mean christmas 2004.

I'm just waiting for somebody who advises me to put more memory into my
boxes.
</RANT>

tglx


