Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264712AbSJUDWD>; Sun, 20 Oct 2002 23:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264714AbSJUDWD>; Sun, 20 Oct 2002 23:22:03 -0400
Received: from 2-136.ctame701-1.telepar.net.br ([200.193.160.136]:38334 "EHLO
	2-136.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S264712AbSJUDWA>; Sun, 20 Oct 2002 23:22:00 -0400
Date: Mon, 21 Oct 2002 01:27:37 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Jim Houston <jim.houston@attbi.com>
cc: linux-kernel@vger.kernel.org, <mingo@elte.hu>, <andrea@suse.de>,
       <jim.houston@ccur.com>
Subject: Re: [PATCH] Re: Pathological case identified from contest
In-Reply-To: <3DB36877.9EFF8AA4@attbi.com>
Message-ID: <Pine.LNX.4.44L.0210210122410.22993-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002, Jim Houston wrote:
> Rik van Riel wrote:

> > How long does it take for a best priority process to go
> > down ?
>
> I don't know yet.  My next step will be to instrument this.
> There are a many things that I can be tuned here, but I
> want the system to tune itself.

Negative feedback loops good.  Magic numbers bad.  ;)

Count me in for trying to get a self-tuning system working.
Note that I'll happily make one big exception for magic
numbers ... those magic numbers that directly influence how
the user percieves the machine's behaviour, since the speed
at which users observe things (and the timespan the machine
needs to react in) are fairly well known.

> > Or, for how much time can a newly started CPU hog starve
> > an older process ?

> The scheduler has no way to know which processes are interactive.  In
> your example the user might be waiting for the Mozilla to start
> and not care if the movie player skips.

The scheduler might not care, but you can be pretty sure that
the user does care, and will complain loudly if program startup
stops the multimedia playback.

Fairness problems beyond a power-of-2-magnitude and multimedia
hickups are the two main things you can expect users to complain
about.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

