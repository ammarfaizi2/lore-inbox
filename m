Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287386AbRL3MGY>; Sun, 30 Dec 2001 07:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287387AbRL3MGN>; Sun, 30 Dec 2001 07:06:13 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:28178 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287386AbRL3MGF>;
	Sun, 30 Dec 2001 07:06:05 -0500
Date: Sun, 30 Dec 2001 10:05:44 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: safemode <safemode@speakeasy.net>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] 2.4.17 rmap based VM #9
In-Reply-To: <1009699023.343.0.camel@psuedomode>
Message-ID: <Pine.LNX.4.33L.0112301004560.24031-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Dec 2001, safemode wrote:

> Seems that not all of the live-deadlocks were fixed.  The one i saw in
> the last version is still present.   It occurs when you're heavily
> swapping out and the nall of a sudden require something to heavily swap

I've reproduced it with 'mem=12m'.  It seems the system spends all
of its time in try_to_free_pages() and friends, now I need to find
out why ;)

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

