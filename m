Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292338AbSBULTh>; Thu, 21 Feb 2002 06:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292339AbSBULT1>; Thu, 21 Feb 2002 06:19:27 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:52497
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292338AbSBULTQ>; Thu, 21 Feb 2002 06:19:16 -0500
Date: Thu, 21 Feb 2002 03:06:46 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5 IDE cleanup 11
In-Reply-To: <3C74D18D.FCCFEA83@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10202210304360.29990-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Jeff Garzik wrote:

> > @@ -2929,7 +2928,6 @@
> >         capacity:               ide_cdrom_capacity,
> >         special:                NULL,
> >         proc:                   NULL,
> > -       driver_init:            ide_cdrom_init,
> >         driver_reinit:          ide_cdrom_reinit,
> >  };
> >  
> > @@ -2967,7 +2965,7 @@
> >         DRIVER(drive)->busy--;
> >         failed--;
> >  
> > -       ide_register_module(&ide_cdrom_driver);
> > +       revalidate_drives();
> >         MOD_DEC_USE_COUNT;
> >         return 0;
> >  }
> 
> hum, I'm not sure that removing ->driver_init is a good idea.
> 
> Seems like a loss of flexibility to me, not a cleanup, and I wonder if
> you have thought through all the paths that wind up calling
> ->driver_init.

Nah, go ahead add it.

I have been meaning to start another driver from scratch that is fully
threaded IO and can deal with register core operations independent of the
how the arch calls the transport.

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

