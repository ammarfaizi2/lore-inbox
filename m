Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbTD2BvY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 21:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbTD2BvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 21:51:24 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:23312
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261462AbTD2BvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 21:51:22 -0400
Date: Mon, 28 Apr 2003 18:58:51 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Tabris <tabris@sbcglobal.net>
cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.21-rc1-ac2 Promise IDE DMA won't work
In-Reply-To: <200304282112.47061.tabris@sbcglobal.net>
Message-ID: <Pine.LNX.4.10.10304281855540.20264-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


NO ATAPI DMA!

I will not write the driver core to attempt to support the various
combinations.  The ATAPI DMA engine space is used support 48bit.
Use the onboard controller for ATAPI.



On Mon, 28 Apr 2003, Tabris wrote:

> I looked thru marc's archives, and i'm not finding anything specific to 
> this problem, tho I do believe it is probably a known issue.
> 
> ASUS A7v266-E
> PDC20265
> LITE-ON LTR-32123S
> 
> only device on the Promise IDE is the cd-rw drive. have four hard drives 
> on the VIA IDE.
> 
> running kernel 2.4.21-rc1-ac2 + preempt + rmap15g + i2c-sensors
> 
> burning now works using cdrecord ATAPI (previous was 2.4.21-pre5-ac3 
> where the ide-scsi was too unstable)
> 
> at present, reading the cd drive takes 80+% of CPU system time...
> 
> I would like to be able to enable DMA. i tried doing it manually with 
> hdparm. enabling 32-bit IO or enabling DMA would both make it just not 
> work.
> [root@tabriel root]# hdparm /dev/hdg
> 
> /dev/hdg:
>  HDIO_GET_MULTCOUNT failed: Invalid argument
>  IO_support   =  0 (default 16-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  0 (off)
>  keepsettings =  0 (off)
>  readonly     =  1 (on)
>  readahead    =  8 (on)
>  HDIO_GETGEO failed: Invalid argument
> [root@tabriel root]#
> [root@tabriel root]# hdparm -I /dev/hdg
> 
> /dev/hdg:
> 
> ATAPI CD-ROM, with removable media
>         Model Number:       LITE-ON LTR-32123S
>         Serial Number:
>         Firmware Revision:  XS0R
> Standards:
>         Used: ATAPI for CD-ROMs, SFF-8020i, r2.5
>         Supported: CD-ROM ATAPI-2
> Configuration:
>         DRQ response: 50us.
>         Packet size: 12 bytes
> Capabilities:
>         LBA, IORDY(cannot be disabled)
>         DMA: *mdma0 mdma1 mdma2 udma0 udma1 udma2
>              Cycle time: min=120ns recommended=120ns
>         PIO: pio0 pio1 pio2 pio3 pio4
>              Cycle time: no flow control=227ns  IORDY flow control=120ns
> [root@tabriel root]#
> 
> 
> any more info needed, just ask. any help much appreciated.
> 
> 
> -- 
> "Ignorance is the soil in which belief in miracles grows."
> -- Robert G. Ingersoll
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

