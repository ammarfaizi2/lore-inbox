Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265053AbRFURP7>; Thu, 21 Jun 2001 13:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265054AbRFURPj>; Thu, 21 Jun 2001 13:15:39 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:36888 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265053AbRFURP3>; Thu, 21 Jun 2001 13:15:29 -0400
Date: Thu, 21 Jun 2001 19:15:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Stefan.Bader@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: correction: fs/buffer.c underlocking async pages
Message-ID: <20010621191522.B28327@athlon.random>
In-Reply-To: <20010621173833.L29084@athlon.random> <Pine.LNX.4.33.0106210955180.1260-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0106210955180.1260-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jun 21, 2001 at 09:56:04AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 09:56:04AM -0700, Linus Torvalds wrote:
 What's the problem with the existing code, and why do people want to add a
> (unnecessary) new bit?

there's no problem with the existing code, what I understood is that
they cannot overwrite the ->b_end_io callback in the lowlevel blkdev
layer or the page will be unlocked too early.

Andrea
