Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267162AbSLQVmX>; Tue, 17 Dec 2002 16:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267161AbSLQVmX>; Tue, 17 Dec 2002 16:42:23 -0500
Received: from 4-090.ctame701-1.telepar.net.br ([200.193.162.90]:64945 "EHLO
	4-090.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267162AbSLQVmX>; Tue, 17 Dec 2002 16:42:23 -0500
Date: Tue, 17 Dec 2002 19:50:04 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Georg Nikodym <georgn@somanetworks.com>
cc: linux-mm@kvack.org, "" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.20-rmap15b
In-Reply-To: <200212161610.gBGGAuB7028719@localhost.localdomain>
Message-ID: <Pine.LNX.4.50L.0212171948400.26879-100000@imladris.surriel.com>
References: <Pine.LNX.4.50L.0212122349520.17748-100000@imladris.surriel.com>
 <200212161610.gBGGAuB7028719@localhost.localdomain>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2002, Georg Nikodym wrote:

> Incidentally, a colleague claimed to have seem this behaviour on a
> non-rmap 2.4.20.

> 1. Known behaviour?
> 2. Is there any data that I should be collecting that people are
>    interested in?
> 3. Or should I just go back to 2.4.19-rmap14b (which did not trouble me
>    in this way)?

The suspect is the disk elevator, which isn't scheduling requests
in a way to cause lower read latency, but is optimised more for
throughput.  This results in some pauses.

I'll need to look into it.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
