Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130425AbQLSSVO>; Tue, 19 Dec 2000 13:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbQLSSVE>; Tue, 19 Dec 2000 13:21:04 -0500
Received: from feral.com ([192.67.166.1]:20549 "EHLO feral.com")
	by vger.kernel.org with ESMTP id <S130427AbQLSSU6>;
	Tue, 19 Dec 2000 13:20:58 -0500
Date: Tue, 19 Dec 2000 09:50:23 -0800 (PST)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Robert Read <rread@datarithm.net>
cc: Peter Rival <frival@zk3.dec.com>, linux-kernel@vger.kernel.org,
        axp-list <axp-list@redhat.com>
Subject: Re: QLogicFC problems with 2.4.x?
In-Reply-To: <20001219085639.C15413@tenchi.datarithm.net>
Message-ID: <Pine.BSF.4.21.0012190947070.61233-100000@beppo.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It does, but 2.4 alpha hasn't quite worked for me (the latest matrix of
support for LINUX is below- and I haven't passed Michael Declerck's testing
yet). I'll be checking the latest alpha bits this week some time and I still
also need to finish the kernel thread work that will allow loop events to be
down OOB.

------------------------------------------------------------------------------
Linux Notes

2.0/2.1/2.3 support dropped. 2.0 support will be added back later, but
basically, it'll be 2.0/2.2/2.4 only support.

NOTE: SOME CHANGES ARE NOW REQUIRED IN A DEFAULT KERNEL BECAUSE WE NEED
NOTE: SOME EXTRA SYMBOLS EXPORTED. SEE LINUX_BUILD INSTRUCTIONS.
NOTE:	AT THIS TIME YOU MUST BOOT 2.4/i386 WITH nmi_watchdog=0
NOTE:	APPENDED TO THE BOOT COMMAND LINE.

NOTE:	TARGET MODE IS BROKEN IN LINUX RIGHT NOW

This release has been tested agains:

	Alpha		2.2.17		[1]
	IA-32		2.2.17		2.4.0-test11
	PowerPC		2.2.17		[2]
	Sparc64		2.2.17		2.4.0-test11

There are now patches agains 2.2.17 and 2.4.0-test11 in the linux subdirectory.
Or you can build as a module in place in the linux directory. See
LINUX_BUILD_INSTRUCTIONS.

[1] 2.4.0-test11 panic'd and crashed and burned in readw for me. I think
that this is a known alpha arch problem at this time, so I'm going to wait
until  'they' fix it.
[2] I can't find a complable 2.4 for PPC at the time of test1.
------------------------------------------------------------------------------

On Tue, 19 Dec 2000, Robert Read wrote:

> 
> The driver loads for me on 2.4 on Intel, but I don't have access to an
> Alpha right now. Have you tried Mathew Jacob's driver?  It looks like
> it supports Alpha.
> 
> http://www.feral.com/isp.html
> 
> robert
> 
> On Mon, Dec 18, 2000 at 04:24:38PM -0500, Peter Rival wrote:
> > Hi,
> > 
> >    I was just lent a QLogic ISP2200 FC adapter and have been having a 
> > bear of a time trying to get it to work on my Alpha ES40 and GS80.  I've 
> > tried both the qlogicfc (with standard kernel) and qla2x00 (from QLogic 
> > and Compaq) driver both built-in and as modules but neither of them are 
> > working.  Has anyone had success with later (I'm using 2.4.0-test11) 2.4 
> > kernels and the QLogic FC adapter?  I'm currently plugged into a Brocade 
> > switch (Plaides I, I believe) which is also attached to two pair of 
> > HSG80 FC RAID controllers.  AFAIK, the 2200 is supposed to work with an 
> > FC fabric, so this should work, right?  Can anyone offer any 
> > assistance?  Thanks!
> > 
> >   - Pete
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
