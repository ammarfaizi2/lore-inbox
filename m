Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261191AbREOSM1>; Tue, 15 May 2001 14:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261246AbREOSMQ>; Tue, 15 May 2001 14:12:16 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:1162 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S261201AbREOSCG>; Tue, 15 May 2001 14:02:06 -0400
Date: Tue, 15 May 2001 20:02:02 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010515200202.A754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <E14zb68-0002Fq-00@the-village.bc.nu> <Pine.LNX.4.21.0105150803230.1802-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0105150803230.1802-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, May 15, 2001 at 08:10:29AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2001 at 08:10:29AM -0700, Linus Torvalds wrote:
> That said:
> 
> > 	/* Use scsi if possible [scsi, ide-scsi, usb-scsi, ...] */
> > 	if(HAS_FEATURE_SET(fd, "scsi-tape"))
> > 		...
> > 	else if(HAS_FEATURE_SET(fd, "floppy-tape"))
> > 		..
> 
> doesn't look horrible,

That is good and the thing other OS do since years. The call it
"DEVCAPS" or "device capabilities". They use bitmasks for this
(which might not be perfect).

> and I don't see why we couldn't expose the "driver
> name" for any file descriptor.

Because we dont like to replace:

   if (st.device == MAJOR_1)
      bla
   else if ...

with

   if (!strcmp(st.device,"driver_1") )
      bla
   else if ...

?

There is no win doing it this way, because every time we add a
new driver that fits or change the name of one, we need add
support for it.

But the device majors are not needed for this, that's true ;-)

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
