Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157695AbQGaOfN>; Mon, 31 Jul 2000 10:35:13 -0400
Received: by vger.rutgers.edu id <S157355AbQGaOeU>; Mon, 31 Jul 2000 10:34:20 -0400
Received: from [195.71.101.13] ([195.71.101.13]:2062 "HELO lxMA.nowhere") by vger.rutgers.edu with SMTP id <S157663AbQGaOcz>; Mon, 31 Jul 2000 10:32:55 -0400
Date: Mon, 31 Jul 2000 16:53:00 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: reiserfs@devlinux.com, linux-kernel@vger.rutgers.edu
Subject: Re: (reiserfs) Re: sync: why disk cannot spin down
Message-ID: <20000731165300.I2224@lxMA.mediaways.net>
Mail-Followup-To: reiserfs@devlinux.com, linux-kernel@vger.rutgers.edu
References: <Pine.LNX.4.10.10007310700001.6252-100000@master.linux-ide.org> <39858A9F.C272E4E8@baldauf.org> <20000731163127.G2224@lxMA.mediaways.net> <3985919F.3ADB81AD@baldauf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3985919F.3ADB81AD@baldauf.org>; from xuan--reiserfs@baldauf.org on Mon, Jul 31, 2000 at 16:47:59 +0200
Sender: owner-linux-kernel@vger.rutgers.edu

On Mon, 31 Jul 2000, Xuan Baldauf wrote:
> Matthias Andree wrote:
> You tell me the kernel starts missing drive ACKs even if there are no read
> or write requests pending? Even then, the drive was never in sleep mode
> (requires reset), it always was in standby mode (does not require reset). My
> primary intent is to reduce the noise of the drive, not the power
> consumption.

Of course, if the kernel is not writing, it's not missing "operation
complete" transactions.

My point is: putting a drive to sleep rather than to standby will not
help much, it will only delay the spin-up and possibly leave you with a
slower drive.

-- 
Matthias Andree

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
