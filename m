Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280801AbRKTA2T>; Mon, 19 Nov 2001 19:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280803AbRKTA2J>; Mon, 19 Nov 2001 19:28:09 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:41736 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280801AbRKTA1x>;
	Mon, 19 Nov 2001 19:27:53 -0500
Date: Mon, 19 Nov 2001 22:27:38 -0200 (BRST)
From: Rik van Riel <riel@marcelothewonderpenguin.com>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Simon Kirby <sim@netnation.com>, Andrea Arcangeli <andrea@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: VM-related Oops: 2.4.15pre1
In-Reply-To: <Pine.LNX.4.33.0111191607110.19585-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0111192226320.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2001, Linus Torvalds wrote:

> Well, you also have to check that the page isn't on the LRU list, so it
> would have to be something like
>
> 	!page->mapping && !PageLRU(page)
>
> which I agree is ugly.

I guess we should have "clean up VM locking" in our TODO
list for 2.5, then.  The current combination of 2.0, 2.2
and 2.4 locking makes for rather hard to maintain code ;)

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

