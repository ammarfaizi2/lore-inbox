Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129188AbQKOAR6>; Tue, 14 Nov 2000 19:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131034AbQKOARu>; Tue, 14 Nov 2000 19:17:50 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:52998 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129188AbQKOARd>; Tue, 14 Nov 2000 19:17:33 -0500
Date: Tue, 14 Nov 2000 15:47:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dan Aloni <karrde@callisto.yi.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: test11-pre5
In-Reply-To: <Pine.LNX.4.21.0011150030030.26513-100000@callisto.yi.org>
Message-ID: <Pine.LNX.4.10.10011141546140.972-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Nov 2000, Dan Aloni wrote:
>
> summery: dev_3c501.name shouldn't be NULL, or we get oops

Note that these days "name" is not a pointer at all, but an array, and as
such cannot be NULL any more. Not initializing it will just cause it to be
empty (ie is the same as initializing it to "").

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
