Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264039AbRFEQxe>; Tue, 5 Jun 2001 12:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264042AbRFEQxX>; Tue, 5 Jun 2001 12:53:23 -0400
Received: from inje.iskon.hr ([213.191.128.16]:52382 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S264034AbRFEQxM>;
	Tue, 5 Jun 2001 12:53:12 -0400
To: Ed Tomlinson <tomlins@cam.org>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Comment on patch to remove nr_async_pages limit
In-Reply-To: <Pine.LNX.4.33.0106051140270.1227-100000@mikeg.weiden.de>
	<01060507422800.28232@oscar>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 05 Jun 2001 18:08:45 +0200
In-Reply-To: <01060507422800.28232@oscar> (Ed Tomlinson's message of "Tue, 5 Jun 2001 07:42:28 -0400")
Message-ID: <87u21uykmq.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Copyleft)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> writes:

[snip]
> Maybe we can have the best of both worlds.  Is it possible to allocate the BH
> early and then defer the IO?  The idea being to make IO possible without having
> to allocate.  This would let us remove the async page limit but would ensure
> we could still free.
> 

Yes, this is a good idea if you ask me. Basically, to remove as many
limits as we can, and also to secure us from the deadlocks. With just
a few pages of extra memory for the reserved buffer heads, I think
it's a fair game. Still, pending further analysis...
-- 
Zlatko
