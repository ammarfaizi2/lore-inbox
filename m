Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285829AbRLaAgd>; Sun, 30 Dec 2001 19:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285842AbRLaAgX>; Sun, 30 Dec 2001 19:36:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41232 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285829AbRLaAgO>; Sun, 30 Dec 2001 19:36:14 -0500
Date: Sun, 30 Dec 2001 16:35:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@zip.com.au>, Alexander Viro <viro@math.psu.edu>,
        <torrey.hoffman@myrio.com>, <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrdkern
 el panic woes
In-Reply-To: <20011231012825.P1356@athlon.random>
Message-ID: <Pine.LNX.4.33.0112301634510.1011-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Dec 2001, Andrea Arcangeli wrote:
>
> actually bh_new is needed also to serialize with the buffercache, a new
> bh mapped in pagecache must be dropped from the buffercache before we
> can start using it (unmap_underlying_metadata).

You're right, although it's something of an optimization (ie we could as
well just depend on the "mapped" bit and watch it change).

		Linus

