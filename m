Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292730AbSEHHML>; Wed, 8 May 2002 03:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293457AbSEHHMK>; Wed, 8 May 2002 03:12:10 -0400
Received: from khms.westfalen.de ([62.153.201.243]:12419 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S292730AbSEHHMK>; Wed, 8 May 2002 03:12:10 -0400
Date: 08 May 2002 08:57:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Message-ID: <8OSr1ajHw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.44.0205071142001.1067-100000@home.transmeta.com>
Subject: Re: [PATCH] 2.5.14 IDE 56
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 07.05.02 in <Pine.LNX.4.44.0205071142001.1067-100000@home.transmeta.com>:

> If you have /dev/hda1, that _cannot_ be a symlink to the physical tree,
> because on a physical level that partition DOES NOT EXIST. It's purely a
> virtual mapping.

Well ... one *could* argue that there's justification for showing those  
partitions by the exact same argument that there's reason to show devices  
on a SCSI or USB bus. It's just going further down the tree.

Say something like

        /driverfs/root/pci0/00:1f.4/scsi_bus/003/pc_partition/2

Sure, it's software, not hardware. OTOH, it's one of the things that  
change with hotplug. (And incidentally, fdisk changing partitions *might*  
be handled somewhat like a hotplug event ...)

As to linking to /dev, I see no reason why you couldn't have that tree  
include information (not in the tree *structure*, obviously) of what the  
relevant device numbers are. That's more expensive than a lookup with a  
pointer gotten from /dev, but it's certainly possible.

MfG Kai
