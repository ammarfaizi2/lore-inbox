Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263426AbRFEXwE>; Tue, 5 Jun 2001 19:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263427AbRFEXvo>; Tue, 5 Jun 2001 19:51:44 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:61195 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263426AbRFEXvk>; Tue, 5 Jun 2001 19:51:40 -0400
Date: Tue, 5 Jun 2001 16:51:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kswapd and MM overload fix
In-Reply-To: <20010606014839.A24257@athlon.random>
Message-ID: <Pine.LNX.4.31.0106051650340.10118-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Jun 2001, Andrea Arcangeli wrote:
>
> that would fix it too indeed, OTOH I think changing the empty zone
> handling in the kernel is beyond the scope of the bugfix (grep for
> zone->size in mm/*.c :). Certainly making empty zones transparent to the
> vm sounds much cleaner from a mm/*.c point of view but it may be faster
> to skip the block with a branch instead of always computing it.

Agreed. I'd like to do both. Having uninitialized random stuff around and
depending on jumping over code that might access it sounds like really bad
practice.

		Linus

