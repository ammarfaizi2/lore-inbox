Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286317AbRLJRR5>; Mon, 10 Dec 2001 12:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286316AbRLJRRo>; Mon, 10 Dec 2001 12:17:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45321 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286325AbRLJRQz>; Mon, 10 Dec 2001 12:16:55 -0500
Date: Mon, 10 Dec 2001 09:10:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: GOTO Masanori <gotom@debian.org>
cc: <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <andrea@suse.de>
Subject: Re: [PATCH] direct IO breaks root filesystem
In-Reply-To: <w53d71n1c6g.wl@megaela.fe.dis.titech.ac.jp>
Message-ID: <Pine.LNX.4.33.0112100908440.14166-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Dec 2001, GOTO Masanori wrote:
> >
> > "generic_direct_IO()" should just get the device from "bh->b_dev (which is
> > filled in correctly by "get_block()".
>
> Oh, that's right, the patch becomes more simple (and works well).
> Is this patch OK?

This looks fine to me. At some point we _may_ end up with filesystems that
understand about multiple devices, so it's possible in theory that
"get_block()" might return different devices for different blocks, but
that does not happen currently, and I'm not really sure it ever will.

Marcelo, I do believe this should go into 2.4.x too..

		Linus

