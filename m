Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287872AbSAHBe7>; Mon, 7 Jan 2002 20:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287871AbSAHBew>; Mon, 7 Jan 2002 20:34:52 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:9738 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S287447AbSAHBeg>; Mon, 7 Jan 2002 20:34:36 -0500
Subject: Re: ALSA patch for 2.5.2pre9 kernel
From: Miles Lane <miles@megapathdsl.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@ns.caldera.de>,
        Jaroslav Kysela <perex@suse.cz>, sound-hackers@zabbo.net,
        linux-sound@vger.rutgers.edu, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201070959430.6559-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201070959430.6559-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 07 Jan 2002 17:34:34 -0800
Message-Id: <1010453675.27296.16.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-07 at 10:00, Linus Torvalds wrote:
> 
> On Mon, 7 Jan 2002, Alan Cox wrote:
> > > Or we could just have a really _deep_ hierarchy, and put everything under
> > > "linux/drivers/sound/..", but I'd rather break cleanly with the old.
> >
> > Christoph has an interesting point. Networking is
> >
> > 	net/[protocol]/
> > 	drivers/net/[driver]
> >
> > so by that logic we'd have
> >
> > 	sound/soundcore.c
> > 	sound/alsa/alsalibcode
> > 	sound/oss/osscore
> >
> > 	sound/drivers/cardfoo.c
> >
> > which would also be much cleaner since the supporting crap would be seperate
> > from the card drivers
> 
> I would certainly not oppose that. Look sane to me, although the question
> then ends up being about "drivers/sound" or "sound/drivers" (the latter
> has the advantage that it keeps sound together, the former is more
> analogous to the "net" situation).

I like the layout proposed by Alan.  All the other device-specific
drivers I use are under linux/drivers.  Doing something else with
the sound drivers  1) breaks with the OSS layout, which we are
used to, and  2) would be an anomaly within the tree.  Confusion
would definitely follow for newbie kernel builders and people 
transitioning to 2.6, when it is released.

One additional change that might help make the nature of the 
linux/net and linux/sound directories more obvious could be 
to move them both into linux/system/.  That way the hierarchy 
indicates the purpose and similar nature of code in these 
two directories.

	Miles

