Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268291AbRGWQpU>; Mon, 23 Jul 2001 12:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268293AbRGWQpK>; Mon, 23 Jul 2001 12:45:10 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:18266 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268291AbRGWQo7>; Mon, 23 Jul 2001 12:44:59 -0400
Date: Mon, 23 Jul 2001 18:45:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Dike <jdike@karaya.com>, user-mode-linux-user@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: user-mode port 0.44-2.4.7
Message-ID: <20010723184528.R822@athlon.random>
In-Reply-To: <20010723175635.L822@athlon.random> <Pine.LNX.4.33.0107230931590.12978-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107230931590.12978-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Jul 23, 2001 at 09:33:28AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 23, 2001 at 09:33:28AM -0700, Linus Torvalds wrote:
> 
> On Mon, 23 Jul 2001, Andrea Arcangeli wrote:
> >
> > in my tree I did some further cleanup, here the ones that you can
> > interested about:
> 
> Andrea, please drop the "volatile" from xtime. It's bogus.

it's the other way around, it's needed and gcc trapped a kernel bug.

If the contents of memory not declared volatile changes under GCC (like
it can happen right now for xtime since it's declared non volatile), gcc
has the full rights to crash the kernel at runtime.

I know there are other bugs like this one in the kernel, but this is not
a good reason to fix the known ones IMHO.

Andrea
