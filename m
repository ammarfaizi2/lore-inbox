Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131876AbRAPUER>; Tue, 16 Jan 2001 15:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131936AbRAPUEH>; Tue, 16 Jan 2001 15:04:07 -0500
Received: from h57s242a129n47.user.nortelnetworks.com ([47.129.242.57]:46553
	"EHLO zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S131848AbRAPUD6>; Tue, 16 Jan 2001 15:03:58 -0500
Message-ID: <3A64A6EF.7851AE1E@nortelnetworks.com>
Date: Tue, 16 Jan 2001 14:54:23 -0500
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; HP-UX B.10.20 9000/778)
X-Accept-Language: en
MIME-Version: 1.0
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: Message from Brian Gerst <bgerst@didntduck.org> of "Tue,
            16 Jan 2001 12:04:57 EST." <3A647F39.EC62BB81@didntduck.org> <20010116182307Z131259-403+875@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@americasm01.nt.com>
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi wrote:
 
> And this is a problem that has plagues all PC operating systems, but has never
> been a problem on the Macintosh.  Why?  Because the Mac was designed to handle
> this problem, but the PC never was.
> 
> The Mac never enumerates its devices like the PC does (no C: D: etc, no
> /dev/sda, /dev/sdb, or anything like that).  It also remembers the boot device
> in its EEPROM (the Startup Disk Control Panel handles this).

Are you sure about that?  According to my documentation on installing linux on a G4
with scsi disks, you need to specify a device enumeration string like the following
to tell the system where to look for the boot device:

/pci@f2000000/pci-bridge@d/ATTO,ExpressPCIProUL2D@4,1/@6:5

where the '6' is the SCSI ID of the drive, and the '5' is the partition number of the
boot partition.  So if you change SCSI IDs or add a new partition and change the
partition numbering of the drive, your computer can't boot anymore.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
