Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284956AbSAGSas>; Mon, 7 Jan 2002 13:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284966AbSAGSai>; Mon, 7 Jan 2002 13:30:38 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64523 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284956AbSAGSaa>; Mon, 7 Jan 2002 13:30:30 -0500
Date: Mon, 7 Jan 2002 10:29:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Abramo Bagnara <abramo@alsa-project.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@ns.caldera.de>,
        Jaroslav Kysela <perex@suse.cz>, <sound-hackers@zabbo.net>,
        <linux-sound@vger.rutgers.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
In-Reply-To: <3C39E6A0.34A88990@alsa-project.org>
Message-ID: <Pine.LNX.4.33.0201071024450.6671-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Jan 2002, Abramo Bagnara wrote:
>
> IMO the latter makes much more sense (also for "net" case), but I doubt
> you're willing to change current schema.

Agreed. I do not really think that it makes sense to move "drivers/net" to
"net/drivers" even if it _would_ be the logical way to group all net
things together. Whatever potential incremental advantage (if any) just
isn't worth the disruption.

> If you want to keep top level cleaner and avoid proliferation of entries
> we might have:
>
> subsys/sound
...

No, I hate to create structure abstractions for their own sake, and a
"subsys" kind of abstraction doesn't really add any information.

I have no problems with making the linux "root" directory a bit larger,
it's certainly not problematic (what, 22 entries, and no new ones
generated dynamically - fits on one screen even on an old vt100).

That might change if we end up creating _more_ subdirectories, of course,
although even then I'd really want to group them according to some clear
goal or property of the grouping (ie not "subsys" kinds of things).

		Linus

