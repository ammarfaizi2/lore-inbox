Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131323AbRDSQpn>; Thu, 19 Apr 2001 12:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131457AbRDSQpY>; Thu, 19 Apr 2001 12:45:24 -0400
Received: from smtp1.libero.it ([193.70.192.51]:44181 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S131323AbRDSQpO>;
	Thu, 19 Apr 2001 12:45:14 -0400
Message-ID: <3ADF15C7.B11A5488@alsa-project.org>
Date: Thu, 19 Apr 2001 18:43:51 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alon Ziv <alonz@nolaviz.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>,
        Ulrich Drepper <drepper@cygnus.com>
Subject: Re: light weight user level semaphores
In-Reply-To: <Pine.LNX.4.31.0104190903560.3842-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 19 Apr 2001, Abramo Bagnara wrote:
> >
> > > [ Using file descriptors ]
> >
> > This would also permit:
> > - to have poll()
> > - to use mmap() to obtain the userspace area
> >
> > It would become something very near to sacred Unix dogmas ;-)
> 
> No, this is NOT what the UNIX dogmas are all about.
> 
> When UNIX says "everything is a file", it really means that "everything is
> a stream of bytes". Things like magic operations on file desciptors are
> _anathema_ to UNIX. ioctl() is the worst wart of UNIX. Having magic
> semantics of file descriptors is NOT Unix dogma at all, it is a horrible
> corruption of the original UNIX cleanlyness.

Nice outpouring indeed, it seems taken from L'Ouvre au Noir by
Marguerite Yourcenar ;-)))

You're perfectly right but the file descriptor solution appeared to me a
nice way to work around the Unix limitation to have poll(2) working only
on file descriptor.

Said this, I've no doubt that a better poll-like syscall would solve all
that in a more elegant way.

You understand that sometime we've no other choice that to design
workarounds to minimize needed changes (and then often to maximize
acceptance probability).

OTOH you may always decide to do things in the elegant way, you've such
a responsibility for linux kernel.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
