Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274257AbRIXXzV>; Mon, 24 Sep 2001 19:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274258AbRIXXzL>; Mon, 24 Sep 2001 19:55:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27154 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274257AbRIXXzB>; Mon, 24 Sep 2001 19:55:01 -0400
Date: Mon, 24 Sep 2001 16:54:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 VM: what avoids from having lots of unwriteable inactive
 pages
In-Reply-To: <Pine.LNX.4.21.0109241924470.1207-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0109241653460.21624-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Sep 2001, Marcelo Tosatti wrote:
>
> What avoids us from having a lot of unfreeable (eg mapped by ptes) pages
> on the inactive list ?

Nothing.

If we can't shrink them, we'll fall out and do vmscanning.

Which is exactly what we want to do - it automatically acts as a "uhhuh,
we've got to do something now" thing.

The tuning may be way off, of course. If we scan too many pages, we won't
fall out early enough..

		Linus

