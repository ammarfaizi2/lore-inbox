Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316953AbSHJOMk>; Sat, 10 Aug 2002 10:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSHJOMk>; Sat, 10 Aug 2002 10:12:40 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:54285 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316953AbSHJOMk>; Sat, 10 Aug 2002 10:12:40 -0400
Date: Sat, 10 Aug 2002 11:16:11 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
In-Reply-To: <Pine.LNX.4.44.0208100005070.1474-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0208101114590.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Aug 2002, Linus Torvalds wrote:

> and having it magically populate the VM directly with the whole file
> mapping, with _one_ failed page fault. And the above is actually a fairly
> common thing. See how many people have tried to optimize using mmap vs
> read, and what they _all_ really wanted was this "populate the pages in
> one go" thing.

If this is worth it, chances are prefaulting at mmap() time
could also be worth trying ... hmmm ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

