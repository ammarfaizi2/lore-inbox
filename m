Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286176AbRLJG5J>; Mon, 10 Dec 2001 01:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286174AbRLJG5A>; Mon, 10 Dec 2001 01:57:00 -0500
Received: from [195.66.192.167] ([195.66.192.167]:12041 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S286172AbRLJG4k>; Mon, 10 Dec 2001 01:56:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Samium Gromoff <_deepfire@mail.ru>,
        gandalf@wlug.westbo.se (Martin Josefsson)
Subject: Re: 2.4.12-ac4 10Mbit NE2k interrupt load kills p166
Date: Mon, 10 Dec 2001 08:54:56 -0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200112082158.fB8Lw4012155@vegae.deep.net>
In-Reply-To: <200112082158.fB8Lw4012155@vegae.deep.net>
MIME-Version: 1.0
Message-Id: <01121008545601.01013@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, this will most likely fall under
'almost nobody interested in fiddling with old hw' category...

On Saturday 08 December 2001 19:58, Samium Gromoff wrote:
> "  Martin Josefsson wrote:"
> > I had an AMD K6 200 with an ISA NE2K card whan I started using Linux...
> > I started using kernel 2.0 and that card worked very nice.
> > I could even play quake while sending out data at 10Mbit/s, I didn't even
> > notice that the transfer had started.
> >
> > Then I upgraded to kernel 2.2 and I was no longer able to play quake
> > while tranmitting at 10Mbit/s with the exact same hardware. Sometimes I
> > could hardly even play mp3's :(
> >
> > Then a friend of mine that also upgraded to kernel 2.2 began complaining
> > that his machine also became extremely slow and unresponsive while
> > transitting at 10Mbit/s, in fact that machine was even slower than mine
> > during the transfers and his cpu was a bit faster than mine (also AMD).
> >
> > Then I upgraded that machine to pIII 700 and even that machine slows to a
> > crawl while transmitting with that bloody ISA NE2K. It's the same thing
> > in kernel 2.4 too. These days I simply don't use that card anymore...
> >
> > So something seems to have taken a wrong turn between 2.0 and 2.2
> > I don't think this is a problem intruduced in 2.4.
>
>     The question is whether anybody is interesting in investigation of
>   such broken behaviour.
>     i`ve made a further research and discovered the fact that
> 	ping -l 99999999 		- does not corrupt the sound
> 	ping -l 99999999 -s 256		- does not corrupt the sound
> 	ping -l 99999999 -s 512		- significantly corrupts the sound
> 	ping -l 99999999 -s 16384 	- heavily corrupts the sound with stalls
>
>     as a reminder -l xxxx option forces ping to spit out data as fast as
> possible making it a great bandwidth loader...
>
>     Initial look at the result makes me think that at certain level the
>    interrupt handler just takes too long time and preempts the sound driver
>    or whatever.
>     My thinking is that if 2.0 was better than 2.4 in this case, we
> definitely need to find out why was it so and use its strong side.
--
vda
