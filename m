Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135186AbRDZIUb>; Thu, 26 Apr 2001 04:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135193AbRDZIUW>; Thu, 26 Apr 2001 04:20:22 -0400
Received: from pD9575938.dip.t-dialin.net ([217.87.89.56]:61714 "EHLO
	ntlinux1.mtg-marinetechnik.de") by vger.kernel.org with ESMTP
	id <S135186AbRDZIUG>; Thu, 26 Apr 2001 04:20:06 -0400
Message-ID: <3AE7DA33.5D06D159@gmx.net>
Date: Thu, 26 Apr 2001 10:20:03 +0200
From: Richard Ems <r.ems.mtg@gmx.net>
Reply-To: r.ems@gmx.net
Organization: MTG - Marinetechnik GmbH
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en, de-DE, es, pt-BR, it
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sr1: CDROM (ioctl) reports ILLEGAL REQUEST.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

While burning a cdrom, xcdroast 0.98alpha8 hanged up. After killing it,
the cdwriter doesn't respond to any commands and the tray door doesn't
open anymore.
The cdwriter isn't mounted (df output and cat /proc/mounts).

output from eject -v /dev/scd1:

eject: device name is `/dev/scd1'
eject: expanded name is `/dev/scd1'
eject: `/dev/scd1' is not mounted
eject: `/dev/scd1' is not a mount point
eject: `/dev/scd1' is not a multipartition device
eject: trying to eject `/dev/scd1' using CD-ROM eject command
eject: CD-ROM eject command failed
eject: trying to eject `/dev/scd1' using SCSI commands
eject: SCSI eject failed
eject: trying to eject `/dev/scd1' using floppy eject command
eject: floppy eject command failed
eject: trying to eject `/dev/scd1' using tape offline command
eject: tape offline command failed
eject: unable to eject, last error: Invalid argument


vanilla linux 2.2.19 SMP (2x700 Mhz Pentium III Coppermine, 512 MB)
SuSE 7.1 distro

output from scsi_inquiry /dev/sr1:
PLEXTOR   CD-R   PX-W1210S  1.01, byte_7=0x18

in /var/log/messages:
kernel: sr1: CDROM (ioctl) reports ILLEGAL REQUEST.


Can I somehow do a scsi reset or anything to be able to use again the
cdwriter whitout rebooting?
Why did this happen?

Thanks, Richard

Please CC to my address since I'm not on the linux-kernel list.



--
   Richard Ems
   ... e-mail: r.ems.mtg@gmx.net
   ... Computing Science, University of Hamburg

   Unix IS user friendly. It's just selective about who its friends are.
