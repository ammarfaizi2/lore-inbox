Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262114AbRETRfX>; Sun, 20 May 2001 13:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262118AbRETRfN>; Sun, 20 May 2001 13:35:13 -0400
Received: from inje.iskon.hr ([213.191.128.16]:30143 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S262114AbRETRfJ>;
	Sun, 20 May 2001 13:35:09 -0400
To: Mike Galbraith <mikeg@wen-online.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.33.0105191743000.393-100000@mikeg.weiden.de>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 20 May 2001 15:44:12 +0200
In-Reply-To: <Pine.LNX.4.33.0105191743000.393-100000@mikeg.weiden.de>
Message-ID: <8766ew16fn.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.2 (Urania)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <mikeg@wen-online.de> writes:

> Hi,
> 
> On Fri, 18 May 2001, Stephen C. Tweedie wrote:
> 
> > That's the main problem with static parameters.  The problem you are
> > trying to solve is fundamentally dynamic in most cases (which is also
> > why magic numbers tend to suck in the VM.)
> 
> Magic numbers might be sucking some performance right now ;-)
> 
[snip]

I like your patch, it improves performance somewhat and makes things
more smooth and also code is simpler.

Anyway, 2.4.5-pre3 is quite debalanced and it has even broken some
things that were working properly before. For instance, swapoff now
deadlocks the machine (even with your patch applied).

Unfortunately, I have failed to pinpoint the exact problem, but I'm
confident that kernel goes in some kind of loop (99% system time, just
before deadlock). Anybody has some guidelines how to debug kernel if
you're running X?

Also in all recent kernels, if the machine is swapping, swap cache
grows without limits and is hard to recycle, but then again that is
a known problem.
-- 
Zlatko
