Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262570AbRENXX5>; Mon, 14 May 2001 19:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262575AbRENXXr>; Mon, 14 May 2001 19:23:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45835 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262570AbRENXXa>; Mon, 14 May 2001 19:23:30 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: goemon@anime.net (Dan Hollis)
Date: Tue, 15 May 2001 00:19:15 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.30.0105141609460.15073-100000@anime.net> from "Dan Hollis" at May 14, 2001 04:11:16 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zRcR-0001gL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >     323
> > Also hdparm
> > raidtools
> > psmisc
> > mtools
> > mt-st
> > gpm
> > joystick
> 
> so we now have a list of stuff that needs to be fixed 8)
> or at least, a cross section sampling of stuff to design a new API for.

Yes. Most of it actually uses the major stuff to answer the question
'what ioctls are valid' 'what type of thing am I bashing on'

Just issuing ioctls doesnt help as we have overlaps 8( Also we dont want to
get into the DOS like execute 135 queries to figure out what it is by
deep magic patterns.

One suggestion is to do something like
	if(MAJOR_HAS(st, named-property))

which solves that and also nicely fixes an extant problem in that there isnt
a good way to break down heirarchies of ioctl features right now. That is
one thing devfs namespaces can be abused to solve but isnt really the right
use of it.


