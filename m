Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131392AbRANUsA>; Sun, 14 Jan 2001 15:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131966AbRANUrl>; Sun, 14 Jan 2001 15:47:41 -0500
Received: from proxy.class.de ([62.180.31.150]:11172 "EHLO proxy.class.de")
	by vger.kernel.org with ESMTP id <S131392AbRANUri>;
	Sun, 14 Jan 2001 15:47:38 -0500
Message-ID: <3A620C44.8030906@class.de>
Date: Sun, 14 Jan 2001 21:29:56 +0100
From: Martin Tessun <martin.tessun@class.de>
Organization: Class GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Maciaszek <mmaciaszek@gmx.net>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: vmware 2.0.3, kernel 2.4.0 and a cdrom
In-Reply-To: <20010114204948.A10017@nexus.shadowrun.not>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have the same problem. But if I say my CD-RW is the cdrom all works as 
expected (/dev/scd1).

Also the capabilities aren't correct I think:


Jan 14 21:26:31 worf kernel: sr0: scsi3-mmc drive: 0x/0x writer cd/rw caddy

for my CDROM; it is a TEAC-CDROM without caddy, but tray and has a 
read-speed of 42. It is NOT a writer.

The writer seems to be recognized correctly (again a TEAC-CDRW):

Jan 14 21:26:31 worf kernel: sr1: scsi3-mmc drive: 24x/24x writer cd/rw 
xa/form2 cdda tray

Only the write-speed isn't correct (it can only write 8x not 24x)

As I have no time in the moment to dig this down further, I just write 
this for information.

Btw I'm using kernel 2.4.0 with reiserfs and NVIDIA patch.

Bye
Martin 
 

Martin Maciaszek wrote:

> Since I installed Kernel 2.4.0 VMware is no longer able to
> recognize my cdrom drive. VMware shows a dialog box on power up
> with following content:
> [...]
> CDROM: '/dev/scd0' exists, but does not appear tobe a CDROM device.
> 
> Error connecting the CDROM device
> [...]
> 
> At the same time my syslog records the following message:
> Jan 13 21:49:57 nexus kernel: sr0: CDROM (ioctl) reports ILLEGAL REQUEST.
> 
> I tried 2.2.18 and VMware recognized the cdrom drive.
> 
> Any hints?
> 
> Cheers
> Martin


-- 
+-------------------------------------------------------------------------------
| MARTIN TESSUN               Telefon: 08151 / 991 - 257
| System Engineer             Telefax: 08151 / 991 - 259
| Class GmbH                  Mobil  : 0172  / 8363502
| Moosstrasse 7               eMail  : Martin.Tessun@class.de
| D-82319 Starnberg           URL    : http://www.class.de
+-------------------------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
