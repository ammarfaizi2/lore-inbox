Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285940AbRLTDXD>; Wed, 19 Dec 2001 22:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285937AbRLTDWz>; Wed, 19 Dec 2001 22:22:55 -0500
Received: from svr3.applink.net ([206.50.88.3]:57099 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S285940AbRLTDWn>;
	Wed, 19 Dec 2001 22:22:43 -0500
Message-Id: <200112200322.fBK3MVSr013812@svr3.applink.net>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Jean-Francois Levesque <jfl@jfworld.net>
Subject: Re: UDMA problem with Maxtor 7200rpm disk
Date: Wed, 19 Dec 2001 21:18:51 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011219151636.50e930ac.jfl@jfworld.net> <20011219203804.4c68f1ee.jfl@jfworld.net> <20011219214341.66b6b83e.jfl@jfworld.net>
In-Reply-To: <20011219214341.66b6b83e.jfl@jfworld.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 December 2001 20:43, Jean-Francois Levesque wrote:
> I tried the 2.4.17-rc2 kernel and I was able to boot. (but I'm not with
> 2.4.9, 2.4.12-ac5 and 2.4.16)
>
> Unfortunately, when I try hdparm -d1 /dev/hda, I get the same errors
>
> hda: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
> hda: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
> hda: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
> hda: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
> hda: DMA disabled
> ide0: reset: success
>
>
> What can influence the DMA on the BIOS else than the disk configuration?
>
> I always get this PCI bus warning :
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>
> Maybe I have somthing wrong with PCI bus that change everything???
>
> Jean-François
>
> PS: I have the lastest asus BIOS update (1003).
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Three things occur to me:

1. I had a Maxtor disk (of many good ones) which died one month
before its warranty ran out.  I just sent it back to Maxtor for a replacement.

2. The PCI bus runs at 33 MHz unless, 
	a) You have a server running at 66 MHz
	b) You overclock your system.

3. From your earlier post, I wasn't sure  if you understood PIO/DMA.
Original disks used Programmed Input/Output to increase throughput.
PIO Modes increase from 1 to 2 to 3 to 4.  And them the Direct Memory
Access method gained acceptance and resulted in better throughput.
DMA2 is good, DMA4 is great and DMA5 is the best of the best as
of today.


Just my $0.02.

-- 
timothy.covell@ashavan.org.
