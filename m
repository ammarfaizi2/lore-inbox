Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132419AbRAaBTG>; Tue, 30 Jan 2001 20:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132553AbRAaBS4>; Tue, 30 Jan 2001 20:18:56 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:16652 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S132419AbRAaBSm>;
	Tue, 30 Jan 2001 20:18:42 -0500
Message-ID: <3A776890.53BAFBCD@megapath.net>
Date: Tue, 30 Jan 2001 17:21:20 -0800
From: Miles Lane <miles@megapath.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OT: mount/umount doesn't track used resources correctly?
In-Reply-To: <Pine.LNX.4.21.0101221201420.1083-100000@antonia.wins.lbl.gov>			<3A6C9CE3.5B26923C@cern.ch> <m3puhfnrlc.fsf@austin.jhcloos.com>			<3A6CBE53.8050400@megapathdsl.net> <m3elxvnouk.fsf@austin.jhcloos.com>			<3A733E33.BEC2174E@cern.ch> <3A73F372.DAA5DFCD@snowbird.megapath.net>			<3A73FB0E.DB64D0C0@cern.ch> <m34ryjqefn.fsf@austin.jhcloos.com> <3A750DC4.2ACB4A9F@snowbird.megapath.net> <3A7530A0.8F3D6AEA@cern.ch> <3A77431E.9010605@megapathdsl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am having trouble removing the usbide module
which enables me to access my USB external 
hard drive.  I think the problem may be due
to usermode tools not handling the new "mount
multiple devices to a single mount point" feature,
but I'm not sure.

Here was my mount configuration for /dev/pda 
devices (the partitions on my USB BusLink drive)
before I unmounted all these partitions:

/dev/pda8              2016016        20   1913584   0% /mnt/pda8
/dev/pda8              2016016        20   1913584   0% /mnt/pda9
/dev/pda9              2016016        20   1913584   0% /mnt/pda9

Currently, mount shows:

/dev/hda7 on / type ext2 (rw)
none on /proc type proc (rw)
none on /dev/pts type devpts (rw,mode=0620)
/dev/hda8 on /home type ext2 (rw)
/dev/hda1 on /mnt/Win98 type vfat (rw,nosuid,nodev,umask=0)
none on /proc/bus/usb type usbdevfs (rw)

Any ideas?

        Miles
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
