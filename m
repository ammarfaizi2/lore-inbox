Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129754AbRBYVPJ>; Sun, 25 Feb 2001 16:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129759AbRBYVPA>; Sun, 25 Feb 2001 16:15:00 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33805 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129754AbRBYVOq>;
	Sun, 25 Feb 2001 16:14:46 -0500
Date: Sun, 25 Feb 2001 22:14:33 +0100
From: Jens Axboe <axboe@suse.de>
To: Steven Walter <srwalter@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2 broke gcd (or, audio CD's won't play)
Message-ID: <20010225221433.M7830@suse.de>
In-Reply-To: <20010223183743.A26519@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010223183743.A26519@hapablap.dyn.dhs.org>; from srwalter@yahoo.com on Fri, Feb 23, 2001 at 06:37:43PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23 2001, Steven Walter wrote:
> After upgrading to 2.4.2, gcd or any audio CD player will work.  The
> attached chunk of dmesg is the messages produced by attempting to play
> them.  The player just loops through all tracks, playing nothing.
> Ripping CD's a la cdparanoia still works.
> 
> If its any consequence, my CD-ROM is now detected as a CD-ROM/DVD-ROM.
> Is this also a problem, or merely an optimization in the boot-detection
> routines?

That doesn't matter, the boot info just means it could be either
a cdrom or a dvd drive.

But these:

ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid command operation code -- (asc=0x20, ascq=0x00)
  The failed "Play Audio MSF" packet command was:
  "47 00 00 2d 2b 1b 39 38 00 00 00 00 "
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid command operation code -- (asc=0x20, ascq=0x00)
  The failed "Test Unit Ready" packet command was:
  "00 00 00 00 00 00 00 00 00 00 00 00 "
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid command operation code -- (asc=0x20, ascq=0x00)
  The failed "Test Unit Ready" packet command was:
  "00 00 00 00 00 00 00 00 00 00 00 00 "
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid command operation code -- (asc=0x20, ascq=0x00)
  The failed "Play Audio MSF" packet command was:
  "47 00 00 37 04 28 39 38 00 00 00 00 "

look very odd. It's basically saying that these required commands
are not implemented by the drive. 2.4.1 worked fine?!

-- 
Jens Axboe

