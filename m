Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263270AbSKYNH5>; Mon, 25 Nov 2002 08:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbSKYNH5>; Mon, 25 Nov 2002 08:07:57 -0500
Received: from 5-106.ctame701-1.telepar.net.br ([200.193.163.106]:23200 "EHLO
	5-106.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S263270AbSKYNH4>; Mon, 25 Nov 2002 08:07:56 -0500
Date: Mon, 25 Nov 2002 11:13:50 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Robert Love <rml@tech9.net>
cc: akpm@digeo.com, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5: kill PF_MEMDIE
In-Reply-To: <1038205919.17472.48.camel@phantasy>
Message-ID: <Pine.LNX.4.44L.0211251113050.4103-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Nov 2002, Robert Love wrote:

> PF_MEMDIE seems to serve no needed purpose in 2.5.  In fact, it seems it
> has no point in 2.4, either.

Actually it does. If the task that's being OOM killed is in
try_to_free_pages() it'll clear PF_MEMALLOC before going back
into __alloc_pages() and it might not die.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

