Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289749AbSBUIIi>; Thu, 21 Feb 2002 03:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288748AbSBUII2>; Thu, 21 Feb 2002 03:08:28 -0500
Received: from 89dyn169.com21.casema.net ([62.234.20.169]:65501 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S289813AbSBUIIU> convert rfc822-to-8bit; Thu, 21 Feb 2002 03:08:20 -0500
Message-Id: <200202210808.JAA20911@cave.bitwizard.nl>
Subject: Re: ide cd-recording not working in 2.4.18-rc2-ac1
In-Reply-To: <E16diR7-0005RF-00@the-village.bc.nu> from Alan Cox at "Feb 21,
 2002 01:54:17 am"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 21 Feb 2002 09:08:09 +0100 (MET)
CC: Ed Sweetman <ed.sweetman@wmich.edu>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > I get this on every cd I try and I've tried more than I'd have liked to.
> > 
> > Performing OPC...
> > /usr/bin/cdrecord: Input/output error. write_g1: scsi sendcmd: no error
> > CDB:  2A 00 00 00 00 1F 00 00 1F 00
> > status: 0x2 (CHECK CONDITION)
> > Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 21 00 00 00
> > Sense Key: 0x5 Illegal Request, Segment 0
> > Sense Code: 0x21 Qual 0x00 (logical block address out of range) Fru 0x0
> 
> Thats saying that cdrecord sent the drive a bogus command.

A friend of mine had exactly the same problems. These were eventually
solved by buying a new CDR drive.

We tried running the "cdrecord" from the old installation: Same problem. 

We tried it on the remainder of the spindle that used to work with the old
installation: Same problem. 

We tried it with the CDR discs that I use here: Same problem. 

(I was suspecting a problem with the disks as "start of lead in:
97:23:00" sounded a bit odd to me, and would result in "logical block
address out of range", So I first suspected the discs to be
incompatible with the current cdrecord.)


> > Now I know every cd isn't bad because they used to work in older
> > 2.4.17ish kernels.  I have scsi-generic support compiled as a module as
> 
> Does it still work with them ?

His old installation won't boot anymore, so in that case we can't
easily try anymore... Grmbl. 

> > SCSI subsystem driver Revision: 1.00
> > scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> 
> Right same as I am using

Ehmm. My story is about a real SCSI CDR drive. He now has an IDE drive. 

> > not sure what else I can get informationwize about what the drive is
> > doing.  
> 
> What type of IDE controller ?

NCR810. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
