Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263531AbSIQDEe>; Mon, 16 Sep 2002 23:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263546AbSIQDEd>; Mon, 16 Sep 2002 23:04:33 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:29571 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S263531AbSIQDEc>; Mon, 16 Sep 2002 23:04:32 -0400
Date: Tue, 17 Sep 2002 00:08:48 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Anton Blanchard <anton@samba.org>
cc: Lev Makhlis <mlev@despammed.com>, <linux-kernel@vger.kernel.org>,
       <akpm@zip.com.au>
Subject: Re: [RFC] [PATCH] [2.5.35] Run Queue Statistics
In-Reply-To: <20020917025907.GB15189@krispykreme>
Message-ID: <Pine.LNX.4.44L.0209170007110.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2002, Anton Blanchard wrote:

> On a semi related note, vmstat wants to know the number of running,
> blocked and swapped processes. strace vmstat one day and you will see it
> currently opens /proc/*/stat (ie one open for each process) just to get
> these stats.  Yet another place where the monitoring utilities disturb
> the system way too much.
>
> Can we get some things in /proc/stat to give us these numbers? Does
> "swapped" make any sense on Linux?

Runnable can be done currently, blocked on IO is trivial once
Andrew has pushed the iowait stats to Linus.

Swapped doesn't make any sense at the moment, but it should.
A system without load control is just too vulnerable to sudden
load spikes. If Andrew has interest I'll pick up the work I
did in that area ...

I'll also update vmstat to just use /proc/stat instead of
looking at all /proc/*/stat files.

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

