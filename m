Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbRBLHDB>; Mon, 12 Feb 2001 02:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129122AbRBLHCu>; Mon, 12 Feb 2001 02:02:50 -0500
Received: from [206.112.106.250] ([206.112.106.250]:17412 "EHLO
	mercury.illtel.denver.co.us") by vger.kernel.org with ESMTP
	id <S129091AbRBLHCn>; Mon, 12 Feb 2001 02:02:43 -0500
Date: Sun, 11 Feb 2001 23:03:14 -0800 (PST)
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
To: Pavel Machek <pavel@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Serial device with very large buffer
In-Reply-To: <20010209201243.D16776@bug.ucw.cz>
Message-ID: <Pine.LNX.4.10.10102112257060.908-100000@mercury>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2001, Pavel Machek wrote:

> > >   I also propose to increase the size of flip buffer to 640 bytes (so the
> > > flipping won't occur every time in the middle of the full buffer), however
> > > I understand that it's a rather drastic change for such a simple goal, and
> > > not everyone will agree that it's worth the trouble:
> > 
> > Going to a 1K flip buffer would make sense IMHO for high speed devices too
> 
> Actually bigger flipbufs are needed for highspeed serials and
> irda. Tytso received patch to make flipbuf size settable by the
> driver. (Setting it to 1K is not easy, you need to change allocation
> mechanism of buffers.)

  The need for changes in allocation mechanism was the reason why I have
limited the buffer increase to 640 bytes. If changes already exist, and
there is no some hidden overhead associated with them, I am all for it.

  Still it's not a replacement for the change in serial driver that I have
posted -- assumption that hardware is slower than we are, that it has
limited buffer in the way, and that it's ok to discard all the data beyond
our buffer's size is, to say least, silly.

-- 
Alex

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
