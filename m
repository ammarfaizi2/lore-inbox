Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284794AbSAGSUs>; Mon, 7 Jan 2002 13:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284795AbSAGSUj>; Mon, 7 Jan 2002 13:20:39 -0500
Received: from smtp3.libero.it ([193.70.192.53]:58590 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S284794AbSAGSUZ>;
	Mon, 7 Jan 2002 13:20:25 -0500
Message-ID: <3C39E6A0.34A88990@alsa-project.org>
Date: Mon, 07 Jan 2002 19:19:12 +0100
From: Abramo Bagnara <abramo@alsa-project.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i586)
X-Accept-Language: en, it
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@ns.caldera.de>,
        Jaroslav Kysela <perex@suse.cz>, sound-hackers@zabbo.net,
        linux-sound@vger.rutgers.edu, linux-kernel@vger.kernel.org
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
In-Reply-To: <Pine.LNX.4.33.0201070959430.6559-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 7 Jan 2002, Alan Cox wrote:
> > > Or we could just have a really _deep_ hierarchy, and put everything under
> > > "linux/drivers/sound/..", but I'd rather break cleanly with the old.
> >
> > Christoph has an interesting point. Networking is
> >
> >       net/[protocol]/
> >       drivers/net/[driver]
> >
> > so by that logic we'd have
> >
> >       sound/soundcore.c
> >       sound/alsa/alsalibcode
> >       sound/oss/osscore
> >
> >       sound/drivers/cardfoo.c
> >
> > which would also be much cleaner since the supporting crap would be seperate
> > from the card drivers
> 
> I would certainly not oppose that. Look sane to me, although the question
> then ends up being about "drivers/sound" or "sound/drivers" (the latter
> has the advantage that it keeps sound together, the former is more
> analogous to the "net" situation).

IMO the latter makes much more sense (also for "net" case), but I doubt
you're willing to change current schema.

If you want to keep top level cleaner and avoid proliferation of entries
we might have:

subsys/sound
subsys/sound/drivers
subsys/net
subsys/net/drivers

and so on.

Clean and without ambiguities about stuff location. Unfortunately it's a
*big* change.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
