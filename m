Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272677AbRIXB1n>; Sun, 23 Sep 2001 21:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273737AbRIXB1X>; Sun, 23 Sep 2001 21:27:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35847 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273736AbRIXB1Q>; Sun, 23 Sep 2001 21:27:16 -0400
Date: Sun, 23 Sep 2001 18:25:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: <zefram@fysh.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty canonical mode: nicer erase behaviour
In-Reply-To: <E15lHUG-0001N5-00@bowl.fysh.org>
Message-ID: <Pine.LNX.4.33.0109231823480.1552-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Sep 2001 zefram@fysh.org wrote:

> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >Your xterm is not following Linux policy - this is a solved problem in
> >Linuxspace. Debian bit the bullet a few years ago and did the neccessary
> >deed to make all their terminal emulators and console match.
>
> So Linux policy is to support only terminals that generate ^? for
> backspace?

No.

Linux supports everything. Try doing a "man stty".

But the default behaviour is ^?, which makes emacs happy, and also happens
to be the default mode for most real vt100 terminals out there.

If you have a terminal that really really wants ^H, just do

	stty erase ^H

and Linux will happily believe you.

		Linus

