Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132894AbRAPVNy>; Tue, 16 Jan 2001 16:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132895AbRAPVNo>; Tue, 16 Jan 2001 16:13:44 -0500
Received: from [24.65.192.120] ([24.65.192.120]:20984 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S132894AbRAPVNb>;
	Tue, 16 Jan 2001 16:13:31 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101162113.f0GLDPo14154@webber.adilger.net>
Subject: Re: Name of SCSI Device
In-Reply-To: <Pine.LNX.4.30.0101162111550.15252-100000@vela.salleURL.edu>
 "from Carles Pina i Estany at Jan 16, 2001 09:17:53 pm"
To: Carles Pina i Estany <is08139@salleURL.edu>
Date: Tue, 16 Jan 2001 14:13:24 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You write:
> If we install a SCSI hard disk drive, with ID3, an nothing on ID1 or ID2,
> will be sda. If we install a new disk on ID1, the drive that before was
> sda now change the name to sdb.
> 
> Why the name of hard disk drive of SCSI Controller are not fixed?
> ID0=sda
> ID1=sdb
> ID2=sdc

There are not enough major/minor numbers to do this.

> Then, it is possible that we must change /etc/fstab

If you are using ext2 (or ext3), it is possible to mount by filesystem
LABEL or UUID.  See man pages for e2label/tune2fs/dumpe2fs/mount(8)/fstab(5).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
