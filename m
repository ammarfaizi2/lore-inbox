Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291966AbSBNXFT>; Thu, 14 Feb 2002 18:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291970AbSBNXFI>; Thu, 14 Feb 2002 18:05:08 -0500
Received: from portal.mwk.co.nz ([202.27.222.130]:34187 "EHLO
	fileserver.mwk.co.nz") by vger.kernel.org with ESMTP
	id <S291969AbSBNXE6>; Thu, 14 Feb 2002 18:04:58 -0500
Subject: Need to force IDE geometry
From: John Huttley <john@mwk.co.nz>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Hugo Rabson <hugo@firstlinux.net>, Andre Hedrick <andre@linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 15 Feb 2002 12:04:44 +1300
Message-Id: <1013727888.13272.51.camel@fileserver.mwk.co.nz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have a problem with the way the kernel handles geometry.

AFAIK, if a disk has partitions which were created in LBA mode,
the kernel automagically puts the disk into LBA mode. (good)

If the disk has no partitions.. then
	If its the first disk it will be in LBA mode (good)
Else it will be in CHS mode. (ungood)

There seems to be no way to tell the kernel to put the second disk into
LBA mode. Sure, you can force the geometry as a boot option, but that is
not the same as putting it in LBA mode.

Any bios settings to put the disk into LBA are ignored by the kernel.


This causes problems when installing a RAID enabled linux onto a
dual IDE system. RedHat 7X suffers this and so does the Mondo Rescue
restore system. It makes it very difficult to setup 2 disks so they are
of identical geometry. Trust me, its a PINA.

Are there any ioctl's controlling this?
Can we create a boot option? Or simply read the bios setting? Or just
default to LBA rather than CHS?

Any help gratefully received.
As I'm not on this list, would you please CC me.

Regards

John



