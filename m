Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265038AbRFUQ5J>; Thu, 21 Jun 2001 12:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265034AbRFUQ5C>; Thu, 21 Jun 2001 12:57:02 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:38148 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265033AbRFUQ4w>; Thu, 21 Jun 2001 12:56:52 -0400
Date: Thu, 21 Jun 2001 09:56:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: <Stefan.Bader@de.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: correction: fs/buffer.c underlocking async pages
In-Reply-To: <20010621173833.L29084@athlon.random>
Message-ID: <Pine.LNX.4.33.0106210955180.1260-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Jun 2001, Andrea Arcangeli wrote:
>
> I think the patch is ok. We must have a way to track down which bh are
> actually getting read,

We _do_ have a way. The way is called "bh->b_end_io == end_io_async".

What's the problem with the existing code, and why do people want to add a
(unnecessary) new bit?

		Linus

