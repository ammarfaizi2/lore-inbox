Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160002AbQGaOLz>; Mon, 31 Jul 2000 10:11:55 -0400
Received: by vger.rutgers.edu id <S159999AbQGaOLi>; Mon, 31 Jul 2000 10:11:38 -0400
Received: from [195.71.101.13] ([195.71.101.13]:1560 "HELO lxMA.nowhere") by vger.rutgers.edu with SMTP id <S159990AbQGaOLW>; Mon, 31 Jul 2000 10:11:22 -0400
Date: Mon, 31 Jul 2000 16:31:27 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: reiserfs@devlinux.com, linux-kernel@vger.rutgers.edu
Subject: Re: (reiserfs) Re: sync: why disk cannot spin down
Message-ID: <20000731163127.G2224@lxMA.mediaways.net>
Mail-Followup-To: reiserfs@devlinux.com, linux-kernel@vger.rutgers.edu
References: <Pine.LNX.4.10.10007310700001.6252-100000@master.linux-ide.org> <39858A9F.C272E4E8@baldauf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <39858A9F.C272E4E8@baldauf.org>; from xuan--reiserfs@baldauf.org on Mon, Jul 31, 2000 at 16:18:07 +0200
Sender: owner-linux-kernel@vger.rutgers.edu

On Mon, 31 Jul 2000, Xuan Baldauf wrote:

> > > does not necessarily spin up the disk!
> >
> > Because you have to issue a drive reset.
> 
> This is my intent, not to spin up the disk. (In my previous case, sync
> always spun up the disk because the filesystem was not mounted with
> "noatime".)

This will still not work, since after some time, the kernel starts
missing the drive acknowledgements and eventually issues a reset
condition on that IDE channel. See my other mail for details.

-- 
Matthias Andree

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
