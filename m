Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293089AbSC0WXm>; Wed, 27 Mar 2002 17:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293053AbSC0WXc>; Wed, 27 Mar 2002 17:23:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60165 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293076AbSC0WXV>; Wed, 27 Mar 2002 17:23:21 -0500
Subject: Re: IDE and hot-swap disk caddies
To: pavel@suse.cz (Pavel Machek)
Date: Wed, 27 Mar 2002 22:38:40 +0000 (GMT)
Cc: andre@linux-ide.org (Andre Hedrick), wakko@animx.eu.org (Wakko Warner),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20020326185238.A324@toy.ucw.cz> from "Pavel Machek" at Mar 26, 2002 06:52:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16qM41-0006HG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You can paint a goose yellow and call it a duck, but it is still a goose.
> > The electrical/electronic interface will kill you!
> 
> USB mass storage is not SCSI (in some cases), either. [Ouch, and some
> usb-storage devices *are* IDE.]
> 
> So it makes sense to view IDE as very odd SCSI controllers.

IDE is very different. Its like calling NFS Netware. The upper layer
behaviour is fairly similar, and both ATAPI and USB mass storage is SCSI
alike (note if its not SCSI like its not USB mass storage its something else
eg a vendor specific driver).

Making other drivers appear to be scsi is coming from two things - 

#1 to avoid the Linus idiocy with major numbers
#2 its the sane way to do it on NT

For the 2.5 tree once the devicefs stuff is in this gets less and less sane.
With the high performance block layer work Jens has done going via scsi
emulation becomes a really dumb performance choice.

Alan
