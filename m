Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261746AbREPBBa>; Tue, 15 May 2001 21:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261745AbREPBBU>; Tue, 15 May 2001 21:01:20 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:36357 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261744AbREPBBN>; Tue, 15 May 2001 21:01:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: LANANA: To Pending Device Number Registrants
Date: Wed, 16 May 2001 03:00:54 +0200
X-Mailer: KMail [version 1.2]
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
In-Reply-To: <Pine.LNX.4.21.0105150819420.1802-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0105150819420.1802-100000@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <01051603005402.00406@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 May 2001 17:34, Linus Torvalds wrote:
> On Tue, 15 May 2001, Neil Brown wrote:
> > Ofcourse setting the "queue" function that __blk_get_queue call to
> > do a lookup of the minor and choose an appropriate queue for the
> > "real" device wont work as you need to munge bh->b_rdev too.
>
> What I would do is:
>  - remove b_rdev completely.

:-) And b_rsector too?

> [...]

>  - replace is with b_index
>
> Then, the "get_queue" functions basically end up doing the mapping of
>
> 	b_dev -> <queue,b_index>

To clarify, will be b_index be in the buffer_head or not?

--
Daniel
