Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312846AbSDHJz2>; Mon, 8 Apr 2002 05:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313422AbSDHJz1>; Mon, 8 Apr 2002 05:55:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57615 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S312846AbSDHJz1>; Mon, 8 Apr 2002 05:55:27 -0400
Date: Mon, 8 Apr 2002 11:55:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: Itai Nahshon <nahshon@actcom.co.il>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andrew Morton <akpm@zip.com.au>, joeja@mindspring.com,
        linux-kernel@vger.kernel.org
Subject: Re: faster boots?
Message-ID: <20020408095527.GA27999@atrey.karlin.mff.cuni.cz>
In-Reply-To: <E16tTAF-0008F2-00@the-village.bc.nu> <200204060007.g3607I525699@lmail.actcom.co.il> <20020407144246.C46@toy.ucw.cz> <200204080048.g380mt514749@lmail.actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I'm curios, how much work can you accomplish on your laptop
> > > without any disk access (but you still need to save files - keeping
> > > them in buffers until it's time to actually write them).
> >
> > Debugging session (emacs/gcc/gdb) for half an hour with disks stopped is
> > easy to accomplish.
> 
> My suggestion was: there should _never_ be dirty blocks for disks that
> are not spinning. Flush all dirty buffers before spinning down, and spin-up
> on any operation that writes to the disk (and block that operation).

And your suggestion is useless because disk will be up all the time on
the system...

> The opposite to that (which I do not like) processes create as many
> dirty buffers as they want and disk spins up only on sync() or when
> the system is starving for usable memory.

...which is usefull, OTOH. If you have laptop with battery and
suspend-to-disk capability in BIOS when battery goes low, you can
cache for *long* time.

> An aletrnate ides (more drastic) is that fle systems can mount internally
> read-only when a disk is spinned-down. Means - you cannot spin
> down when there is a file handle open for writing. Other than this there
> are advantages.

Hah, so you can never spindown because /var/log/syslog is opened for
writing.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
