Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267616AbSIRQsJ>; Wed, 18 Sep 2002 12:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267605AbSIRQq7>; Wed, 18 Sep 2002 12:46:59 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:5902 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267603AbSIRQqL>; Wed, 18 Sep 2002 12:46:11 -0400
Date: Wed, 18 Sep 2002 13:50:50 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Andrew Morton <akpm@digeo.com>
Cc: Con Kolivas <conman@kolivas.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] contest results for 2.5.36
In-Reply-To: <3D88ACB6.6374E014@digeo.com>
Message-ID: <Pine.LNX.4.44L.0209181349200.1519-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2002, Andrew Morton wrote:

> > No Load:
> > Kernel                  Time            CPU
> > 2.4.19                  68.14           99%
> > 2.4.20-pre7             68.11           99%
> > 2.5.34                  69.88           99%
> > 2.4.19-ck7              68.40           98%
> > 2.4.19-ck7-rmap         68.73           99%
> > 2.4.19-cc               68.37           99%
> > 2.5.36                  69.58           99%
>
> page_add/remove_rmap.  Be interesting to test an Alan kernel too.

Yes, but why are page_add/remove_rmap slower in 2.5 than in
Con's -rmap kernel ? ;)

> > Process Load:
> > Kernel                  Time            CPU
> > 2.4.19                  81.10           80%
> > 2.4.20-pre7             81.92           80%
> > 2.5.34                  71.39           94%
> > 2.5.36                  71.80           94%
>
> Ingo ;)

Looks like an unfair sched_yield, the process load is supposed
to get 20% of the CPU (one process in process_load vs. make -j4).

For the other results I agree with you, furter VM improvements in
2.5 will probably fix those.

cheers,

Rik
-- 
Spamtrap of the month: september@surriel.com

http://www.surriel.com/		http://distro.conectiva.com/

