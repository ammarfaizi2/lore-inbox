Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269806AbRHDFoF>; Sat, 4 Aug 2001 01:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269807AbRHDFnz>; Sat, 4 Aug 2001 01:43:55 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:20996 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269806AbRHDFnq>;
	Sat, 4 Aug 2001 01:43:46 -0400
Date: Sat, 4 Aug 2001 02:43:41 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Jeremy Linton <jlinton@interactivesi.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Free memory starvation in a zone?
In-Reply-To: <Pine.LNX.4.33.0108040724320.873-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33L.0108040243040.2526-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Aug 2001, Mike Galbraith wrote:

> > Are you sure you're seeing kreclaimd looping too much here ?
>
> Snippet from one of Dirk's logs.
>
>   PID  PPID USER     PRI  SIZE SWAP  RSS SHARE   D STAT %CPU %MEM   TIME COMMA
>     3     1 root      20     0    0    0     0   0 RW   58.8  0.0   2:41 kswapd
>  1494  1421 novatest  15 2009M 640M 1.3G 51476  0M R N  40.8 34.5   6:26 ceqsim
>  1751  1747 root      14  1048    4 1044   824  55 R    28.0  0.0   0:02 top
>     4     1 root      14     0    0    0     0   0 SW   27.1  0.0   1:06 krecla

I'm pretty sure this is because kreclaimd is woken up from
__alloc_pages() all the time and cannot find anything useful
to do ...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

