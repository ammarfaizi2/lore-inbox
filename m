Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSLAK05>; Sun, 1 Dec 2002 05:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbSLAK05>; Sun, 1 Dec 2002 05:26:57 -0500
Received: from [195.223.140.107] ([195.223.140.107]:24237 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S261593AbSLAK04>;
	Sun, 1 Dec 2002 05:26:56 -0500
Date: Sun, 1 Dec 2002 11:34:13 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Javier Marcet <jmarcet@pobox.com>
Cc: khromy <khromy@lnuxlab.ath.cx>, linux-kernel@vger.kernel.org
Subject: Re: Exaggerated swap usage
Message-ID: <20021201103413.GK28164@dualathlon.random>
References: <20021130182345.GA21410@lnuxlab.ath.cx> <20021130184317.GH28164@dualathlon.random> <20021201075345.GA2483@jerry.marcet.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021201075345.GA2483@jerry.marcet.dyndns.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2002 at 08:53:45AM +0100, Javier Marcet wrote:
> * Andrea Arcangeli <andrea@suse.de> [021130 19:47]:
> 
> >>> I'm about to try 2.4.20-jam0, -aa derived. I'll post results from that
> >>> kernel later.
> 
> >>aa runs beautifully but it locked up once on me..
> 
> >send me SYSRQ+T SYSRQ+P and everything else you know about it. if you
> >have AGP enabled try to reproduce with 10_x86-fast-pte-2 backed out.
> 
> I spoke too fast. Just after sending the e-mail, I kept reading the
> mailing-list within mutt while compiling sane-backends and it locked up.
> It's the first time I try kmsgdump, which comes included in -aa, I
> dumped the info to a FAT12 disk. Yet the messages.txt I found on the
> disk shows nothing.
> I attach it anyway, just in case, since it is 16384 bytes in size but
> doubt it'll be of any use.
> How else can I take down the kernel dump without any additional computer
> at hand? I'd prefer not having to write it down, ... but I'll do it if
> there's no other way.

you can use kmsgdump (you should find it on sourceforge or similar). It
allows you to dump the oops to a floppy.

you can also try to apply 02-revert-fast-pte-2.bz2 and see if the
problem goes away. It must be some driver or something that deadlocks
the machine for you, I can't reproduce it here. Maybe you're using AGP
or some binary only module?

If the problem goes away by applying 02-revert-fast-pte-2.bz2 you can
back it out again and apply as well the debugging patch I posted
yesterday to l-k, so we'll get a stack trace in the right place.

Andrea
