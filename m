Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317596AbSFMMrN>; Thu, 13 Jun 2002 08:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317599AbSFMMrM>; Thu, 13 Jun 2002 08:47:12 -0400
Received: from chaos.analogic.com ([204.178.40.224]:48773 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317596AbSFMMrL>; Thu, 13 Jun 2002 08:47:11 -0400
Date: Thu, 13 Jun 2002 08:48:53 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Roberto Nibali <ratz@drugphish.ch>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Firewire Disks. (fwd)
In-Reply-To: <3D04EDC1.8010402@drugphish.ch>
Message-ID: <Pine.LNX.3.95.1020613083727.1225A-100000@chaos.analogic.com>
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
> -- 

The firewire stuff apparently doesn't work too well on linux-2.4.18
I have 3 SCSI disks plus a SCSI CD-R/W. The Adaptec Firewire controller
has a 80 gig disk plus another CD-R/W attached. Both of these run fine
(but slow) in W$.


When I `insmod sbp2.o`, I get a signon message showing two CD-R/W drives,
and no Disk. I can't find any 'devices' to access or mount. I thought,
maybe, that the CD-R/W should show up as the next SCSI CD-R/W, i.e.,
/dev/scd1. If I do `od -x /dev/sdc1` (to see if its readable), the
machine panics. The panic isn't anything that can be copied as it scrolls
for about 10 seconds and end up with:

	code : : : : : : : : :

	(not too useful).  Nothing gets written to the root file-system,
not even the signon-message when I inserted the module.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

