Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVARG0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVARG0q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 01:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVARG0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 01:26:46 -0500
Received: from zasran.com ([198.144.206.234]:46747 "EHLO jojda.zasran.com")
	by vger.kernel.org with ESMTP id S261248AbVARG0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 01:26:40 -0500
Message-ID: <41ECAC1E.9010003@bigfoot.com>
Date: Mon, 17 Jan 2005 22:26:38 -0800
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Mudama <edmudama@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA disk dead? ATA: abnormal status 0x59 on port 0xE407
References: <1105830698.15835.16.camel@localhost.localdomain>	 <41EB3F80.5050400@tmr.com> <41EB5ECC.1020105@bigfoot.com>	 <200501170914.46344.m.watts@eris.qinetiq.com> <311601c9050117170161e65147@mail.gmail.com>
In-Reply-To: <311601c9050117170161e65147@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Mudama wrote:
> we don't use security torx screws, we use normal ones on our boards.
> 
> I wouldn't recommend swapping boards, since the code stored on the
> physical media, the opti tables, and the asic on the board were all
> processed together at one point and are specific to each other.  The
> new board may not work properly with the heads in the other drive, and
> could even cause damage, if both drives were several sigma to opposite
> sides of each other in the spectrum of passing drives, or had a
> different head vendor, etc.
> 
> If the data already appears lost and you've run out of other options,
> it may prove useful to attempt writing to the entire device without
> attempting reads.  If the drive then reads normally after that, the
> damage was probably incurred in some transient fashion (excessive
> vibration or heat, etc) and the replacement data may eliminate the
> failures.
> 
> Either way, however, I would probably recommend just RMA'ing the
> drives.  We should be able to get you a replacement in a few days from
> the time you fill out the form.

   it's DiamondMax 9 (manufactured june 13 2003), those had only one 
year warranty so unfortunately I can't return it (just checked it on 
maxtor.com).

   trying to write to it (cat /dev/hdb6 > /dev/sda) but getting exactly 
same messages (ATA: abnormal status 0x59 on port 0xE407). Looks like the 
drive does not respond to anything at all (I tried to turn off computer 
completely, even disconnecting it (while powered off)).

here's the full set of messages (the same set repeats every 30s or so):

Jan 17 22:22:48 jojda kernel: ata2: command 0x35 timeout, stat 0x59 
host_stat 0x21
Jan 17 22:22:48 jojda kernel: ata2: status=0x59 { DriveReady 
SeekComplete DataRequest Error }
Jan 17 22:22:48 jojda kernel: ata2: error=0x40 { UncorrectableError }
Jan 17 22:22:48 jojda kernel: scsi1: ERROR on channel 0, id 0, lun 0, 
CDB: Write (10) 00 00 00 00 15 00 03 eb 00
Jan 17 22:22:48 jojda kernel: Current sda: sense key Medium Error
Jan 17 22:22:48 jojda kernel: Additional sense: Unrecovered read error - 
auto reallocate failed
Jan 17 22:22:48 jojda kernel: end_request: I/O error, dev sda, sector 21
Jan 17 22:22:48 jojda kernel: ATA: abnormal status 0x59 on port 0xE407
Jan 17 22:22:48 jojda last message repeated 2 times

	erik
