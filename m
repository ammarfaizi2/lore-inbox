Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282898AbRLQWFh>; Mon, 17 Dec 2001 17:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282902AbRLQWF1>; Mon, 17 Dec 2001 17:05:27 -0500
Received: from chaos.analogic.com ([204.178.40.224]:28544 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S282898AbRLQWFP>; Mon, 17 Dec 2001 17:05:15 -0500
Date: Mon, 17 Dec 2001 17:06:47 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Udo A. Steinberg" <reality@delusion.de>, Simon Kirby <sim@netnation.com>,
        Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill(-1,sig)
In-Reply-To: <Pine.LNX.4.33.0112171311400.1587-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.95.1011217165844.6895A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Linus Torvalds wrote:

> 
> Note that I've reverted the kill(-1...) thing in my personal tree: so far
> I've gotten a lot of negative feedback, and the change doesn't seem to
> actually buy us anything except for conformance to a unclearly weasel-
> worded standards sentence where we could be even more weasely and just say
> that "self" is a special process from the systems perspective.
> 
> 		Linus
> 

Isn't the de-facto standard that:

kill -<sig> -1

... should send the signal to everyone but the one executing the call?

For years, the "quick way" to shut down a Unix system was:

kill -TERM -1
sync
kill -KILL -1
sync
umount -a

... hit power switch...

Eliminating the ability to shut down a system in a few seconds is
gonna make a lot of persons unhappy --especially if one has to run
the RH kiddie scripts that take forever...... 



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).
 Santa Claus is coming to town...
          He knows if you've been sleeping,
             He knows if you're awake;
          He knows if you've been bad or good,
             So he must be Attorney General Ashcroft.


