Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287841AbSBMRFt>; Wed, 13 Feb 2002 12:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287764AbSBMRFj>; Wed, 13 Feb 2002 12:05:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48396 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287862AbSBMRF2>; Wed, 13 Feb 2002 12:05:28 -0500
Date: Wed, 13 Feb 2002 10:50:34 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: <jgarzik@mandrakesoft.com>, <dalecki@evision-ventures.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
In-Reply-To: <20020213.084952.68037450.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0202131043230.13632-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Feb 2002, David S. Miller wrote:
>
> Actually, you're only half right in one regard.  Most people I've
> pointed to Documentation/DMA-mapping.txt have responded "Oh, never saw
> that before, that looks easy to do.  Thanks I'll fix it up properly
> for you."

Fair enough. Educating driver writers is always good, and the good ones
will try to do their best even when it doesn't matter for them. I just
wanted to make sure that we don't make driver writers have to chew off too
big a piece.

(One example of this: look at how the big changes in the ll_rw_block
infrastructure were done - the whole locking thing was basically set up to
avoid having to change legacy drivers in anything but trivial ways, while
still sanely getting rid of io_request_lock. Similarly, while the BIO
stuff was a big change on a mid level layer, there was considerable effort
to make it easy to port drivers that didn't try to be clever to it).

Some drivers are written by people who are really passionate about kernel
internals, and that's good.

But many of them are barely working, written by people who don't care
about the rest of the kernel (or even about the driver itself, they just
wanted to have a working machine and forget about it), and if we make
those kinds of drivers do extra work, it's just not going to work.

		Linus

