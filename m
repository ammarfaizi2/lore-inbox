Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319350AbSH2VSz>; Thu, 29 Aug 2002 17:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319368AbSH2VSz>; Thu, 29 Aug 2002 17:18:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:59891 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S319350AbSH2VSy>;
	Thu, 29 Aug 2002 17:18:54 -0400
Message-ID: <3D6E90AB.FBA3BDE6@mvista.com>
Date: Thu, 29 Aug 2002 14:22:51 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
References: <Pine.LNX.4.44.0208281649540.27728-100000@home.transmeta.com> <1030618420.7290.112.camel@irongate.swansea.linux.org.uk> <aklq8b$220$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <1030618420.7290.112.camel@irongate.swansea.linux.org.uk>,
> Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
> >>  { min-Hz, max-Hz, policy }
> >>
> >
> >For a few of the processors "event-hz" or similar would be nice. The
> >Geode supports hardware assisted bursting to full processor speed when
> >doing SMM, I/O and IRQ handling.
> 
> Hmm.. I would assume that you'd just use the high frequency for that?
> So, for example, assuming you have a 600/300 Geode, when you do
> 
>         { 0, ~0UL, "power-save" }
> 
> that would tell the Geode driver to run at 300MHz normally
> ("power-save"), and at 600Mhz when doing critical events.
> 
> In contrast, a
> 
>         { 0, ~0UL, "performance" }
> 
> mode would mean that it always runs at 600MHz (modulo heat throttling,
> of course).
> 
> And a
> 
>         { 300, 300, "power-save" }

How about { 50, 50, "power-save" }  where the number refers
to percent of full?
I.e. same meaning IFF full is 600, but suppose it is 800.
> 
> means that you want the chip to always run at 300MHz, even when handling
> critical events.
> 
> I don't know the exact details of what kinds of frequencies the Geode
> supports, but it sounds to me like you don't really need another
> frequency value..
> 
>                 Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
