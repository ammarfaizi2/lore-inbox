Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318670AbSHEPmR>; Mon, 5 Aug 2002 11:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318678AbSHEPmR>; Mon, 5 Aug 2002 11:42:17 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:16553 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318670AbSHEPmQ>; Mon, 5 Aug 2002 11:42:16 -0400
Date: Mon, 5 Aug 2002 16:44:40 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@muc.de>, Richard Zidlicky <rz@linux-m68k.org>,
       Jeff Dike <jdike@karaya.com>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode linux]
Message-ID: <20020805164440.A7285@kushida.apsleyroad.org>
References: <m3u1mb5df3.fsf@averell.firstfloor.org> <Pine.LNX.4.44.0208051223430.8173-100000@localhost.localdomain> <20020805164126.D7130@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020805164126.D7130@kushida.apsleyroad.org>; from lk@tantalophile.demon.co.uk on Mon, Aug 05, 2002 at 04:41:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Ingo Molnar wrote:
> > And threads can do queued events that amortizes context switch
> > overhead, while queued signals generate per-event signal delivery, so
> > signal delivery costs are not amortized.
> > 
> > (Not that i advocate SIGIO or helper threads for highperformance IO -
> > Ben's aio interface is the fastest and most correct approach.)
> 
> Isn't the per-event queued signal cost amortised when using sigwaitinfo()?

Of course I meant:

  Isn't the per-event queued signal cost amortised when using sigtimedwait()?

cheers,
-- Jamie
