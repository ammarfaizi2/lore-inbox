Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264665AbTBOR6g>; Sat, 15 Feb 2003 12:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbTBOR6g>; Sat, 15 Feb 2003 12:58:36 -0500
Received: from vsmtp2.tin.it ([212.216.176.222]:17389 "EHLO smtp2.cp.tin.it")
	by vger.kernel.org with ESMTP id <S264665AbTBOR6f>;
	Sat, 15 Feb 2003 12:58:35 -0500
Message-ID: <3E4E8013.C26DFA0@libero.it>
Date: Sat, 15 Feb 2003 18:59:47 +0100
From: Abramo Bagnara <abramo.bagnara@libero.it>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en, it
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
References: <Pine.LNX.4.44.0302131452450.4232-100000@penguin.transmeta.com> <3E4CAEFC.92914AB3@libero.it> <1045232677.7958.9.camel@irongate.swansea.linux.org.uk> <3E4CF5D2.6ED23062@libero.it> <20030215133600.F629@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> 
> On Fri, Feb 14, 2003 at 02:57:38PM +0100, Abramo Bagnara wrote:
> > > Out of band data is a second data channel, so open two pipes. Jeez
> >
> > What about the relation between the two channels?
> 
> Encoded in the program logic, where it belongs. We have enough
> needless interrelations between API functions already.
> 
> If you would like to have two channels in one, than simply
> implement a multiplexer in the program that needs it (look at ssh
> for an example).

We might call this thread "the neverending misunderstanding" ;-)

My message was a proposal about an universal solution for
control/out-of-band streams on pseudo-files (like the Linus sig fd,
devices fd, socket, proc files, etc.) as a way to comunicate between
user space and kernel space.

I.e. something that might replace ioctl/fcntl mess giving same (and
more) flexybility and power (extending the 'everything is a file'
concept also to control data).

This is *not* something I'd propose for user space (where we definitely
have many good ways to achieve these results).

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy
