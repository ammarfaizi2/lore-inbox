Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbREVR3r>; Tue, 22 May 2001 13:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262680AbREVR31>; Tue, 22 May 2001 13:29:27 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:28943 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S262681AbREVR3W>; Tue, 22 May 2001 13:29:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Oliver Xymoron <oxymoron@waste.org>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup)
Date: Tue, 22 May 2001 18:51:20 +0200
X-Mailer: KMail [version 1.2]
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0105220957400.19818-100000@waste.org>
In-Reply-To: <Pine.LNX.4.30.0105220957400.19818-100000@waste.org>
MIME-Version: 1.0
Message-Id: <0105221851200C.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 May 2001 17:24, Oliver Xymoron wrote:
> On Mon, 21 May 2001, Daniel Phillips wrote:
> > On Monday 21 May 2001 19:16, Oliver Xymoron wrote:
> > > What I'd like to see:
> > >
> > > - An interface for registering an array of related devices
> > > (almost always two: raw and ctl) and their legacy device numbers
> > > with a single userspace callout that does whatever /dev/ creation
> > > needs to be done. Thus, naming and permissions live in user
> > > space. No "device node is also a directory" weirdness...
> >
> > Could you be specific about what is weird about it?
>
> *boggle*
>
>[general sense of unease]
>
> I don't think it's likely to be even workable. Just consider the
> directory entry for a moment - is it going to be marked d or [cb]?

It's going to be marked 'd', it's a directory, not a file.

> If it doesn't have the directory bit set, Midnight commander won't
> let me look at it, and I wouldn't blame cd or ls for complaining. If it
> does have the 'd' bit set, I wouldn't blame cp, tar, find, or a
> million other programs if they did the wrong thing. They've had 30
> years to expect that files aren't directories. They're going to act
> weird.

No problem, it's a directory.

> Linus has been kicking this idea around for a couple years now and
> it's still a cute solution looking for a problem. It just doesn't
> belong in UNIX.

Hmm, ok, do we still have any *technical* reasons?

--
Daniel

