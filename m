Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278932AbRJVVFU>; Mon, 22 Oct 2001 17:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278931AbRJVVFL>; Mon, 22 Oct 2001 17:05:11 -0400
Received: from hatrack.unc.edu.ar ([170.210.248.6]:25830 "EHLO
	hatrack.unc.edu.ar") by vger.kernel.org with ESMTP
	id <S278932AbRJVVE7>; Mon, 22 Oct 2001 17:04:59 -0400
Date: Mon, 22 Oct 2001 15:00:43 -0300 (GMT+3)
From: Marcos Dione <mdione@hal.famaf.unc.edu.ar>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kjournald and disk sleeping
In-Reply-To: <3BD4655E.82ED21CC@zip.com.au>
Message-ID: <Pine.LNX.4.33.0110221424500.25281-100000@hp11.labcomp.famaf.unc.edu.ar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001, Andrew Morton wrote:

> Yes, this is a bit of a problem - it's probably atime updates,
> things which write to inodes, etc.  A commit will be forced within
> five seconds of this happening.

	Reading journal.c I guessed that kjournald flushes thing *even if
it doesn't have things to flush*. I guess that from commit_timeout and
the comments on the thread process, but I can be wrong.

	YFI, I issue a /bin/sync before I put the disk to sleep.

-- 
"y, bueno, yo soy muy ilogico. lo que pasa es que ustedes me toman
demasiado en serio"
                                          --JLB


