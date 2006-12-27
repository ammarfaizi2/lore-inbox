Return-Path: <linux-kernel-owner+w=401wt.eu-S932977AbWL0Pl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932977AbWL0Pl7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 10:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932976AbWL0Pl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 10:41:59 -0500
Received: from web32608.mail.mud.yahoo.com ([68.142.207.235]:30567 "HELO
	web32608.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932977AbWL0Pl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 10:41:59 -0500
Message-ID: <20061227154158.54796.qmail@web32608.mail.mud.yahoo.com>
X-YMail-OSG: GC86CTUVM1mgF3eM_2bnTuLsg0uElxPs3uAt0i09sU8buhbu6M_uyaifSJImWNkaj5SWnhTINAEbkRQeNSnBbYtMJckzggQ12WLECpHy6HQaePhLBqP.fw--
X-RocketYMMF: knobi.rm
Date: Wed, 27 Dec 2006 07:41:58 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: How to detect multi-core and/or HT-enabled CPUs in 2.4.x and 2.6.x kernels
To: Gleb Natapov <glebn@voltaire.com>, Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061227152240.GC10953@minantech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Gleb Natapov <glebn@voltaire.com> wrote:

> On Wed, Dec 27, 2006 at 04:13:00PM +0100, Arjan van de Ven wrote:
> > The original p4 HT to a large degree suffered from a too small
> cache
> > that now was shared. SMT in general isn't per se all that different
> in
> > performance than dual core, at least not on a fundamental level,
> it's
> > all a matter of how many resources each thread has on average. With
> dual
> > core sharing the cache for example, that already is part HT.
> Putting the
> > "boundary" at HT-but-not-dual-core is going to be highly artificial
> and
> > while it may work for the current hardware, in general it's not a
> good
> > way of separating things (just look at the PowerPC processors,
> those are
> > highly SMT as well), and I suspect that your distinction is just
> going
> > to break all the time over the next 10 years ;) Or even today on
> the
> > current "large cache" P4 processors with HT it already breaks.
> (just
> > those tend to be the expensive models so more rare)
> > 
> If I run two threads that are doing only calculations and very little
> or no
> IO at all on the same socket will modern HT and dual core be the same
> (or close) performance wise?
> 
Hi Gleb,
 
 this is a real interesting question. Ganglia is coming [originally]
from the HPC side of computing. At least in the past HT as implemented
on XEONs did help a lot. Running two CPU+memory-bandwith intensive
processes on the same physical CPU would at best result in a 50/50
performance split. So, knowing how many "real" CPUs are in a system is
interesting to us.

 Other workloads (like lots of java threads doing mixed IO and CPU
stuff) of course can benefit from HT.

Cheers
Martin

------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
