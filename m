Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267751AbRGRCJ3>; Tue, 17 Jul 2001 22:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267743AbRGRCJT>; Tue, 17 Jul 2001 22:09:19 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:4364 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267751AbRGRCJE>; Tue, 17 Jul 2001 22:09:04 -0400
Date: Tue, 17 Jul 2001 19:08:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: <dpicard@rcn.com>, <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH for Corrupted IO on all block devices
In-Reply-To: <15188.61164.315022.913819@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33.0107171906580.1181-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Jul 2001, David S. Miller wrote:
>
> Linus Torvalds writes:
>  > What filesystem do you see the bug with?
>
> His report did specifically mention "databases".  But my initial
> impression was the same as yours, that this is a bug in the user.

More detailed report indicates that it is actually on ext2. Which would be
really really bad. It doesn't make the patch correct, but the patch might
be a starting point for some debugging session (ie instead of refusing to
merge them, print out the state of the overlapping buffers to see if there
is some pattern to it..)

		Linus

