Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263082AbSJGPYW>; Mon, 7 Oct 2002 11:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263086AbSJGPYV>; Mon, 7 Oct 2002 11:24:21 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:6289 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S263082AbSJGPYU>; Mon, 7 Oct 2002 11:24:20 -0400
Date: Mon, 7 Oct 2002 12:29:40 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: best version for server?
In-Reply-To: <20021007080132.A13486@work.bitmover.com>
Message-ID: <Pine.LNX.4.44L.0210071228060.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, Larry McVoy wrote:

> We're not sure if it is something we've done or just increased usage, but
> bkbits.net is getting hammered lately.  We see load averages in ~15-20
> range pretty regularly.  It's got some nasty characteristics from the
> point of view of server/VM system, tons of data and not really any good
> working sets.

There are a few things that could help here:

1) Andrew Morton's io scheduler patch (read-latency2), which is
   in the -rmap kernel

2) reducing the number of outstanding IO commands in the 3ware
   controller/driver, so akpm's io scheduler gets a chance to do
   its work

3) better readahead, if possible...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

