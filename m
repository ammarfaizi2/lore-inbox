Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283163AbRLQXje>; Mon, 17 Dec 2001 18:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283204AbRLQXjZ>; Mon, 17 Dec 2001 18:39:25 -0500
Received: from hera.cwi.nl ([192.16.191.8]:65438 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S283163AbRLQXjJ>;
	Mon, 17 Dec 2001 18:39:09 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 17 Dec 2001 23:38:52 GMT
Message-Id: <UTC200112172338.XAA43277.aeb@cwi.nl>
To: torvalds@transmeta.com
Subject: Re: [PATCH] kill(-1,sig)
Cc: Andries.Brouwer@cwi.nl, acahalan@cs.uml.edu, gandalf@wlug.westbo.se,
        linux-kernel@vger.kernel.org, reality@delusion.de, sim@netnation.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries:

  The new POSIX 1003.1-2001 is explicit about what kill(-1,sig)
  is supposed to do. Maybe we should follow it.

Linus:

  Note that I've reverted the kill(-1...) thing in my personal tree: so far
  I've gotten a lot of negative feedback, and the change doesn't seem to
  actually buy us anything except for conformance to a unclearly weasel-
  worded standards sentence where we could be even more weasely and just say
  that "self" is a special process from the systems perspective.


Well, maybe you are too pessimistic, but I do not disagree
with your action (since I cannot easily see a better one).

There have been two discussion fragments: firstly people that muttered
that it is a pity when "kill -9 -1" kills their shell.
I do not care, especially since we got the reports that that also
happens on Digital UNIX and on Solaris.

And secondly people that complain that now their shutdown sequence
is broken. That is more serious: it became difficult for a program
other than init to handle the shutdown.

"self" is a nice and clean concept; I do not see anything clean
it could be replaced with.  I wonder what other systems do.

Andries

