Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSFQMti>; Mon, 17 Jun 2002 08:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312681AbSFQMth>; Mon, 17 Jun 2002 08:49:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:8066 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312619AbSFQMtg>; Mon, 17 Jun 2002 08:49:36 -0400
Date: Mon, 17 Jun 2002 08:51:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Roberto Nibali <ratz@drugphish.ch>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Firewire Disks. (fwd)
In-Reply-To: <3D04EDC1.8010402@drugphish.ch>
Message-ID: <Pine.LNX.3.95.1020617081723.12517A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2002, Roberto Nibali wrote:

> Hi,
> 
> > I know there is support for "firewire" in the kernel. Is there
> > support for "firewire" disks? If so, how do I enable it?
> 
> Yes, there is and it is attached to the SCSI layer via the sbp2 driver. 
> You need following set of modules to get it working:
> 
> scsi_mod, sd_mod, ohci1394, raw1394, ieee1394, sbp2
> 
> I know that you will find out which options you need to enable in the 
> kernel config ;).
> 
> You might want to check out the CVS version of the ieee1394 drivers but 
> I don't think it is necessary. It works perfectly back here with a 
> Maxtor 160GB. Funny enough I had 158GB with the VFAT on it and 152GB 
> with ext2/ext3.
> 
> The speed results were also quite interessing:
> 
> VFAT writing     : 12.8 Mbyte/s
> ext2/ext3 writing: 19.2 Mbyte/s
> 
> I simply like that disk and it's a nice extension for a laptop :).
> 
> Cheers,
> Roberto Nibali, ratz

Well. I have been experimenting and a Firewire CD-R/W is found and
accessible. However, a 80 Gb Maxtor hard disk is not. I had to
copy from an RS-232C screen because the resounding crash(es) repeat
forever until I hit the reset switch. <EOL> == "end of line with
data missing after".


ohci1394: $Revision: 1.80 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9] MMIO=[febfd000-febfe000] Max
Packet=[ <EOL>
ieee1394: Device added: Node 0:1023, GUID 00063a0245003973
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io = 1)
ieee1394: sbp2: Node 0:1023: Max speed [S400] - Max payload [1024]
scsi2 : IEEE-1394 SBP-2 protocol driver
scsi: unknown type 24
  Vendor: GHIJKLMN  Model: OPQRSTUVWXYZ     Rev: "Unprintable junk"
  Type:   Unknown                           ANSI SCSI revision: 03
resize_dma_pool: unknown device type 24


Startup messages continue without further references to either SCSI
or IEEE1394. The crash occurs when my SCSI root-file system is first
referenced after initrd completes (pivot_root).

When this 80 Gb drive is used under W$, on the same machine, I see
no evidence of "GHIJKLMN" or "OPQRSTUVWXYZ" although the device-manager
doesn't let you read physical device info like it does with SCSI.

Number 24, shown above, is ^X, not part of the obvious
 "ABCDEFGHIJKLMNOPQRSTUVWXYZ" string that we see parts of above. So
it doesn't look like a read from the wrong offset during the device-
inquiry.


I'm using Linux-2.4.18. Maybe there is a more "mature" version
of sbp2 I should be using??


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

