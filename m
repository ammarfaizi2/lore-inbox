Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266529AbRGGUMT>; Sat, 7 Jul 2001 16:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266530AbRGGUMK>; Sat, 7 Jul 2001 16:12:10 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:14610 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266529AbRGGUL5>; Sat, 7 Jul 2001 16:11:57 -0400
Date: Sat, 7 Jul 2001 17:11:49 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33.0107071146320.31249-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0107071710180.1389-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jul 2001, Linus Torvalds wrote:

> In fact, I do not see any part of the whole path that sets the
> page age at all, so we're basically using a completely
> uninitialized field here (it's been initialized way back when
> the page was allocated, but because it hasn't been part of the
> normal aging scheme it has only been aged up, never down, so the
> value is pretty much random by the time we actually add it to
> the swap cache pool).

Not quite. The more a page has been used, the higher the
page->age will be. This means the system has a way to
distinguish between anonymous pages which were used once
and anonymous pages which are used lots of times.


> Suggested fix:

	[snip disabling of page aging for anonymous memory]

> That would certainly help explain why aging doesn't work for some people.

As would your patch ;)

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

