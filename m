Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263434AbRFXBki>; Sat, 23 Jun 2001 21:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265696AbRFXBk1>; Sat, 23 Jun 2001 21:40:27 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:55270 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S263434AbRFXBkN>; Sat, 23 Jun 2001 21:40:13 -0400
Message-ID: <3B35455E.5EF33B04@idcomm.com>
Date: Sat, 23 Jun 2001 19:41:50 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: For comment: draft BIOS use document for the kernel
In-Reply-To: <E15DTfd-0003gI-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> Linux 2.4 BIOS usage reference
> 
> Boot Sequence
> -------------
> 
> Linux is normally loaded either directly as a bootable floppy image or from
> hard disk via a boot loader called lilo. The kernel image is transferred
> into low memory and a parameter block above it.
> 
> When booting from floppy disk the BIOS disk parameter tables are replaced
> by a new table set up to allow a maximum sector count of 36 (the track size
> for a 2.88Mb ED floppy)
> 
> int 0x13, AH=0x02 is issued to to probe and find the disk geometry.
> int 0x13, AH=0x00 is used to reset the floppy controller.
> int 0x13, AH=0x02 is then issued repeatedly to load tracks of data. The
>         boot loader ensures no issued requests cross the track boundaries
> 
> int 0x10 service 3 is used during the boot loading sequence to obtain the
> cursor position. int 0x10 service 13 is used to display loading messages
> as the loading procedure continues. int 0x10 AH=0xE is used to display a
> progress bar of '=' characters during the bootstrap
> 
> Control is then transferred to the loaded image whether by the floppy boot
> loader or other services
> 

If it is within the realm of the paper, I'd like to know the differences
when booting from an ATAPI cdrom (or the fact that there is no
difference). Or for SCSI cdrom if relevant or useful to the purposes of
the paper.

D. Stimits, stimits@idcomm.com
