Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132886AbRDJAQN>; Mon, 9 Apr 2001 20:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132887AbRDJAQD>; Mon, 9 Apr 2001 20:16:03 -0400
Received: from light.kappa.ro ([194.102.249.27]:64783 "EHLO light.kappa.ro")
	by vger.kernel.org with ESMTP id <S132886AbRDJAPx>;
	Mon, 9 Apr 2001 20:15:53 -0400
Message-ID: <001901c0c15a$a47bfb60$e8c6e7c1@hybrid>
From: "Alexandru Barloiu Nicolae" <axl@light.kappa.ro>
To: "Mark Hahn" <hahn@coffee.psychology.mcmaster.ca>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10104091936150.21780-100000@coffee.psychology.mcmaster.ca>
Subject: Re: Compaq proliant ML-350 - IDE & SCSI
Date: Tue, 10 Apr 2001 03:07:01 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.4-p1 is the kernel version that i've tried now. no succes with 2.4.3 and
below.

i've been trying without the CDROM and a normal HDD ata 66. i've made some
progress using the normal ide ata 66 driver and removing the osv4 from
kernel.

root@light:/# hdparm -t -T /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.81 seconds =158.02 MB/sec
 Timing buffered disk reads:   MB in  8.41 seconds =  7.61 MB/sec
root@light:/# hdparm -v /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2586/240/63, sectors = 39102336, start = 0

still my bios is set to enhaced DMA. i am still working on UDMA. if u have
any suggestions i still wait for a solution.

axl

----- Original Message -----
From: "Mark Hahn" <hahn@coffee.psychology.mcmaster.ca>
To: "Alexandru Barloiu Nicolae" <axl@light.kappa.ro>
Sent: Tuesday, April 10, 2001 1:39 AM
Subject: Re: Compaq proliant ML-350 - IDE & SCSI


> > ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
>
> ugh.  not a widely-respected implementation.  I don't think you mentioned
> which kernel you're runnint, either, since there have been several
successive
> generations of workarounds for SW ide/etc stuff.
>
> > hda: WDC WD200EB-00BHF0, ATA DISK drive
> > hdb: Compaq CRD-8402B, ATAPI CD/DVD-ROM drive
>
> sharing a channel like this is not a good idea.  you should definitely
> test without the cdrom drive.  all your ide cables are 18" or less?
>

