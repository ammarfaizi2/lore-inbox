Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265589AbSL1UbQ>; Sat, 28 Dec 2002 15:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbSL1UbQ>; Sat, 28 Dec 2002 15:31:16 -0500
Received: from [81.2.122.30] ([81.2.122.30]:46085 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265589AbSL1UbP>;
	Sat, 28 Dec 2002 15:31:15 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212282039.gBSKdGWF001663@darkstar.example.net>
Subject: Re: Want a random entropy source?
To: folkert@vanheusden.com (Folkert van Heusden)
Date: Sat, 28 Dec 2002 20:39:16 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <003c01c2aeaf$ac673530$3640a8c0@boemboem> from "Folkert van Heusden" at Dec 28, 2002 09:28:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I was astonished to see that the resulting signal is a white-noise
> > pattern with a slight emphasis at the high end (when sampled at 44
> > kilosamples per second). In short, it looks like diode noise with a
> > 4 kilohertz square wave thrown in.
> > "That suggests to me that this would make a fair source of random samples,
> > especially after you slot out the interfering signal.
> JB> How can you guarantee that you are sampling noise, though, what if a
> JB> sound card was picking up 50 Hz mains hum, for example,  that would
> JB> de-randomise the data quite a bit.
> 
> Well, the 50hz from the mains isn't a perfect 50hz; it has random (yes)
> fluctuations.

Yes, that's true.

More generally, though, is there any point in this going in to the
mainline kernel, if:

* Most users don't need faster entropy generation than we've got

and

* The entropy gathered from the soundcard is statistically inferior to
that gathered from the current sources of entropy.

I don't see how it's possible to guarantee that the data below a
certain dB level from the soundcard is noise.

John.
