Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSEMLqM>; Mon, 13 May 2002 07:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSEMLqL>; Mon, 13 May 2002 07:46:11 -0400
Received: from inje.iskon.hr ([213.191.128.16]:55224 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S313060AbSEMLqF>;
	Mon, 13 May 2002 07:46:05 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: Bill Davidsen <davidsen@tmr.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] IO wait accounting
In-Reply-To: <Pine.LNX.4.44L.0205121812500.32261-100000@imladris.surriel.com>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Mon, 13 May 2002 13:45:54 +0200
Message-ID: <dnvg9sfez1.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On Sun, 12 May 2002, Zlatko Calusic wrote:
>> Rik van Riel <riel@conectiva.com.br> writes:
>> >
>> > And should we measure read() waits as well as page faults or
>> > just page faults ?
>>
>> Definitely both.
>
> OK, I'll look at a way to implement these stats so that
> every IO wait counts as iowait time ... preferably in a
> way that doesn't touch the code in too many places ;)
>
>> Somewhere on the web was a nice document explaining
>> how Solaris measures iowait%, I read it few years ago and it was a
>> great stuff (quite nice explanation).
>>
>> I'll try to find it, as it could be helpful.
>
> Please, it would be useful to get our info compatible with
> theirs so sysadmins can read their statistics the same on
> both systems.
>

Yes, that would be nice. Anyway, finding the document I mentioned will
be much harder than I thought. Googling last 15 minutes didn't make
progress. But, I'll keep trying.

Anyway, here is how Aix defines it:

 Average percentage of CPU time that the CPUs were idle during which
 the system had an outstanding disk I/O request. This value may be
 inflated if the actual number of I/O requesting threads is less than
 the number of idling processors.

(http://support.bull.de/download/redbooks/Performance/OptimizingYourSystemPerformance.pdf)

Also, Sun has a nice collection of articles at
http://www.sun.com/sun-on-net/itworld/, and among them
http://www.sun.com/sun-on-net/itworld/UIR981001perf.html which speaks
about wait time, but I'm still searching for a more technical document...
-- 
Zlatko
