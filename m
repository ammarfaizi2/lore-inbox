Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264213AbRFFWkD>; Wed, 6 Jun 2001 18:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264215AbRFFWj5>; Wed, 6 Jun 2001 18:39:57 -0400
Received: from www.transvirtual.com ([206.14.214.140]:60172 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S264213AbRFFWjr>; Wed, 6 Jun 2001 18:39:47 -0400
Date: Wed, 6 Jun 2001 15:39:04 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Vojtech Pavlik <vojtech@suse.cz>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tytso@mit.edu,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [driver] New life for Serial mice
In-Reply-To: <20010606220832.A31009@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10106061527580.12135-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > It would be nice if we had 
> > 
> > 1) A seperate serial directory under drivers.
> > 
> > 2) A nice structure that input devices and the tty layer can use. It is
> >    just a waste to go threw the tty layer for input devices. It would also
> >    make serial driver writing easier if the api is designed right :-) 
> 
> I am planning some day (don't know when yet though) to convert the 16x50
> driver over to the serial_core stuff.

I ported it over to my tree. I will have to figure out how to incorporate
the input serial stuff without breaking all the input drivers we have. In
CVS we have alot of them. This will make life so much easier since all I
will have to do is change one file for changes I make to the tty layer. I
have improved andrew mortons console patch to work with multiple consoles
and for different types of console devices. Instead of altering all the 
console drivers I'm planning on intergrating the locking into the tty
layer. That patch is needed for serial devices as well as video terminals.
Your work might help speed up devleopement.

> NB, Ted Tytso mentioned something at the 2.5 conference about integrating
> some of the serial layer with the tty layer.

What does he have in mind? I like to keep my VT changes in sync with what
he has in mind.

