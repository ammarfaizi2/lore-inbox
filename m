Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281552AbRLRMYb>; Tue, 18 Dec 2001 07:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281557AbRLRMYW>; Tue, 18 Dec 2001 07:24:22 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:1809 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281552AbRLRMYK>; Tue, 18 Dec 2001 07:24:10 -0500
Date: Tue, 18 Dec 2001 10:23:58 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33.0112172153410.2416-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0112181021520.10000-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Linus Torvalds wrote:
> On Mon, 17 Dec 2001, William Lee Irwin III wrote:
> >
> >   5:   46490271          XT-PIC  soundblaster
> >
> > Approximately 4 times more often than the timer interrupt.
> > That's not nice...

That's not nearly as much as your typical server system runs
in network packets and wakeups of the samba/database/http
daemons, though ...

> Well, looking at the issue, the problem is probably not just in the sb
> driver: the soundblaster driver shares the output buffer code with a
> number of other drivers (there's some horrible "dmabuf.c" code in common).

So you fixed it for the sound driver, nice.  We still have
the issue tha the scheduler can take up lots of time on busy
server systems, though.

(though I suspect on those systems it probably spends more
time recalculating than selecting processes)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

