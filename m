Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRAOSv7>; Mon, 15 Jan 2001 13:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129632AbRAOSvj>; Mon, 15 Jan 2001 13:51:39 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:30762 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S129485AbRAOSv1>;
	Mon, 15 Jan 2001 13:51:27 -0500
Message-ID: <20010115195131.A17484@win.tue.nl>
Date: Mon, 15 Jan 2001 19:51:31 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: David Balazic <david.balazic@uni-mb.si>, linux-kernel@vger.kernel.org
Subject: Re: Disk geometry changed after running linux
In-Reply-To: <3A633EF6.44E5A2C@uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A633EF6.44E5A2C@uni-mb.si>; from David Balazic on Mon, Jan 15, 2001 at 07:18:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2001 at 07:18:30PM +0100, David Balazic wrote:

> Then I installed linux ( "some" beta version , kernel
> is some recent 2.4.0-testXX )
> 
> After the installation the disk ( win2000 ) would not boot.
> It reports :
> Read error on disk.
> Press ctrl+alt+del to reboot.
> 
> If I run linux ( it work OK from the boot floppy ),
> it reports the geometry as 3xxxx/??/??.
> Thirty thousand and some cylinders , H and S are probably 16/63
> ( don't have it at hand ).
> 
> It should be two thousand something and 255/63, I think.
> 
> fdisk -l /dev/hda prints "Partition 1 does not end on cylinder boundary"
> messages for the NTFS partitions ( hda1 and hda5 ). The linux ones are
> OK.
> 
> The problem is that now the BIOS sets Access mode to LARGE.
> I can workaround it by changing access mode in BIOS setup
> from AUTO to LBA, but I want to know what made BIOS to default to
> LARGE and how to fix it.

Since "disk geometry" has become such a terrible mess,
recent BIOSes decide that they don't know what the geometry
should be, and guess the geometry from the partition table,
if there is one.

So, if you added partitions during the install then it is
not impossible that the BIOS changed its mind concerning
the geometry.

It would be interesting to see the precise partition table
(output of "fdisk -l /dev/hda").


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
