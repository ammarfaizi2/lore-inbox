Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbRBHCLp>; Wed, 7 Feb 2001 21:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129161AbRBHCLe>; Wed, 7 Feb 2001 21:11:34 -0500
Received: from smtprelay.abs.adelphia.net ([64.8.20.11]:57835 "EHLO
	smtprelay3.abs.adelphia.net") by vger.kernel.org with ESMTP
	id <S129033AbRBHCLW>; Wed, 7 Feb 2001 21:11:22 -0500
Message-ID: <3A81FF41.316BF761@adelphia.net>
Date: Wed, 07 Feb 2001 21:06:57 -0500
From: Stephen Wille Padnos <stephenwp@adelphia.net>
X-Mailer: Mozilla 4.76C-SGI [en] (X11; U; IRIX64 6.5 IP28)
X-Accept-Language: en
MIME-Version: 1.0
To: "A.Sajjad Zaidi" <sajjad@vgkk.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Promise, DMA and RAID5 problems running 2.4.1
In-Reply-To: <Pine.LNX.4.10.10102070924340.19012-100000@coffee.psychology.mcmaster.ca> <3A81FDAF.43DE0791@vgkk.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A.Sajjad Zaidi" wrote:

> > do you understand that you can't really have raid on ide involving
> > two drives on the same channel?
>
> Is that just because of performance or are there other problems? Its working
> fine as it is, but Im considering setting up all drives as masters (2x
> ATA-100, 2x ATA-66).

It's because IDE is a blocking bus - each drive must complete its' task before
the data bus is released for the next IO operation.  So, the first drive will
finish writing to the disk before the second drive can start.  (That's one
reason why SCSI is preferred for high end systems - you can "disconnect" from
an IO operation to allow other IO's to be sent to other devices on the same
bus)

--
Stephen Wille Padnos
Programmer, Engineer, Problem Solver
swpadnos@adelphia.net



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
