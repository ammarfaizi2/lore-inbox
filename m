Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266215AbUHRNnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266215AbUHRNnW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 09:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUHRNnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 09:43:22 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:19384 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S266215AbUHRNnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 09:43:14 -0400
Date: Wed, 18 Aug 2004 15:43:09 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: Eric Lammerts <eric@lammerts.org>
cc: Kyle Moffett <mrmacman_g4@mac.com>, Patrick McFarland <diablod3@gmail.com>,
       Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <Pine.LNX.4.58.0408180111570.20812@vivaldi.madbase.net>
Message-ID: <Pine.LNX.4.44.0408181535130.30116-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004, Eric Lammerts wrote:

> 
> On Wed, 18 Aug 2004, Robert M. Stockmann wrote:
> > On Tue, 17 Aug 2004, Kyle Moffett wrote:
> > > Jens Axboe has _repeatedly_ asked you for your dmesg so he can
> > > determine if it's a bug or not, and you have _repeatedly_ ignored
> > > his emails.  Either give us enough information to identify and fix
> > > the issue (if any), or shut up
> >
> > So i may turn the question around : Is SuSE's techsupport or development
> > dep. aware that there are issue's reported about DMA failing to switch on
> > when dealing with UDMA DVD writers?
> 
> -ENODMESG
> 

Well sorry about that, the machine is not in my possesion anymore. But again,
i produced enough info to be able to reproduce the error :

machine : compaq proliant 800 2x PIII 500MHz/512kb (Katmai)
	128 Mb RAM, 2x 9.1Gb U2W SCSI
	_NEC DVD_RW ND-2510A Dual Layer burner

OS : 	SuSE 9.1 i386  default vanilla installation

burning software : cdrtools-2.01a27.tar.bz2 from
			ftp://ftp.berlios.de/pub/cdrecord/alpha/
	with this patch : cdrtools-2.01a27-ossdvd.patch.bz2 from
			ftp://ftp.crashrecovery.org/pub/linux/cdrtools/

read command : 

   # readcd -v dev=ATAPI:0,0,0 f=dvdimage.iso

write command : 

   # cdrecord -v dev=ATAPI:0,0,0 driveropts=burnfree -dao dvdimage.iso

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

