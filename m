Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281780AbSAGRHf>; Mon, 7 Jan 2002 12:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281809AbSAGRH2>; Mon, 7 Jan 2002 12:07:28 -0500
Received: from ns.caldera.de ([212.34.180.1]:41676 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S281780AbSAGRHM>;
	Mon, 7 Jan 2002 12:07:12 -0500
Date: Mon, 7 Jan 2002 18:06:56 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jaroslav Kysela <perex@suse.cz>, sound-hackers@zabbo.net,
        linux-sound@vger.rutgers.edu, linux-kernel@vger.kernel.org
Subject: Re: ALSA patch for 2.5.2pre9 kernel
Message-ID: <20020107180656.A16283@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Jaroslav Kysela <perex@suse.cz>, sound-hackers@zabbo.net,
	linux-sound@vger.rutgers.edu, linux-kernel@vger.kernel.org
In-Reply-To: <200201071432.g07EWI802933@ns.caldera.de> <Pine.LNX.4.33.0201070858150.6450-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201070858150.6450-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Jan 07, 2002 at 09:02:39AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 09:02:39AM -0800, Linus Torvalds wrote:
> > linux/sound is silly.  It's drivers so put it under linux/drivers/sound.
> 
> That was my initial reaction too, but Jaroslav clearly wants a
> higher-level generic hierarchy. Which means that we're not talking about
> _drivers_ any more, we're talking about something that is much more
> closely related to a "networking" kind of thing.

If you look at the code it clearly is driver code.

> So we could have a net-based setup, where there would be a totally
> separate "linux/sound" and "linux/drivers/sound". Which doesn't seem to
> make much sense either.

If really wants that I'd go for this.

> Or we could just have a really _deep_ hierarchy, and put everything under
> "linux/drivers/sound/..",

Yes.  From a maintaince view that is no different from the same
hierarchy under linux/sound, but introducing drivers (_lots_ of drivers)
outside linux/drivers is very stupid.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
