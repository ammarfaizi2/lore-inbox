Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276118AbRJILsT>; Tue, 9 Oct 2001 07:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276120AbRJILsJ>; Tue, 9 Oct 2001 07:48:09 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:34311 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S276118AbRJILsB>;
	Tue, 9 Oct 2001 07:48:01 -0400
Date: Tue, 9 Oct 2001 08:48:04 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, <linux-xfs@oss.sgi.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: %u-order allocation failed
In-Reply-To: <Pine.LNX.4.33.0110081647550.1064-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0110090846050.2847-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001, Linus Torvalds wrote:
> On Tue, 9 Oct 2001, Mikulas Patocka wrote:
> >
> > Linus, what do you think: is it OK if fork randomly fails with very small
> > probability or not?
>
> I've never seen it, I've never heard it reported, and I _know_ that
> vmalloc() causes slowdowns.

I've seen it happen during stresstest of an underpowered
test box. When that point is reached, the system usually
is already so far overloaded there's little point in
allowing extra processes to be started.

> In short, I'm not switching to a vmalloc() fork.

The only real use I could see would be to allow root to
start up some commands to save the box when it's going
down the drain.  Probably not worth it since root could
have just used ulimit for the normal users ;)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

