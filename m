Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135363AbRDRVh1>; Wed, 18 Apr 2001 17:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135364AbRDRVhS>; Wed, 18 Apr 2001 17:37:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:52752 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135363AbRDRVhE>;
	Wed, 18 Apr 2001 17:37:04 -0400
Date: Wed, 18 Apr 2001 23:36:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Guest section DW <dwguest@win.tue.nl>
Cc: Giuliano Pochini <pochini@shiny.it>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, lna@bigfoot.com
Subject: Re: I can eject a mounted CD
Message-ID: <20010418233637.J501@suse.de>
In-Reply-To: <E14pqzO-0004bp-00@the-village.bc.nu> <XFMail.010418150323.pochini@shiny.it> <20010418150622.P490@suse.de> <20010418230335.A17216@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010418230335.A17216@win.tue.nl>; from dwguest@win.tue.nl on Wed, Apr 18, 2001 at 11:03:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18 2001, Guest section DW wrote:
> On Wed, Apr 18, 2001 at 03:06:22PM +0200, Jens Axboe wrote:
> > On Wed, Apr 18 2001, Giuliano Pochini wrote:
> 
> > > > vmware and one or two other apps I've also seen do this. WHen
> > > > you unlock the cdrom door as root you can unlock it even if a
> > > > file system is mounted
> > > 
> > > Right, so I'll check what eject(1) does. It might eject the disk
> > > even if it failed to unmount.
> > 
> > It shouldn't be able to. But check and see what happens.
> 
> (1) There are many different programs all called eject(1).  I find at
> least four of them on this machine.
> 
> (2) I missed the start of the discussion; if this is a SCSI cdrom then
> many eject programs will use raw SCSI commands and the kernel does not
> try to parse raw SCSI commands so does not know that it is ejecting a
> mounted cdrom.

#2 can be done on any CDROM these days in fact, if eject uses
CDROM_SEND_PACKET then it can _always_ open the tray as well regardless
of mount status etc.

-- 
Jens Axboe

