Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157425AbQGaN4O>; Mon, 31 Jul 2000 09:56:14 -0400
Received: by vger.rutgers.edu id <S157514AbQGaN4E>; Mon, 31 Jul 2000 09:56:04 -0400
Received: from [195.71.101.13] ([195.71.101.13]:4736 "HELO lxMA.nowhere") by vger.rutgers.edu with SMTP id <S157425AbQGaNzx>; Mon, 31 Jul 2000 09:55:53 -0400
Date: Mon, 31 Jul 2000 16:15:55 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: reiserfs@devlinux.com, linux-kernel@vger.rutgers.edu
Subject: Re: (reiserfs) Re: sync: why disk cannot spin down
Message-ID: <20000731161555.F2224@lxMA.mediaways.net>
Mail-Followup-To: reiserfs@devlinux.com, linux-kernel@vger.rutgers.edu
References: <200007302237.XAA11816@flint.arm.linux.org.uk> <3984B985.680B0ACF@baldauf.org> <3985680D.49B19846@baldauf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3985680D.49B19846@baldauf.org>; from xuan--reiserfs@baldauf.org on Mon, Jul 31, 2000 at 13:50:37 +0200
Sender: owner-linux-kernel@vger.rutgers.edu

On Mon, 31 Jul 2000, Xuan Baldauf wrote:

> Xuan Baldauf wrote:
> sync; hdparm -C -Y /dev/hda; sync; hdparm -C /dev/hda

Note that "sleep" mode is quite different from "standby" mode. Drives
spin up from standby mode by themselves, they are NOT supposed to wake
up from sleep mode, unless you issue a reset.

Sleep mode is meant to put the drive to sleep, possibly switching the
laptop off or something.

We happen to be so lucky that the Linux kernel issues a reset if it is
fed up with IDE timeouts, which will bring the drive back online, at the
expense of voiding all settings in that IDE channel, particularly, DMA
modes, PIO modes and the like, unless you use the "keep options over
reset flag".  (which means soft reset, effectively).

Admittedly, drives should use less power in sleep mode, the price is
higher latency and, as said before, possibly loss of drive
configuration.

-- 
Matthias Andree

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
