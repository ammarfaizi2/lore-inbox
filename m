Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135981AbREGXxV>; Mon, 7 May 2001 19:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136008AbREGXxK>; Mon, 7 May 2001 19:53:10 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:56072 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135981AbREGXwx>; Mon, 7 May 2001 19:52:53 -0400
Date: Mon, 7 May 2001 16:52:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105071848210.7515-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0105071645070.7915-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 May 2001, Marcelo Tosatti wrote:
> 
> So the "dead_swap_page" logic is _not_ buggy and you are full of shit when
> telling Alan to revert the change. (sorry, I could not avoid this one)

Well, the problem is that the patch _is_ buggy. 

swap_writepage() does it right. And dead_swap_page does it wrong. It
doesn't look at the swap counts, for one thing.

The patch should be reverted. The fact that other parts of the system do
it _right_ is not an argument for mm/vmscan.c to do it wrong.

What do you expect me to do? The patch is buggy. It should be reverted.
What's your problem?

		Linus

