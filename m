Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319093AbSH2AW2>; Wed, 28 Aug 2002 20:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319094AbSH2AW1>; Wed, 28 Aug 2002 20:22:27 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:58066 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319093AbSH2AW1>; Wed, 28 Aug 2002 20:22:27 -0400
Date: Wed, 28 Aug 2002 21:26:24 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: William Lee Irwin III <wli@holomorphy.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] adjustments to dirty memory thresholds
In-Reply-To: <3D6D477C.F5116BA7@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0208282124550.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2002, Andrew Morton wrote:

> But sigh.  Pointlessly scanning zillions of dirty pages and doing
> nothing with them is dumb.  So much better to go for a FIFO snooze on a
> per-zone waitqueue, be woken when some memory has been cleansed.

But not per-zone, since many (most?) allocations can be satisfied
from multiple zones.  Guess what 2.4-rmap has had for ages ?

Interested in a port for 2.5 on top of 2.5.32-mm2 ? ;)

[I'll mercilessly increase your patch queue since it doesn't show
any sign of ever shrinking anyway]

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

