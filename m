Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267577AbRG2J2S>; Sun, 29 Jul 2001 05:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267580AbRG2J2I>; Sun, 29 Jul 2001 05:28:08 -0400
Received: from pD951F4D6.dip.t-dialin.net ([217.81.244.214]:25984 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S267577AbRG2J2D>; Sun, 29 Jul 2001 05:28:03 -0400
Date: Sun, 29 Jul 2001 11:28:10 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010729112810.C9109@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010729011552.B9350@emma1.emma.line.org> <Pine.LNX.4.33L.0107282046560.11893-100000@imladris.rielhome.conectiva> <20010729020812.D9350@emma1.emma.line.org> <20010728195132.M30957@bluemug.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010728195132.M30957@bluemug.com>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, 28 Jul 2001, Mike Touloumtzis wrote:

> You are blurring the boundaries between "undocumented behavior" and
> "OS-specific behavior".  fsync() on a directory to sync metadata is a
> defined (according to my copy of fsync(2)), Linux-specific behavior.
> It is also very reasonable IMHO and in keeping with the traditional
> Unix notion of directories as lists of files.

No-one claims that fsync() the directory is a bad interface - it's
non-portable however. Actually, chattr +S is well-documented - it just
doesn't work on ReiserFS or Minix for now, and it may be unnecessarily
slow on ext2.

As pointed out more than once, "synchronous meta data" is documented e.
g.  for FreeBSD, so in at least these two cases, the box relies on
documented behaviour.

> http://www.google.com/search?q=autoconf
> 
> Writing portable Unix software has always meant some degree
> of system-specific accomodation.  It's a bummer but it's life;
> otherwise Unix wouldn't evolve.

How can autoconf figure if you need to fsync() the directory? Apart from
that, which Unix MTA uses autoconf?

Remember, the whole discussion is about getting rid of the need for
chattr +S and offering the admin the chance to mount or flag a directory
for synchronous meta data updates.

-- 
Matthias Andree
