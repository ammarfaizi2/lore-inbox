Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318065AbSIOOx5>; Sun, 15 Sep 2002 10:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318067AbSIOOx5>; Sun, 15 Sep 2002 10:53:57 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:32917 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S318065AbSIOOx4>; Sun, 15 Sep 2002 10:53:56 -0400
Date: Sun, 15 Sep 2002 11:58:27 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: Daniel Phillips <phillips@arcor.de>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.34-mm2
In-Reply-To: <3D841C8A.682E6A5C@digeo.com>
Message-ID: <Pine.LNX.4.44L.0209151156080.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Sep 2002, Andrew Morton wrote:
> Daniel Phillips wrote:

> > but that sure looks like the low hanging fruit.
>
> It's low alright.  AFAIK Linux has always had this problem of
> seizing up when there's a lot of dirty data around.

Somehow I doubt the "seizing up" problem is caused by too much
scanning.  In fact, I'm pretty convinced it is caused by having
too much IO submitted at once (and stalling in __get_request_wait).

The scanning is probably not relevant at all and it may be
beneficial to just ignore the scanning for now and do our best
to keep the pages in better LRU order.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

