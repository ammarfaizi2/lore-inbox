Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934632AbWKXOzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934632AbWKXOzF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 09:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934633AbWKXOzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 09:55:04 -0500
Received: from mpemail.mpe-garching.mpg.de ([130.183.137.110]:29353 "EHLO
	mpemail.mpe.mpg.de") by vger.kernel.org with ESMTP id S934632AbWKXOzA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 09:55:00 -0500
From: "Martin A. Fink" <fink@mpe.mpg.de>
Organization: MPE
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: SATA Performance with Intel ICH6
Date: Fri, 24 Nov 2006 15:54:58 +0100
User-Agent: KMail/1.8
References: <200611241407.01210.fink@mpe.mpg.de> <200611241510.11526.fink@mpe.mpg.de> <20061124143040.679016d5@localhost.localdomain>
In-Reply-To: <20061124143040.679016d5@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611241554.58575.fink@mpe.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 24. November 2006 15:30 schrieben Sie:
> On Fri, 24 Nov 2006 15:10:11 +0100
> "Martin A. Fink" <fink@mpe.mpg.de> wrote:
> 
> > Well this seems to be independend from the file system. I tried to write 
> > directly to the raw device, but nevertheless the cpu time was 20% (sys 
time).
> 
> sys time is not neccessarily CPU time.
>  
> > This is an interessting point. The specification say that I can handle 
around 
> > 120 to 150 MB/s each of the 4 S-ATA ports. With ICH6 the S-ATA ports seem 
to 
> 
> At once ?
> 
> > be directly connected to the Southbridge, and the Southbridge is directly 
> > connected to Northbridge via PCI Express. So it should be possible to get 
150 
> > MB/s from north to south and from there in packages of 55 MB/s to the 
> > disks ?!
> 
> Ask the vendor.
>  
> > <6>scsi1 : ata_piix
> > <5>  Vendor: ATA       Model: WDC WD740GD-75FL  Rev: 21.0
> > <5>  Type:   Direct-Access                      ANSI SCSI revision: 05
> 
> The PIIX interface needs CPU intervention each command, so in practice
> about every 64K or so, and the CPU gets stalled waiting for the disk
> during the setup of each I/O. The newer kernels support AHCI which does
> not have this overhead, but it is only present on the newest intel
> controllers.

Can you tell me the name of this controllers? Is it ICH7 or 8 ?
What kernel versions?

Thank you very much
> 
> > and strace dd... gives among other information
> > 6.84s 1004calls syscall: write
> > 
> > So I spend 45s of 52s within the kernel. Why so long?
> 
> Waiting for the disk I would imagine.
> 
> Alan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Dipl. Physiker
Martin Anton Fink
Max Planck Institute for extraterrestrial Physics
Giessenbachstrasse
85741 Garching
Germany
Tel. +49-(0)89-30000-3645
Fax. +49-(0)89-30000-3569
