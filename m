Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318486AbSHENyq>; Mon, 5 Aug 2002 09:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318487AbSHENyq>; Mon, 5 Aug 2002 09:54:46 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:13573 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318486AbSHENyp>; Mon, 5 Aug 2002 09:54:45 -0400
Date: Mon, 5 Aug 2002 10:57:53 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Daniel Phillips <phillips@arcor.de>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Rmap speedup
In-Reply-To: <E17biDi-0000w7-00@starship>
Message-ID: <Pine.LNX.4.44L.0208051056440.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2002, Daniel Phillips wrote:

> > Despite the fact that the number of pte_chain references in
> > page_add/remove_rmap now just averages two in that test.
>
> It's weird that it only averages two.  It's a four way and your running
> 10 in parallel, plus a process to watch for completion, right?

I explained this one in the comment above the declaration of
struct pte_chain ;)

 * A singly linked list should be fine for most, if not all, workloads.
 * On fork-after-exec the mapping we'll be removing will still be near
 * the start of the list, on mixed application systems the short-lived
 * processes will have their mappings near the start of the list and
 * in systems with long-lived applications the relative overhead of
 * exit() will be lower since the applications are long-lived.

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

