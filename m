Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSDIWWN>; Tue, 9 Apr 2002 18:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSDIWWM>; Tue, 9 Apr 2002 18:22:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34821 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S311871AbSDIWWM>; Tue, 9 Apr 2002 18:22:12 -0400
Date: Wed, 10 Apr 2002 00:22:14 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Pavel Machek <pavel@suse.cz>,
        Andrew Morton <akpm@zip.com.au>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, nahshon@actcom.co.il,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, joeja@mindspring.com,
        linux-kernel@vger.kernel.org
Subject: Re: faster boots?
Message-ID: <20020409222214.GK5148@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200204080048.g380mt514749@lmail.actcom.co.il> <200204080057.g380vbO00868@vindaloo.ras.ucalgary.ca> <3CB0EF0B.14D48619@zip.com.au> <20020408095717.GB27999@atrey.karlin.mff.cuni.cz> <20020408174333.A28116@kushida.apsleyroad.org> <20020408124803.A14935@redhat.com> <20020409015657.A28889@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> > > > Well, noflushd already seems to work pretty well ;-). But I see kernel
> > > > support may be required for SCSI.
> > > 
> > > I've had no luck at all with noflushd on my Toshiba Satellite 4070CDT.
> > > It would spin down every few minutes, and then spin up _immediately_,
> > > every time.  I have no idea why.
> > 
> > Were you using the console?  Any activity on ttys causes device inode 
> > atime/mtime updates which trigger disk spin ups.  The easiest way to 
> > work around this is to run X while using devpts for the ptys.
> 
> I was using X, nodiratime on all /dev/hda mounts.  My friend who has the
> small VAIO with a Crusoe chip also reports the same problem: noflushd
> doesn't work with 2.4 kernels (versions that we tried), and the problem
> is the same: it spins down and then spins up immediately afterward.

It works for me, 2.4.18 on HP omnibook xe3.

You may want to watch /proc/stats to see if it is read or write
activity that wakes disk up.

									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
