Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316256AbSETTZC>; Mon, 20 May 2002 15:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316257AbSETTZB>; Mon, 20 May 2002 15:25:01 -0400
Received: from E1-009.ctame700-1.telepar.net.br ([200.181.141.9]:56615 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S316256AbSETTZA>; Mon, 20 May 2002 15:25:00 -0400
Date: Mon, 20 May 2002 16:24:37 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@zip.com.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Bug with shared memory.
In-Reply-To: <20020520141523.GB21806@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0205201618110.24352-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2002, Andrea Arcangeli wrote:

> With memclass_related_bhs() we automatically maximixed the amount of ram
> available as inodes/indirects and everything else ZONE_NORMAL, after

OK, a question and a remark:

1) does memclass_related_bhs() work if the bufferheads are
   on another node ?  (NUMA-Q)

2) memclass_related_bhs() will definately not work if the
   data structure is pinned indirectly, say struct address_space
   which is pinned by mere the existance of the page cache page
   and cannot easily be freed

> > or three, so he may not see your words.
>
> Ok. We CC'ed Rik so I assume it won't get lost in the mail flood.

I'm on holidays, don't expect patches soon :)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

