Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268441AbTBNNwF>; Fri, 14 Feb 2003 08:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268444AbTBNNwF>; Fri, 14 Feb 2003 08:52:05 -0500
Received: from vsmtp1.tin.it ([212.216.176.221]:5261 "EHLO smtp1.cp.tin.it")
	by vger.kernel.org with ESMTP id <S268441AbTBNNwE>;
	Fri, 14 Feb 2003 08:52:04 -0500
Message-ID: <3E4CF5D2.6ED23062@libero.it>
Date: Fri, 14 Feb 2003 14:57:38 +0100
From: Abramo Bagnara <abramo.bagnara@libero.it>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en, it
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
References: <Pine.LNX.4.44.0302131452450.4232-100000@penguin.transmeta.com>
		 <3E4CAEFC.92914AB3@libero.it> <1045232677.7958.9.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Fri, 2003-02-14 at 08:55, Abramo Bagnara wrote:
> > This reminds me the unfortunate (and much needed) lack of an unified way
> > to send/receive out-of-band data to/from a regular fd.
> >
> > Something like:
> >       oob = fd_open(fd, channel, flags);
> >       write(oob, ...)
> >       read(oob, ....)
> >       close(oob);
> >
> > Don't you think it's time to introduce it and to start to avoid the
> > proliferation of different tricky ways to do the same things?
> 
> Why are you trying to throw yet more crap into the kernel. Linus signals
> as fd thing is questionable but makes a little sense (its in many ways
> more unix than the traditional approach of using real time queued
> signal since you can now select on it)

My comment was not related to "signals as fd" stuff, but to the more
generic need (implicit in Linus reply to Davide's comment) to have
sometimes a control channel for an open fd (much like a file approach to
ioctl/fcntl problem space).

FWIW and IIRC a similar solution (based on a fs approach) was suggested
also by Al Viro some time ago.

> Out of band data is a second data channel, so open two pipes. Jeez

What about the relation between the two channels?

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy
