Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267717AbTATA4U>; Sun, 19 Jan 2003 19:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267726AbTATA4U>; Sun, 19 Jan 2003 19:56:20 -0500
Received: from 5-116.ctame701-1.telepar.net.br ([200.193.163.116]:56805 "EHLO
	5-116.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267717AbTATA4T>; Sun, 19 Jan 2003 19:56:19 -0500
Date: Sun, 19 Jan 2003 23:05:00 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Disabling file system caching 
In-Reply-To: <3E2ADACA.5050404@linkvest.com>
Message-ID: <Pine.LNX.4.50L.0301192303130.18171-100000@imladris.surriel.com>
References: <3E2ADACA.5050404@linkvest.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2003, Jean-Eric Cuendet wrote:

> Is it possible to disable file caching for a given partition or mount?

No, if you do that mmap(), read(), write() etc. would be impossible.

> Or at least to limit it at a certain quantity of memory?

Not yet.  I'm thinking of implementing something like this
for the next version of -rmap (reclaim only from the cache
if the cache occupies more than a certain fraction of ram).

> I think of a BIG compilation (several GB of files) and would tell gcc to
> not cache the compiled files.

But what about the .h files ?  You will want to cache those.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
