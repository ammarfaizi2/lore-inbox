Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAOSzT>; Mon, 15 Jan 2001 13:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129632AbRAOSzK>; Mon, 15 Jan 2001 13:55:10 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:59652 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S129431AbRAOSy6>;
	Mon, 15 Jan 2001 13:54:58 -0500
Date: Mon, 15 Jan 2001 19:54:47 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Disk geometry changed after running linux
To: Guest section DW <dwguest@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Message-id: <3A634777.48A41C82@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
Content-type: text/plain; charset=iso-8859-2
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <3A633EF6.44E5A2C@uni-mb.si> <20010115195131.A17484@win.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Guest section DW wrote:
> 
> On Mon, Jan 15, 2001 at 07:18:30PM +0100, David Balazic wrote:
> 
> > Then I installed linux ( "some" beta version , kernel
> > is some recent 2.4.0-testXX )
> >
> > After the installation the disk ( win2000 ) would not boot.
> > It reports :
> > Read error on disk.
> > Press ctrl+alt+del to reboot.
> >
> > If I run linux ( it work OK from the boot floppy ),
> > it reports the geometry as 3xxxx/??/??.
> > Thirty thousand and some cylinders , H and S are probably 16/63
> > ( don't have it at hand ).
> >
> > It should be two thousand something and 255/63, I think.
> >
> > fdisk -l /dev/hda prints "Partition 1 does not end on cylinder boundary"
> > messages for the NTFS partitions ( hda1 and hda5 ). The linux ones are
> > OK.
> >
> > The problem is that now the BIOS sets Access mode to LARGE.
> > I can workaround it by changing access mode in BIOS setup
> > from AUTO to LBA, but I want to know what made BIOS to default to
> > LARGE and how to fix it.
> 
> Since "disk geometry" has become such a terrible mess,
> recent BIOSes decide that they don't know what the geometry
> should be, and guess the geometry from the partition table,
> if there is one.
> 
> So, if you added partitions during the install then it is
> not impossible that the BIOS changed its mind concerning
> the geometry.
> 
> It would be interesting to see the precise partition table
> (output of "fdisk -l /dev/hda").

Sorry , can't get it until saturday :-(

fdisk reports the disk geometry as 3xxxxx/xx/xx which probably LARGE.
I don't remember the start/stop cylinders of partitions.

Is there a way to change the geometry from fdisk ?
I tried expert mode and 'set sectors' and 'set heads',
but after I exit fdisk with 'w' , it is unchanged.


-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
