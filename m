Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272579AbRHaB2i>; Thu, 30 Aug 2001 21:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272580AbRHaB23>; Thu, 30 Aug 2001 21:28:29 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:63498 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S272579AbRHaB2Y>;
	Thu, 30 Aug 2001 21:28:24 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108310128.f7V1S3q18739@oboe.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.4.33.0108301753180.2569-100000@penguin.transmeta.com>
 from "Linus Torvalds" at "Aug 30, 2001 05:55:51 pm"
To: "Linus Torvalds" <torvalds@transmeta.com>
Date: Fri, 31 Aug 2001 03:28:03 +0200 (MET DST)
CC: "Peter T. Breuer" <ptb@it.uc3m.es>,
        "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>,
        linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Linus Torvalds wrote:"
> 
> On Fri, 31 Aug 2001, Peter T. Breuer wrote:
> >
> > To give you all something definite to look at, here's some test code:
> 
> Hmm.. This might be a good idea, actually. Have you tried whether it finds
> something in the existing tree (you could just take the existing macro and

Yes. I just tried it. The first warning thrown up for 2.4.8 was in
tun.c, when I did a make modules. Obviously it all depends on my
  .config as to what it finds!  I put in a asm(".error_here") instead of
BUG() so the compilation stops at every problem instead of warning and
continuing. Hence I don't kow the total. I can try and see ..

It's very late here (spain) so I don't trust myself to do much
hacking of code right now .. I corrected the tun.c code (it was
harmless) and posted the first bit of output a little while ago.
It should be down your mail client page a bit.

> ignore the first argument)?
> 
> This would definitely be acceptable to me, and should (assuming no gcc
> optimization bugs) work with no run-time overhead.


Peter
