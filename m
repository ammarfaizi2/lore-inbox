Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbSJZS4V>; Sat, 26 Oct 2002 14:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261475AbSJZS4V>; Sat, 26 Oct 2002 14:56:21 -0400
Received: from air-2.osdl.org ([65.172.181.6]:15501 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261463AbSJZS4U>;
	Sat, 26 Oct 2002 14:56:20 -0400
Date: Sat, 26 Oct 2002 12:06:08 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Toon van der Pas <toon@vanvergehaald.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 Problem Report Status
In-Reply-To: <20021026161830.E30058@vdpas.hobby.nl>
Message-ID: <Pine.LNX.4.44.0210261205460.983-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 Oct 2002, Toon van der Pas wrote:

> On Wed, Oct 23, 2002 at 10:03:51AM -0700, Patrick Mochel wrote:
> > 
> > ===== drivers/ide/ide.c 1.33 vs edited =====
> > --- 1.33/drivers/ide/ide.c	Fri Oct 18 12:44:11 2002
> > +++ edited/drivers/ide/ide.c	Wed Oct 23 09:42:27 2002
> > @@ -3351,6 +3351,14 @@
> >  	return 0;
> >  }
> >  
> > +static void ide_drive_shutdown(struct device * dev)
> > +{
> > +	ide_drive_t * drive = container_of(dev,ide_drive_t,gendev);
> > +	ide_driver_t * drive = drive->driver;
> 
> Are you sure you didn't introduce a typo here?  (missing 'r')
> Maybe you meant this line to be:
> 
> +	ide_driver_t * driver = drive->driver;

Uhm..yes. Sorry about that.

	-pat

