Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131149AbRAQXVC>; Wed, 17 Jan 2001 18:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131310AbRAQXUw>; Wed, 17 Jan 2001 18:20:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24842 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131149AbRAQXUf>;
	Wed, 17 Jan 2001 18:20:35 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101172319.XAA01099@raistlin.arm.linux.org.uk>
Subject: Re: Linux not adhering to BIOS Drive boot order?
To: adilger@turbolinux.com (Andreas Dilger)
Date: Wed, 17 Jan 2001 23:19:23 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse),
        adilger@turbolinux.com (Andreas Dilger),
        Venkateshr@ami.com (Venkatesh Ramamurthy),
        hbryan@us.ibm.com ('Bryan Henderson'), linux-kernel@vger.kernel.org
In-Reply-To: <200101171012.f0HACMM04543@webber.adilger.net> from "Andreas Dilger" at Jan 17, 2001 03:12:22 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:
> Same thing, really.  You have to poke each drive to get the serial
> number.  What if they are IDE or SCSI or FCAL or RAID array?  Probably
> reading a block from a disk is safer than trying to find the drive
> serial number.

If you apply the "read block from disk" method to a RAID1 array, how
you do you know whether you mean:

1) An active disk in the array
2) The actual array itself.

Hint: With Raid 1, the disks are complete images of each other.  You can
mount a single disk which is/was part of a raid 1 array and read all data
off it.

If someone thinks about going down this road, make sure you check the
multiple-device arrays BEFORE the physical disks!
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
