Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275289AbRJFQKY>; Sat, 6 Oct 2001 12:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275278AbRJFQKE>; Sat, 6 Oct 2001 12:10:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22034 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275265AbRJFQJ4>; Sat, 6 Oct 2001 12:09:56 -0400
Date: Sat, 6 Oct 2001 09:09:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
cc: Simon Kirby <sim@netnation.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11pre4 swapping out all over the place
In-Reply-To: <Pine.LNX.4.33.0110061048140.29350-100000@boris.prodako.se>
Message-ID: <Pine.LNX.4.33.0110060903510.1260-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 6 Oct 2001, Tobias Ringstrom wrote:
>
> I can confirm that in 2.4.11-pre4, the used-once pages are causing
> page-out activity, as opposed to 2.4.11-pre2 which did not.

Yeah, try_to_free_pages() gives up much too early: Marcelo removed the
loop from it. That also shows the problems with the out_of_memory() logic
much more easily.

Can you try just undoing the changes to try_to_free_pages() itself?

		Linus

