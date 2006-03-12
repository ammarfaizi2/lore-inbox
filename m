Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWCLTr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWCLTr0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 14:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWCLTr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 14:47:26 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:13198 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932125AbWCLTrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 14:47:25 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE CDROM - No DMA
Date: Sun, 12 Mar 2006 14:47:26 -0500
User-Agent: KMail/1.9.1
Cc: Chris Boot <bootc@bootc.net>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
References: <200603101842.09251.kernel-stuff@comcast.net> <1142186580.20056.5.camel@localhost.localdomain> <200603121429.06372.kernel-stuff@comcast.net>
In-Reply-To: <200603121429.06372.kernel-stuff@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603121447.26252.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 March 2006 14:29, Parag Warudkar wrote:
> Funny situation - I cannot figure what my root device is. Earlier without
> the patch it was /dev/sda3 and now I try everything (hda3, hdb3, hdc3,
> hdd3, sda3, sdb3...) but it panics - not able to mount rootfs.
Never mind - I am dumb enough to not realize I needed SCSI Disk in built or as 
modules copied over to proper place :)

It boots but I don't think DMA is in effect on the CDROM drive though - (I get  
3Mb/s transfer speeds from it.  LS of a 1500 file directory is too slow).  
dmesg says ata2  configured for UDMA/33 but doesn't seem like it has 
actually.

Memory: 2065588k/2087756k available (2495k kernel code, 21676k reserved, 722k 
data, 216k init, 0k highmem)
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05-ac7
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
ata1: dev 0 cfg 49:2f00 82:746b 83:7f09 84:6023 85:7469 86:3e09 87:6023 
88:203f
ata1: dev 0 ATA-6, max UDMA/100, 153356490 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xBFA8 irq 15
ata2: dev 0 cfg 49:0f00 82:0210 83:4011 84:4000 85:0000 86:0001 87:4000 
88:0407
ata2: dev 0 ATAPI, max UDMA/33
ata2(0): applying bridge limits
ata2: dev 0 configured for UDMA/33
scsi1 : ata_piix
EXT3-fs: mounted filesystem with ordered data mode.

Hard disk is fine - gives around 31 Mb/S. 

Parag
