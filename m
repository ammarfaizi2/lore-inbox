Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAJG6H>; Wed, 10 Jan 2001 01:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129584AbRAJG5r>; Wed, 10 Jan 2001 01:57:47 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:2572 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129406AbRAJG5i>; Wed, 10 Jan 2001 01:57:38 -0500
Date: Tue, 9 Jan 2001 22:57:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Zlatko Calusic <zlatko@iskon.hr>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.30.0101100144280.7564-100000@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.10.10101092255510.3414-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jan 2001, David Woodhouse wrote:
> 
> How does this affect embedded systems with no swap space at all?

The no-swap behaviour shoul dactually be pretty much identical, simply
because both 2.2 and 2.4 will do the same thing: just skip dirty pages in
the page tables because they cannot do anything about them.

That said, the _other_ VM differences in 2.4.x may obviously make a
difference, just not the sticky swap cache one..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
