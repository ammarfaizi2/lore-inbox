Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281615AbRKMMLU>; Tue, 13 Nov 2001 07:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281616AbRKMMLK>; Tue, 13 Nov 2001 07:11:10 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:55814 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S281615AbRKMMLE>; Tue, 13 Nov 2001 07:11:04 -0500
Message-ID: <3BF10DD5.9461C2F@loewe-komp.de>
Date: Tue, 13 Nov 2001 13:11:01 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
CC: linux-kernel@vger.kernel.org, joeja@mindspring.com
Subject: Re: 2.4.9 to 2.4.14 bug & workaround
In-Reply-To: <Springmail.105.1005600219.0.18983900@www.springmail.com> <20011113124519.G3949@emma1.emma.line.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> 
> On Mon, 12 Nov 2001, joeja@mindspring.com wrote:
> 
> (reformatted quote to heed line length provisions)
> > I have an internal iomega 'type' (not iomega) IDE zip drive.  It
> > mounts as /dev/hdd instead of /dev/hdd4.  Mounting as /dev/hdd seems
> > okay.
> >
> > Mounting as /dev/hdd4 will hang my kernel( 2.4.9-2.4.14).  I have read
> > that on some MB you can change the bios to none for the ide device and
> > this works on certain mb.  I tried this and it did not change
> > anything.
> 
> Well, all this depends on how the media has been formatted. From what I
> heard (I have no exchangable drives since I sold my SyQuest crap), some
> ZIP (presumably) media are partitioned and have their fourth partition
> formatted, giving your data as /dev/hdd4 or /dev/sdb4 or something other
> with 4 to the end. Then, the entire media might be formatted "raw" with
> Linux, so you'd have to mount /dev/hdd instead.
> 

Yes, in theory ;-)
I have an internal IDE 100MB Zip @home.
In the office I have a 250MB USB ZIP.

The media is partitioned, with the 4th primary partition formatted
as VFAT.

On the IDE I mount /dev/hdb, on the USB thing I mount sd[ab]4
depending if the flash reader is there or not.
Hmh?

# fdisk -l /dev/sdb
 
Disk /dev/sdb: 4 heads, 32 sectors, 1536 cylinders
Units = cylinders of 128 * 512 bytes
 
   Device Boot    Start       End    Blocks   Id  System
/dev/sdb4             1      1536     98288    6  FAT16



Of course I use different kernels, @home: 2.4.9ac18 and 2.4.1[34]-xfs;
@office for now 2.4.9ac3+bcl.

Until now I thought it had something to do with the different gendisk,
LDM or so.
