Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261851AbREZSby>; Sat, 26 May 2001 14:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbREZSbp>; Sat, 26 May 2001 14:31:45 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:21282 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261851AbREZSbZ>; Sat, 26 May 2001 14:31:25 -0400
Date: Sat, 26 May 2001 20:31:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ben LaHaise <bcrl@redhat.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
Message-ID: <20010526203104.E1834@athlon.random>
In-Reply-To: <20010526171459.Y9634@athlon.random> <Pine.LNX.4.33.0105261409370.9587-100000@toomuch.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0105261409370.9587-100000@toomuch.toronto.redhat.com>; from bcrl@redhat.com on Sat, May 26, 2001 at 02:11:15PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 02:11:15PM -0400, Ben LaHaise wrote:
> No.  It does not fix the deadlock.  Neither does the patch you posted.

can you give a try if you can deadlock 2.4.5aa1 just in case, and post a
SYSRQ+T + system.map if it still deadlocks?

> But, if you're going to add a reserve pool for buffer heads and bounce
> pages, please do it with generic, not yet another special case hack.

The reserved pool for buffer heads is there since the first time I used
linux I think. I won't certainly object to convert  all reserved pool to
an unified interface, as I'd like if all hashtables would be also sized
with an unified interface, but that's just a stylistic issue, at least
for 2.4 that's a very secondary object compared to people who can get
dealdocks during production.

Andrea
