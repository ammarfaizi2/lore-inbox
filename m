Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314403AbSGUUqx>; Sun, 21 Jul 2002 16:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSGUUqw>; Sun, 21 Jul 2002 16:46:52 -0400
Received: from hoochie.linux-support.net ([216.207.245.2]:27572 "EHLO
	hoochie.linux-support.net") by vger.kernel.org with ESMTP
	id <S314403AbSGUUqv>; Sun, 21 Jul 2002 16:46:51 -0400
Date: Sun, 21 Jul 2002 15:49:56 -0500 (CDT)
From: Mark Spencer <markster@linux-support.net>
To: Daniel Phillips <phillips@arcor.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Zaptel Pseudo TDM Bus
In-Reply-To: <E17WMw3-0008CC-00@starship>
Message-ID: <Pine.LNX.4.33.0207211537550.25617-100000@hoochie.linux-support.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know about performance (except for quality: it's said to require
> about half the bitrate for the same quality, compared to mp3) however, it
> has one killer advantage over mp3: it's patent-free, and hence, royalty-free.
> I'd think that would be important for your project.

Right.  The mp3 decoder is also (as far as I know) unencumbered, and I
have no intent of putting an mp3 encoder in.  I certainly don't mind
adding Ogg support, it's just not a really big priority.

> > On a 900 Mhz Athlon, you can get *hundreds* of simultaneous full-duplex
> > GSM full-rate codecs running.  Certainly that's an unrealistic expectation
> > even for half-duplex ogg or mp3.
>
> But that would be an argument against supporting mp3 as well.

Yes, mp3 doesn't make sense either in general except for music on hold,
for example.  In fact I've considered dropping it entirely from Asterisk
except that since it's already there, I don't see an overwhelming reason
to remove it.

> Perhaps the last time you looked at Ogg the streaming format had not yet been
> completed?

The streaming format is quite irrelevant here.  It's the size of window
that you are encoding that is important.  Some review of the
vorbis-spec-intro reveals that it may be able to support smaller frame
sizes and sampling rates, so it might be worth giving then a call.

> Also, doesn't part of telephony consist of having lots of pre-recorded audio
> around, for voice mail etc?  Granted, an encoder optimized for music is not
> necessarily optimzed for voice.  However, would that not be a matter of
> tweaking the encoder?  As I understand it, the vorbis compression format is
> quite general, and in fact, all the recent work that improved the quality so
> noticably involved only the encoder.

In general, Asterisk's prompts are stored in GSM since it is so
inexpensive to compute and generally about the same size as MP3 / Ogg when
corrected for bit rate (and obviously much smaller when not corrected for
bit rate).

> OK, this isn't a really kernel issue, so... I'll clamp my hams and post it
> anyway ;-)

If you'd like to sign up on the Asterisk mailing list, that is presumably
a much better arena for discussing this.  If Ogg makes sense to add to
Asterisk I'd certainly be happy to do so.

Mark

