Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132614AbRDKPy7>; Wed, 11 Apr 2001 11:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132616AbRDKPyt>; Wed, 11 Apr 2001 11:54:49 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:39441 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S132613AbRDKPyh>;
	Wed, 11 Apr 2001 11:54:37 -0400
Date: Wed, 11 Apr 2001 12:53:16 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: george anzinger <george@mvista.com>
Cc: SodaPop <soda@xirr.com>, alexey@datafoundation.com,
        linux-kernel@vger.kernel.org
Subject: Re: [test-PATCH] Re: [QUESTION] 2.4.x nice level
In-Reply-To: <Pine.LNX.4.21.0104110726210.25737-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0104111251040.25737-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2001, Rik van Riel wrote:

> OK, here it is. It's nothing like montavista's singing-dancing
> scheduler patch that does all, just a really minimal change that
> should stretch the nice levels to yield the following CPU usage:
> 
> Nice    0    5   10   15   19
> %CPU  100   56   25    6    1

  PID USER     PRI  NI  SIZE SWAP  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  980 riel      17   0   296    0  296   240 R    54.1  0.5  54:19 loop
 1005 riel      16   5   296    0  296   240 R N  27.0  0.5   0:34 loop
 1006 riel      17  10   296    0  296   240 R N  13.5  0.5   0:16 loop
 1007 riel      18  15   296    0  296   240 R N   4.5  0.5   0:05 loop
  987 riel      20  19   296    0  296   240 R N   0.4  0.5   0:25 loop

... is what I got when testing it here. It seems that nice levels
REALLY mean something with the patch applied ;)

You can get it at http://www.surriel.com/patches/2.4/2.4.3ac4-largenice

Since there seems to be quite a bit of demand for this feature,
please test it and try to make it break. If it doesn't break we
can try to put it in the kernel...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

