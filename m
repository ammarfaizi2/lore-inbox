Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129913AbRAPVEX>; Tue, 16 Jan 2001 16:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131940AbRAPVEN>; Tue, 16 Jan 2001 16:04:13 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:13551 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129913AbRAPVEC>; Tue, 16 Jan 2001 16:04:02 -0500
Date: Tue, 16 Jan 2001 15:04:01 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <3A64A6EF.7851AE1E@nortelnetworks.com>
In-Reply-To: Message from Brian Gerst <bgerst@didntduck.org> of "Tue,             16 Jan 2001 12:04:57 EST." <3A647F39.EC62BB81@didntduck.org> 
	<20010116182307Z131259-403+875@vger.kernel.org>
Subject: Re: Linux not adhering to BIOS Drive boot order?
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-Id: <20010116210404Z129913-403+920@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from "Christopher Friesen" <cfriesen@nortelnetworks.com> on
Tue, 16 Jan 2001 14:54:23 -0500


> > The Mac never enumerates its devices like the PC does (no C: D: etc, no
> > /dev/sda, /dev/sdb, or anything like that).  It also remembers the boot device
> > in its EEPROM (the Startup Disk Control Panel handles this).
> 
> Are you sure about that?  According to my documentation on installing linux on a G4
> with scsi disks, you need to specify a device enumeration string like the following
> to tell the system where to look for the boot device:
> 
> /pci@f2000000/pci-bridge@d/ATTO,ExpressPCIProUL2D@4,1/@6:5
> 
> where the '6' is the SCSI ID of the drive, and the '5' is the partition number of the
> boot partition.  So if you change SCSI IDs or add a new partition and change the
> partition numbering of the drive, your computer can't boot anymore.

I was talking about a Mac running Mac OS.  I've tried change the SCSI ID of the
boot device, but this discussion was about adding devices.  On a Mac, I've
always been able to add devices, whether they be on an exiting SCSI or IDE bus,
or on a new bus, and not worry about the machine not booting.

I can't same the same about the PC.  Overall, the PC is just much more
sensitive to device changes than Macs are.  And I think it's because the Mac
BIOS and OS are just designed to handle this better.  The PC BIOS never had any
provision for a third-party boot device to annouce itself.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
