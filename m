Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbSAGREP>; Mon, 7 Jan 2002 12:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280984AbSAGREG>; Mon, 7 Jan 2002 12:04:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30983 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280825AbSAGRDu>; Mon, 7 Jan 2002 12:03:50 -0500
Date: Mon, 7 Jan 2002 09:02:39 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: Jaroslav Kysela <perex@suse.cz>, <sound-hackers@zabbo.net>,
        <linux-sound@vger.rutgers.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: ALSA patch for 2.5.2pre9 kernel
In-Reply-To: <200201071432.g07EWI802933@ns.caldera.de>
Message-ID: <Pine.LNX.4.33.0201070858150.6450-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Jan 2002, Christoph Hellwig wrote:
>
> linux/sound is silly.  It's drivers so put it under linux/drivers/sound.

That was my initial reaction too, but Jaroslav clearly wants a
higher-level generic hierarchy. Which means that we're not talking about
_drivers_ any more, we're talking about something that is much more
closely related to a "networking" kind of thing.

So we could have a net-based setup, where there would be a totally
separate "linux/sound" and "linux/drivers/sound". Which doesn't seem to
make much sense either.

Or we could just have a really _deep_ hierarchy, and put everything under
"linux/drivers/sound/..", but I'd rather break cleanly with the old.

		Linus

