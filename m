Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268446AbTBNNO7>; Fri, 14 Feb 2003 08:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268447AbTBNNO6>; Fri, 14 Feb 2003 08:14:58 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35201
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268446AbTBNNOv>; Fri, 14 Feb 2003 08:14:51 -0500
Subject: Re: Synchronous signal delivery..
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E4CAEFC.92914AB3@libero.it>
References: <Pine.LNX.4.44.0302131452450.4232-100000@penguin.transmeta.com>
	 <3E4CAEFC.92914AB3@libero.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045232677.7958.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 14 Feb 2003 14:24:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 08:55, Abramo Bagnara wrote:
> This reminds me the unfortunate (and much needed) lack of an unified way
> to send/receive out-of-band data to/from a regular fd.
> 
> Something like:
> 	oob = fd_open(fd, channel, flags);
> 	write(oob, ...)
> 	read(oob, ....)
> 	close(oob);
> 
> Don't you think it's time to introduce it and to start to avoid the
> proliferation of different tricky ways to do the same things?

Why are you trying to throw yet more crap into the kernel. Linus signals
as fd thing is questionable but makes a little sense (its in many ways
more unix than the traditional approach of using real time queued
signal since you can now select on it)

Out of band data is a second data channel, so open two pipes. Jeez


