Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284542AbRLESVg>; Wed, 5 Dec 2001 13:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284543AbRLESV0>; Wed, 5 Dec 2001 13:21:26 -0500
Received: from mustard.heime.net ([194.234.65.222]:56725 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S284542AbRLESVQ>; Wed, 5 Dec 2001 13:21:16 -0500
Date: Wed, 5 Dec 2001 19:20:55 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: /proc/sys/vm/(max|min)-readahead effect????
In-Reply-To: <Pine.LNX.4.21.0112051454530.20519-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.30.0112051917430.3021-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've got a lot of memory (some 380 megs), but what is VM pressure?
>
> VM pressure means that there is not enough free memory on the system...
> Allocators have to reclaim memory.

There's more than enough memory on the system, as far as I can see

[root@linuxserver ext2]# free
             total       used       free     shared    buffers     cached
Mem:        381500     378136       3364          0       3552     333348
-/+ buffers/cache:      41236     340264
Swap:       522104      11440     510664

> Basically you cannot simply expect an increase in readahead size to
> increase performance:
>
> 1) The files you created may not be sequential

Beleive me - they are! Created with 'dd' secuentially

> 2) The lack of memory on the system may be interfering in weird ways, and
> maybe _INCREASING_ the readahead may decrease performance.

Anyway - I beleive I should have seen some change by trying virtually any
value from 31 to 4095.

If the readahead is what I beleive it is, It'll read further out in the
file when a request comes. It looks like either this never happens, or the
next request doesn't 'know' how much is cached.

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

