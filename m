Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135304AbRAGWY1>; Sun, 7 Jan 2001 17:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135780AbRAGWYR>; Sun, 7 Jan 2001 17:24:17 -0500
Received: from inje.iskon.hr ([213.191.128.16]:42251 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S135304AbRAGWX6>;
	Sun, 7 Jan 2001 17:23:58 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm-cleanup-1 (2.4.0)
In-Reply-To: <Pine.LNX.4.21.0101071917250.21675-100000@duckman.distro.conectiva>
Reply-To: zlatko@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko@iskon.hr>
Date: 07 Jan 2001 23:23:38 +0100
In-Reply-To: Rik van Riel's message of "Sun, 7 Jan 2001 19:18:31 -0200 (BRDT)"
Message-ID: <873dev57dh.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Peisino,Ak(B)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On 7 Jan 2001, Zlatko Calusic wrote:
> 
> > OK, maybe I was too fast in concluding with that change. I'm
> > still trying to find out why is MM working bad in some
> > circumstances (see my other email to the list).
> > 
> > Anyway, I would than suggest to introduce another /proc entry
> > and call it appropriately: max_async_pages. Because that is what
> > we care about, anyway. I'll send another patch.
> 
> In fact, that's NOT what we care about.
> 
> What we really care about is the number of disk seeks
> the VM subsystem has queued to disk, since it's seek
> time that causes other requests to suffer bad latency.
> 

Yes, but that's not what we have in the code now. I'm just trying to
make it little easier for the end user to tune his system. Right now
things are quite complicated and misleading for the uninitiated.

If we are to optimize things better in the future, then be it, but I
would like first to clean some historical cruft.

I'm a quite pedantical guy, you know. :)
-- 
Zlatko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
