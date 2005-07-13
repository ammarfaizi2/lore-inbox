Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVGMXfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVGMXfv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 19:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVGMXdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 19:33:55 -0400
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:31573 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262341AbVGMXcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 19:32:45 -0400
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: hdaps-devel@lists.sourceforge.net
Subject: Re: [Hdaps-devel] Updating hard disk firmware & parking hard disk
Date: Wed, 13 Jul 2005 19:32:35 -0400
User-Agent: KMail/1.8.1
Cc: Gijs Hillenius <gijs@hillenius.net>, Frank Sorenson <frank@tuxrocks.com>,
       linux-kernel@vger.kernel.org
References: <20050707171434.90546.qmail@web32604.mail.mud.yahoo.com> <42CD7E0C.3060101@tuxrocks.com> <878y0bozf8.fsf@hillenius.net>
In-Reply-To: <878y0bozf8.fsf@hillenius.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507131932.35560.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Perhaps you also need to flash the BIOS and or Embedded Controller firmware?

Shawn.

On July 13, 2005 04:58, Gijs Hillenius wrote:
> >>>>> Frank Sorenson writes:
>      > Martin Knoblauch wrote:
>      >
>     >> Download is simple, just don't use the "IBM Download
>     >> Manager". Main problem is that one needs a bootable floopy
>     >> drive and "the other OS" to create a bootable floppy. It would
>     >> be great if IBM could provide floppy images for use with "dd"
>     >> for the poor Linux users.
>     >>
>      > You may be able to use this process to avoid using either a
>      > floppy drive or "the other OS":
>      >
>      > 1) Download the appropriate firmware exe from
>      > http://www-306.ibm.com/pc/support/site.wss/document.do?lndocid=MIGR-
>      >41008 (in my case, this looks like fwhd3313.exe)
>      >
>      > 2) Find a freedos disk image (I used one that came with
>      > biosdisk - http://linux.dell.com/biosdisk/)
>      >
>      > 3) Create a disk image for the firmware executable: cp
>      > /usr/share/biosdisk/dosdisk.img /tmp/fwdisk1.img mount -oloop
>      > /tmp/fwtemp.img /mnt/tmp cp fwhd3313.exe /mnt/tmp umount
>      > /mnt/tmp
>      >
>      > 4) Create a blank disk image for the extracted contents: dd
>      > if=/dev/zero of=/boot/fwdisk.img bs=1474560 count=1
>      >
>      > 5) Run qemu to extract files and write the disk image: qemu
>      > -fda /tmp/fwtemp.img -fdb /boot/fwdisk.img A:\>fwhd3313 ...
>      > exit qemu
>      >
>      > 6) Set up grub to boot the new disk image (requires memdisk
>      > from syslinux - http://syslinux.zytor.com/): $EDITOR
>      > /boot/grub/grub.conf title IBM Hard Drive Firmware update
>      > kernel /memdisk initrd=/fwdisk.img floppy
>      >
>      > 7) Reboot and select the "IBM Hard Drive Firmware update"
>      > option
>      >
>      >
>      > It allowed me to run the firmware update program, however it
>      > didn't believe my drive needed updating, so I haven't even
>      > successfully tried the entire process.  Please let me know if
>      > it works for you.
>      >
>      > DISCLAIMER: I also provide no guarantees.  Hopefully your hard
>      > disk won't fly off the spindle or anything else bad.  If it
>      > does, blame someone else.
>
> Hi Frank,
>
> FYI I succesfully used your above method to update the firmware
> for the IC25N040ATMR04-0 hard disk that came with my Thinkpad R51.
>
> Before the update hdparm -i /dev/hda
> Model=IC25N040ATMR04-0, FwRev=MO2OAD4A
>
> and after the update
> Model=IC25N040ATMR04-0, FwRev=MO2OADEA
>
> So, thanks!
>
> however, the firmware update did not solve the 'head not park'
> issue. :-(
>
> sudo ./park /dev/hda
> head not parked 4c
>
>
> Regards
>
> Gijs
