Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275224AbRKMM4l>; Tue, 13 Nov 2001 07:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276894AbRKMM4b>; Tue, 13 Nov 2001 07:56:31 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:50448 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S275224AbRKMM4U> convert rfc822-to-8bit; Tue, 13 Nov 2001 07:56:20 -0500
Date: Tue, 13 Nov 2001 13:56:17 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, joeja@mindspring.com
Subject: Re: 2.4.9 to 2.4.14 bug & workaround
Message-ID: <20011113135617.C9591@emma1.emma.line.org>
Mail-Followup-To: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
	linux-kernel@vger.kernel.org, joeja@mindspring.com
In-Reply-To: <Springmail.105.1005600219.0.18983900@www.springmail.com> <20011113124519.G3949@emma1.emma.line.org> <3BF10DD5.9461C2F@loewe-komp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <3BF10DD5.9461C2F@loewe-komp.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Wächtler schrieb am Dienstag, den 13. November 2001:

> On the IDE I mount /dev/hdb, on the USB thing I mount sd[ab]4
> depending if the flash reader is there or not.
> Hmh?

Do these behave differently? In particular, do the IDE Zip drives hide
the partition structure...

>    Device Boot    Start       End    Blocks   Id  System
> /dev/sdb4             1      1536     98288    6  FAT16

...which is evidently there?

> Until now I thought it had something to do with the different gendisk,
> LDM or so.

Well, you may also see firmware and/or design flaws in the drive
(personally, I have never trusted iomega, because on the CeBIT fair in
Hannover, I once asked them "why should I prefer iomega ZIP or JAZ over
SyQuest" and they had no answer except "we're just better". I later
heard complaints about the SCSI ID only to be chosen from 5 or 6, 25-pin
SCSI connectors and stuff, then there was the click-of-death sabotage
and now there is your "partition entry or not" problem.)

http://www.win.tue.nl/~aeb/linux/zip/zip-1.html has some info which does
not look too promising when you're after consistent behaviour across the
various drive types (interface-wise, that is).

Judging from what's on that page, the IDE driver seems to know it's just
a "floppy" without partitions, but the USB driver sees the (fake)
partitions.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
