Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130380AbQK3RP3>; Thu, 30 Nov 2000 12:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129977AbQK3RPU>; Thu, 30 Nov 2000 12:15:20 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:27416 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S130592AbQK3RAh>; Thu, 30 Nov 2000 12:00:37 -0500
Date: Thu, 30 Nov 2000 17:29:47 +0100
From: Andrea Arcangeli <andrea@e-mind.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Bob Tanner <tanner@real-time.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: do_try_free_pages failed for python
Message-ID: <20001130172947.E8189@athlon.random>
In-Reply-To: <20001129183919.B7640@real-time.com> <Pine.LNX.4.21.0011301405450.26098-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0011301405450.26098-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Thu, Nov 30, 2000 at 02:06:55PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 02:06:55PM -0200, Rik van Riel wrote:
> still had lots of swap free, this may mean that VM
> in 2.2 still has some bugs left ...

I guess it's the free_before_allocate band-aid that hurts in 2.2. That subtle
race condition is fixed efficiently in VM-global with per-process freelist
flushed atomically to the global freelist before allocation, so I'd suggest him
to try to reproduce on VM-global-7.

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre18/VM-global-2.2.18pre18-7.bz2

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
