Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276982AbRKFBir>; Mon, 5 Nov 2001 20:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277000AbRKFBil>; Mon, 5 Nov 2001 20:38:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45061 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276982AbRKFBia>; Mon, 5 Nov 2001 20:38:30 -0500
Date: Mon, 5 Nov 2001 17:35:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Craig Kulesa <ckulesa@as.arizona.edu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Unresolved symbols in 2.4.14
In-Reply-To: <Pine.LNX.4.33.0111051808590.936-100000@loke.as.arizona.edu>
Message-ID: <Pine.LNX.4.33.0111051734320.1663-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Nov 2001, Craig Kulesa wrote:
>
> Looks like deactivate_page() is still lurking in loop.c.  The following
> patch removes those lost references, seems to work fine.  Look okay?

yes, indeed, just remove the two occurrences from the loop driver, it has
no place trying to know about VM internals anyway.

		Linus

