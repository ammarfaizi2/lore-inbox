Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266810AbTAOUEw>; Wed, 15 Jan 2003 15:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTAOUEw>; Wed, 15 Jan 2003 15:04:52 -0500
Received: from office-NAT.rockwellfirstpoint.com ([199.191.58.7]:36735 "EHLO
	ecsmtp01.rockwellfirstpoint.com") by vger.kernel.org with ESMTP
	id <S266810AbTAOUEv>; Wed, 15 Jan 2003 15:04:51 -0500
In-Reply-To: <OF4D4BDDD2.8FD534AB-ON86256C91.007B9286-86256C91.007EE995@LocalDomain>
Subject: Re: i845PE chipset and 20276 Promise Controller boot failure with 2.4.20-ac2
To: linux-kernel@vger.kernel.org
Cc: edward.kuns@rockwellfirstpoint.com
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OF29391214.90AE10FD-ON86256CAF.006DDF61-86256CAF.006F1CFE@rockwellfirstpoint.com>
From: edward.kuns@rockwellfirstpoint.com
Date: Wed, 15 Jan 2003 14:11:25 -0600
X-MIMETrack: Serialize by Router on ECSMTP01/EC/Rockwell(Release 5.0.11  |July 24, 2002) at
 01/15/2003 02:13:44 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI:  This problem is resolved at least as of 2.4.21-pre3-ac2.  I suspect
it is resolved as of 2.4.21-pre3 but I have not specifically tried that
load.  Specifically, I suspect it is the patch to drivers/pci/quirks.c that
Alan Cox posted on 16 December for people seeing IDE controllers but no
disks.  I *do* see output from the printk added in that patch:

      printk(KERN_INFO "PCI: Ignoring BAR%d-%d of IDE controller %s\n",
      first_bar, last_bar, dev->slot_name);

Alan, Andre, would it be useful to y'all for me to try any different kernel
versions between 2.4.18 and 2.4.21-pre3-ac2 to pin things down, or are
y'all satisfied with the information that 2.4.21-pre3 solves this problem?
Would it be useful if I forwarded the kernel printk's from the boot
process?

Reminder: This is a Gigabyte GA-8PE667 Ultra motherboard (aka P4 Titan 667
Ultra) with the i845PE chipset plus a Promise RAID controller (PDC20276).
I have a single hard drive (hde) as the master drive on the first channel
of the Promise controller and in the BIOS I have the Promise controller in
ATA mode, not RAID mode.  On the main IDE controller I have one hard disk
as the master on one channel (hda) and one CDROM as the slave on the other
channel (hdd).  (I know I should move the CDROM to be primary on that
channel but have been too lazy to pull the CDROM out to do this.)

Please CC me on any responses.

      Thanks

      Eddie

--
Edward Kuns
Technical Staff Member
Rockwell FirstPoint Contact
edward.kuns@rockwellfirstpoint.com
www.rockwellfirstpoint.com


