Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280255AbRJaPBM>; Wed, 31 Oct 2001 10:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280256AbRJaPBB>; Wed, 31 Oct 2001 10:01:01 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:36877 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280255AbRJaPAm>;
	Wed, 31 Oct 2001 10:00:42 -0500
Date: Wed, 31 Oct 2001 13:00:59 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: new OOM heuristic failure  (was: Re: VM: qsbench)
In-Reply-To: <3.0.6.32.20011031131253.01fb8e40@pop.tiscalinet.it>
Message-ID: <Pine.LNX.4.33L.0110311259570.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Lorenzo Allegrucci wrote:

Linus, it seems Lorenzo's test program gets killed due
to the new out_of_memory() heuristic ...

> Linux-2.4.14-pre6:
> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
> Out of Memory: Killed process 224 (qsbench).
> 69.890u 3.430s 2:12.48 55.3%    0+0k 0+0io 16374pf+0w
> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
> Out of Memory: Killed process 226 (qsbench).
> 69.550u 2.990s 2:11.31 55.2%    0+0k 0+0io 15374pf+0w
> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
> Out of Memory: Killed process 228 (qsbench).
> 69.480u 3.100s 2:13.33 54.4%    0+0k 0+0io 15950pf+0w
> 0:01 kswapd
>
> This is interesting, -pre6 killed qsbench _just_ before qsbench exited.
> Unreliable results.

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

