Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265114AbSLBXDY>; Mon, 2 Dec 2002 18:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265125AbSLBXDY>; Mon, 2 Dec 2002 18:03:24 -0500
Received: from 5-106.ctame701-1.telepar.net.br ([200.193.163.106]:14758 "EHLO
	5-106.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S265114AbSLBXDX>; Mon, 2 Dec 2002 18:03:23 -0500
Date: Mon, 2 Dec 2002 21:10:03 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Willy Tarreau <willy@w.ods.org>
cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@digeo.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       <linux-kernel@vger.kernel.org>, Con Kolivas <conman@kolivas.net>
Subject: Re: [PATCH] 2.4.20-rmap15a
In-Reply-To: <20021202204509.GA21070@alpha.home.local>
Message-ID: <Pine.LNX.4.44L.0212022107421.15981-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2002, Willy Tarreau wrote:

>   - not one, but two elevators, one for read requests, one for write requests.
>   - we would process one of the request queues (either reads or writes), and
>     after a user-settable amount of requests processed, we would switch to the

OK, lets for the sake of the argument imagine such an
elevator, with Read and Write queues for the following
block numbers:

R:  1 3 4 5 6 20 21 22 100 110 111

W:  2 15 16 17 18 50 52 53

Now imagine what switching randomly between these queues
would do for disk seeks. Especially considering that some
of the writes can be "sandwiched" in-between the reads...

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

