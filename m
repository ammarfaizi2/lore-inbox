Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290834AbSBLI44>; Tue, 12 Feb 2002 03:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290837AbSBLI4q>; Tue, 12 Feb 2002 03:56:46 -0500
Received: from line103-203.adsl.actcom.co.il ([192.117.103.203]:4112 "HELO
	alhambra.merseine.nu") by vger.kernel.org with SMTP
	id <S290834AbSBLI4h>; Tue, 12 Feb 2002 03:56:37 -0500
Date: Tue, 12 Feb 2002 10:56:17 +0200 (IST)
From: mulix <mulix@actcom.co.il>
X-X-Sender: <mulix@alhambra.merseine.nu>
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
Cc: <linux-kernel@vger.kernel.org>, Theodore Tso <tytso@mit.edu>,
        SA products <super.aorta@ntlworld.com>, <choo@actcom.co.il>
Subject: Re: faking time
In-Reply-To: <20020212093355.A29445@devcon.net>
Message-ID: <Pine.LNX.4.33.0202121052160.25841-100000@alhambra.merseine.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, Andreas Ferber wrote:

> On Mon, Feb 11, 2002 at 10:47:23PM -0500, Theodore Tso wrote:
> >
> > Here's an LD_PRELOAD shared library that will do the trick... just
> > export the environment variable FAKETIME with the time that you'd
> > like, and then export the LD_PRELOAD environment variable to point
> > that the faketime.so library, and then execute your program.  All
> > programs that have these two environment variables set will have their
> > time faked out accordingly.
>
> But note that this doesn't work with programs linked statically. If
> you must fool one of those, ptrace() is the only way to do it without
> some sort of kernel patch or module I think.

luckily, someone wrote such a kernel module - syscalltrack,
http://syscalltrack.sf.net.

it's in alpha stages right now, but it seems pretty stable so far (It
Works For Me - i run it regularly on all of my machines). note that we
currently support only logging system calls (a-la strace) and failing
them with a user given parameter- rewriting system call parameters will
require additional hackery, but not too much of it - on the order of one
day of work. volunteers are welcome.
-- 
mulix

http://vipe.technion.ac.il/~mulix/
http://syscalltrack.sf.net/


