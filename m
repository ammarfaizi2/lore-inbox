Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132030AbRCYPJG>; Sun, 25 Mar 2001 10:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132032AbRCYPIr>; Sun, 25 Mar 2001 10:08:47 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:42765 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132030AbRCYPIp>; Sun, 25 Mar 2001 10:08:45 -0500
Date: Sun, 25 Mar 2001 12:06:56 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "James A. Sutherland" <jas88@cam.ac.uk>,
        Guest section DW <dwguest@win.tue.nl>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OOM handling
In-Reply-To: <3ABDF8A6.7580BD7D@evision-ventures.com>
Message-ID: <Pine.LNX.4.21.0103251156450.1863-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Mar 2001, Martin Dalecki wrote:

> Ah... and of course I think this patch can already go directly 
> into the official kernel. The quality of code should permit 
> it. I would esp. request Rik van Riel to have a closer look
> at it...

- the algorithms are just as much black magic as the old ones
- it hasn't been tested in any other workload than your Oracle
  server (at least, not that I've heard of)
- the comments are just too rude  ;)
  (though fun)
- the AGE_FACTOR calculation will overflow after the system has
  an uptime of just _3_ days 
- your code might be good for server loads, but for normal
  users it will kill what amounts to a random process ... this
  is horribly wrong for desktop systems

In short, I like some of your ideas, but I really fail to see why
this version of the code would be any better than what we're having
now. In fact, since there seem to be about 1000x more desktop boxes
than Oracle boxes (probably even more), I'd say that the current
algorithm in the kernel is better (since it's right for more systems).

Now if you can make something which preserves the heuristics which
serve us so well on desktop boxes and add something that makes it
also work on your Oracle servers, then I'd be interested.

Alternatively, I also wouldn't mind a completely new algorithm, as
long as it turns out to work well on desktop boxes too. But remember
that we cannot tell this without first testing the thing on a few
dozen (hundreds?) of machines with different workloads...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/




