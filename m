Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263381AbREXFVk>; Thu, 24 May 2001 01:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263379AbREXFVa>; Thu, 24 May 2001 01:21:30 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:22290 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263384AbREXFVS>; Thu, 24 May 2001 01:21:18 -0400
Date: Thu, 24 May 2001 02:21:13 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: null <null@null.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: bdflush/mm performance drop-out defect (more info)
In-Reply-To: <Pine.LNX.4.21.0105221114120.32238-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0105240216060.311-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2001, null wrote:

> Here is some additional info about the 2.4 performance defect.
>
> Only one person offered a suggestion about the use of HIGHMEM.
> I tried with and without HIGHMEM enabled with the same results.
> However, it does appear to take a bit longer to reach
> performance drop-out condition when HIGHMEM is disabled.

I'm seeing this same thing whenever kswapd and bdflush
are gobbling up CPU time at full speed without doing
anything useful.

At the moment I've only managed a really slight reduction
in the phenomenon by just not waking up bdflush when it
can't do any work.

The real solution probably will consist of some "everybody
wait on IO for a moment" thing which will take some time
to develop.  Stay on the lookout for patches on:

	http://www.surriel.com/patches/

cheers,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

