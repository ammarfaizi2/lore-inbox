Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131094AbRAQTR7>; Wed, 17 Jan 2001 14:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131406AbRAQTRk>; Wed, 17 Jan 2001 14:17:40 -0500
Received: from inje.iskon.hr ([213.191.128.16]:56334 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S131094AbRAQTRc>;
	Wed, 17 Jan 2001 14:17:32 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.31.0101171546130.5464-100000@localhost.localdomain>
Reply-To: zlatko@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko@iskon.hr>
Date: 17 Jan 2001 19:53:31 +0100
In-Reply-To: Rik van Riel's message of "Wed, 17 Jan 2001 15:48:39 +1100 (EST)"
Message-ID: <87wvburowk.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Peisino,Ak(B)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> > Second test: kernel compile make -j32 (empirically this puts the
> > VM under load, but not excessively!)
> >
> > 2.2.17 -> make -j32  392.49s user 47.87s system 168% cpu 4:21.13 total
> > 2.4.0  -> make -j32  389.59s user 31.29s system 182% cpu 3:50.24 total
> >
> > Now, is this great news or what, 2.4.0 is definitely faster.
> 
> One problem is that these tasks may be waiting on kswapd when
> kswapd might not get scheduled in on time. On the one hand this
> will mean lower load and less thrashing, on the other hand it
> means more IO wait.
> 

Hm, if all tasks are waiting for memory, what is stopping kswapd to
run? :)
-- 
Zlatko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
