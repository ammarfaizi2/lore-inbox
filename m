Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275989AbRI1M0s>; Fri, 28 Sep 2001 08:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276024AbRI1M0j>; Fri, 28 Sep 2001 08:26:39 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:55301 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP
	id <S275989AbRI1M0d>; Fri, 28 Sep 2001 08:26:33 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: safemode <safemode@speakeasy.net>
To: comandante@zaralinux.com,
        Jorge =?iso-8859-1?q?Ner=EDn?= <jnerin@juridicas.com>
Subject: Re: ide-scsi driver trouble in ac15
Date: Fri, 28 Sep 2001 08:26:58 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, gadio@netvision.net.il
In-Reply-To: <20010928040722Z275827-760+17888@vger.kernel.org> <3BB469E1.9090205@juridicas.com>
In-Reply-To: <3BB469E1.9090205@juridicas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010928122634Z275989-760+18106@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 September 2001 08:15, Jorge Nerín wrote:
> safemode wrote:
> >I'm not entirely sure if this is ac15's fault or the preempt patch acting
> > up. But this is very ide-scsi centric so i'm leaning towards ac15.  I
> > burned a cd using my ide writer and it worked fine.  Then i went to burn
> > another and the drive went into an infinite reset loop.  like this.
> >	SCSI bus is being reset for host 0 channel 0.
> >	scsi0 : channel 0 target 0 lun 0 request sense failed, performing reset.
> >
> >reloading the modules does nothing but report this error.
> >	SCSI subsystem driver Revision: 1.00
> >	scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> >	scsi0 : channel 0 target 0 lun 0 request sense failed, performing reset.
> >	SCSI bus is being reset for host 0 channel 0.
> >
> >Even though the modules were removed, the drive led is still blinking like
> > it was writing.  If anyone needs some more info i'll try and get it. the
> > cdr did detect and work correctly at boot.
> >
> >hardware:
> >    Promise ide controller :
> >	PDC20262: chipset revision 1
> >	PDC20262: not 100% native mode: will probe irqs later
> >	PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
> >    CDR:
> >	hde: CREATIVE CD-RW RW8438E, ATAPI CD/DVD-ROM drive
> >	SCSI subsystem driver Revision: 1.00
> >	scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> >  	Vendor: CREATIVE  Model:  CD-RW RW8438E    Rev: FC03
> >  	Type:   CD-ROM                             ANSI SCSI revision: 02
> >software:
> >    Cdrecord 1.10 (i686-pc-linux-gnu) Copyright (C) 1995-2001 Jörg
> > Schilling linux-2.4.9-ac15-preempt-fix
>
> It also happened to me with ac10, ide-scsi, CD-RW is a Samsung 8x, and I
> was writing a audio cd, when it finished writing the track 8 of 18 it
> entered the loop, since then I couldn't eject the cd, neither eject
> /dev/hdb, nor cdrecord -eject, nor the eject button, I had to reboot.
>
> My system is a 2x200mmx smp all ide.
Seems to be an interesting coincidence, i had just written an audio cd and 
was writing another when it happened. Only it happened to me when just 
beginning the cd.  Had to reboot. The cd was fine, it never actually got to 
writing, so i used it after i  had rebooted the system and it worked fine.  
