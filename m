Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262691AbREVRsR>; Tue, 22 May 2001 13:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262692AbREVRr5>; Tue, 22 May 2001 13:47:57 -0400
Received: from waste.org ([209.173.204.2]:27722 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262690AbREVRrr>;
	Tue, 22 May 2001 13:47:47 -0400
Date: Tue, 22 May 2001 12:49:12 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device
 arguments from lookup)
In-Reply-To: <0105221851200C.06233@starship>
Message-ID: <Pine.LNX.4.30.0105221231370.19818-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2001, Daniel Phillips wrote:

> > I don't think it's likely to be even workable. Just consider the
> > directory entry for a moment - is it going to be marked d or [cb]?
>
> It's going to be marked 'd', it's a directory, not a file.

Are we talking about the same proposal?  The one where I can open /dev/dsp
and /dev/dsp/ctl? But I can still do 'cat /dev/hda > /dev/dsp'?

It's still a file. If it's not a file anymore, it ain't UNIX.

> > If it doesn't have the directory bit set, Midnight commander won't
> > let me look at it, and I wouldn't blame cd or ls for complaining. If it
> > does have the 'd' bit set, I wouldn't blame cp, tar, find, or a
> > million other programs if they did the wrong thing. They've had 30
> > years to expect that files aren't directories. They're going to act
> > weird.
>
> No problem, it's a directory.
>
> > Linus has been kicking this idea around for a couple years now and
> > it's still a cute solution looking for a problem. It just doesn't
> > belong in UNIX.
>
> Hmm, ok, do we still have any *technical* reasons?

If you define *technical* to not include design, sure. Oh, did I
mention unnecessary, solvable in userspace?

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."


