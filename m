Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275398AbRJFRuI>; Sat, 6 Oct 2001 13:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275399AbRJFRt6>; Sat, 6 Oct 2001 13:49:58 -0400
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:29964 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S275398AbRJFRts>;
	Sat, 6 Oct 2001 13:49:48 -0400
Date: Sat, 6 Oct 2001 19:49:55 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Simon Kirby <sim@netnation.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11pre4 swapping out all over the place
In-Reply-To: <Pine.LNX.4.33.0110060903510.1260-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0110061948280.30116-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Oct 2001, Linus Torvalds wrote:

> On Sat, 6 Oct 2001, Tobias Ringstrom wrote:
> >
> > I can confirm that in 2.4.11-pre4, the used-once pages are causing
> > page-out activity, as opposed to 2.4.11-pre2 which did not.
>
> Yeah, try_to_free_pages() gives up much too early: Marcelo removed the
> loop from it. That also shows the problems with the out_of_memory() logic
> much more easily.
>
> Can you try just undoing the changes to try_to_free_pages() itself?

Sure, replacing try_to_free_pages() in 2.4.11-pre4 with the one in
2.4.11-pre3 solves the problem.

/Tobias

