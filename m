Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265103AbRFUSuA>; Thu, 21 Jun 2001 14:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265104AbRFUStu>; Thu, 21 Jun 2001 14:49:50 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:30474 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265103AbRFUStp>; Thu, 21 Jun 2001 14:49:45 -0400
Date: Thu, 21 Jun 2001 11:49:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: <Stefan.Bader@de.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: correction: fs/buffer.c underlocking async pages
In-Reply-To: <20010621191522.B28327@athlon.random>
Message-ID: <Pine.LNX.4.33.0106211148140.1506-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Jun 2001, Andrea Arcangeli wrote:

> On Thu, Jun 21, 2001 at 09:56:04AM -0700, Linus Torvalds wrote:
>  What's the problem with the existing code, and why do people want to add a
> > (unnecessary) new bit?
>
> there's no problem with the existing code, what I understood is that
> they cannot overwrite the ->b_end_io callback in the lowlevel blkdev
> layer or the page will be unlocked too early.

Oh, fair enough.

I don't have any objections to the patch in that case, although it does
end up being a 2.5.x issue as far as I'm concerned (and don't worry, 2.5.x
looks like it will open in a week or two, so we're not talking about long
timeframes).

Obviously 2.5.x code may be back-ported to 2.4.x later. That will be up to
Alan.

		Linus

