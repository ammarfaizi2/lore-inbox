Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSHOOhm>; Thu, 15 Aug 2002 10:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317030AbSHOOhm>; Thu, 15 Aug 2002 10:37:42 -0400
Received: from ppp77-4-71.miem.edu.ru ([194.226.32.71]:23424 "EHLO null.ru")
	by vger.kernel.org with ESMTP id <S317023AbSHOOhl>;
	Thu, 15 Aug 2002 10:37:41 -0400
Message-ID: <3D5BBBE4.6070301@yahoo.com>
Date: Thu, 15 Aug 2002 18:34:12 +0400
From: Stas Sergeev <stssppnn@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] New PC-Speaker driver
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Denis Vlasenko wrote:
 > I'm afraid I'll disappoint you guys but chances of
 > getting this into mainline
Well, I not counting on that too much myself too,
but only because the code is currently not ready.

 > 1.New motherboards have built-in sound,
Not all af them (my K7M doesn't) and there are a
lot of old ones. Note that linux still supports 386.

 > it may be crappy but definitely
 >   better than PC speaker.
Of course but they require an external speakers while
the speaker is always present:)

 > Since they may
 >   be wired differently, you can't be sure which way you
 > can force maximum amplitude
 >   on a particular mobo (there are 2 or 3 ways to reach 
 > max on different mobos.
Hmm, that sounds strange to me... Could you provide
some details?

 > 3.It loads CPU enormously.
Hmm, but it shouldn't. It used to work on my 486DX4-120
without loading CPU too much (not more than 3% - 5%) and
on my Athlon700 the load is not noticeable absolutely.
Yes, it speeds up the timer ints from 100Hz to 18.5KHz,
but the handler is very lightweight, what it does it
mainly just restarts the timer. What is this CPU you
have there that gets overloaded?

 > In short: making it work right on wide variety of 
 > hardware is next to impossible
And I think quite opposite: it works already on most
hardware and with trivial workarounds like disabling
APM idle calls, it can work on even more. What it really
doesn't like is when interrupts are disabled for too long,
but, as noted by Daniel Phillips, this is a bad condition
for many other things as well.

 > and even then results are mediocre (low volume, radio
 > quality).
Yep, that's the tradeoff for getting 6-bit sound from
a single-bit device:)

 > Maybe ALSA team have some member
 > crazy enough to join you.
The main problem with ALSA, which can also be a final
problem of getting that in, is that Jaroslav doesn't
like the whole idea of a pc-speaker driver. But I have
a hope that if the driver works well and the code is
also good, he may reconsider:)

 > It won't work well for everybody, then it won't live in
 > mainline.
Hey, how many drivers are marked Absolete, Experemental
or even Dangerous? This driver can be marked Experemental
at the end.

 > Because newcomers will enable it, be pissed off with crap 
 > sound etc...
Guess what the most newcomers does with the
CONFIG_EXPEREMENTAL option? :)

 > Keeping it as a separate patch is completely sane thing 
 > to do.
... at least for the near future, yes. But probably not forever
as there appears to be some demand, even more than I 
initially expected. After all I think that user's demand is 
rather strong argument for having any particular feature 
when the contrary arguments is only that it won't work in
some rare cases (but won't break anything either).

