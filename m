Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbTFBOEJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 10:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbTFBOEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 10:04:09 -0400
Received: from amiel.mardelplata.sinectis.com.ar ([216.244.221.2]:18450 "EHLO
	amiel.mardelplata.sinectis.com.ar") by vger.kernel.org with ESMTP
	id S262341AbTFBOEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 10:04:07 -0400
From: =?iso-8859-1?Q?Agust=EDn?= Herrera <aherrera@datafull.com>
To: linux-kernel@vger.kernel.org
Cc: dgilbert@interlog.com
Subject: Re: Problems with scsi emulation
References: <3EDAD8AA.50503@interlog.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 2.0.6
X-Mutt-Fcc: file:///home/agustin/mail/sentbox
Date: Tue, 13 Jan 1970 03:22:13 -0300
Message-Id: <1054563475.0@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I'm using a customized 2.4.20 kernel (red hat 9) with
> > scsi emulation, scsi  cdrom & scsi generic support
> > options enabled in .config and hdx-ide-scsi in
> > lilo.conf. apps as cdrecord or cdrdao take up all my
> > cpu time (I have a duron 1.1 gz, kt133, 192mb sdram,
> > 30 gb 5400 rpm hd). in windows (with dma enabled) Nero d
> > oesn't take up any (or almost) cpu time...
> > is this an issue of the linux-kernel or a configuration
> > problem?
> 
> Due to many problems with DMA locking up on ATAPI writers
> earlier in the lk 2.4 series, Linux takes a very
> conservative approach and turns off DMA.
> It can be turned back on with:
>  # hdparm -d 1 /dev/hdb
> assuming your cdwriter is found at /dev/hdb (even
> though the ide-scsi driver "owns" that device
> and you address it as /dev/scd0 ). You can get
> faster DMA modes with the addition of the "-X"
> switch in hdparm but that should not be necessary.
> 
Doug:

I've tried that, but it doesn't make any difference.

I've been able to do ficticious tweaks on /dev/hdc and hdd like, for 
example, activating dma mode 5 -which is virually impossible for a 
cdrom drive. Actually, as I'd disabled ide/atapi-cdrom support in the 
kernel I guess that /dev/hdc & hdd point to 'nowhere'. Anyway, with 
hdparm optimizations or without them processor time consumption remains 
at a 70 - 90 % so, clearly, I haven't made any progress.

The only interface for cdrom drives that i've enabled in the kernel is 
scsi (to be able to record and rip w/ cdrdao). I guess that the 
inability to use dma is related to that because my ide hard disks seem 
to be using it w/o problems (and obviously I'm not using scsi with 
them). Nevertheless, I can't set up a multcount higher than 8, which is 
really surprising because the ide chipset and the drives are quite new.

So I repeat my enquiry, Is all this a question configuration or of a 
kernel upgrade? I've already tried the latter, but, as far as I could 
appreciate, the current nvidia 'accelerated' drivers (1.0-4363) for my 
geforce2 didn't work with the 2.5 kernel (more precisely 2.5.69) I'd 
compiled. Once more, is this incompatibility a current issue of these 
kernels? In case it were an configuration error I would certainly do 
the upgrade because 2.5 kernel series seem to have many advantages, as 
for example, the inclusion of the alsa sound drivers.

Agustín Herrera

PD: I've changed my adress to aherrera@datafull.com
