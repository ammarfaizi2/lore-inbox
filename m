Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272427AbRH3UQl>; Thu, 30 Aug 2001 16:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272428AbRH3UQW>; Thu, 30 Aug 2001 16:16:22 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:56585 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S272427AbRH3UQR>;
	Thu, 30 Aug 2001 16:16:17 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108302016.f7UKGJ707405@oboe.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <20010830215151.A14715@khan.acc.umu.se> from "David Weinehall" at
 "Aug 30, 2001 09:51:52 pm"
To: "David Weinehall" <tao@acc.umu.se>
Date: Thu, 30 Aug 2001 22:16:19 +0200 (MET DST)
CC: "Peter T. Breuer" <ptb@it.uc3m.es>,
        "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago David Weinehall wrote:"
> On Thu, Aug 30, 2001 at 06:38:40PM +0200, Peter T. Breuer wrote:
> > "Linus Torvalds wrote:"
> > > What if the "int" happens to be negative?
> > 
> >    if sizeof(typeof(a)) != sizeof(typeof(b)) 
> >        BUG() // sizes differ
> >    const (typeof(a)) _a = ~(typeof(a))0   
> >    const (typeof(b)) _b = ~(typeof(b))0   
> >    if _a < 0 && _b > 0 || _a > 0 && b < 0
> >        BUG() // one signed, the other unsigned
> >    standard_max(a,b)
> 
> <disgusting vomit-sound>Do you really want code like that in the
> kernel (yes, I know that there are code that can compete with it in

Have you read it? Do you not realize That it optimizes down to BUG() or
the standard min/max? By BUG(), I was hoping that somebody could 
produce some magic that doesn't even compile when it reduces to that,
but maybe that's too much to hope for from gcc.

> ugliness</disgusting vomit-sound>

If that's the limit of the audiences intelligence, I don't think
I'll bother bothering to think next time! I rather hoped instead
for people to pick up the idea and tell me about the problem
left to cover (void* ? what if the arch does not have 2's complement
arithmetic?)

Peter
