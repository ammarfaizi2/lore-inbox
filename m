Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314841AbSEPV57>; Thu, 16 May 2002 17:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314842AbSEPV56>; Thu, 16 May 2002 17:57:58 -0400
Received: from [195.223.140.120] ([195.223.140.120]:34672 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314841AbSEPV56>; Thu, 16 May 2002 17:57:58 -0400
Date: Thu, 16 May 2002 23:57:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Paul Faure <paul@engsoc.org>, linux-kernel@vger.kernel.org
Subject: Re: Process priority in 2.4.18 (RedHat 7.3)
Message-ID: <20020516215744.GI1025@dualathlon.random>
In-Reply-To: <3CE414BF.15A0C74B@zip.com.au> <Pine.LNX.4.33.0205161650170.18851-100000@lager.engsoc.carleton.ca> <3CE41F42.ED20D0C6@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2002 at 02:06:10PM -0700, Andrew Morton wrote:
> of transmit attempts and is relying on ksoftirqd to transmit.

ksoftirqd or not the softirq are guaranteed to keep running even if
there's a task in loop with SCHED_FIFO, ksoftirqd only enhance/polish
the case of a recursive softirq, or a very big flood of softirq events,
it is not required to run softirqs.

Andrea
