Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287770AbSBFJXf>; Wed, 6 Feb 2002 04:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288967AbSBFJX0>; Wed, 6 Feb 2002 04:23:26 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:51978 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S287770AbSBFJXQ>; Wed, 6 Feb 2002 04:23:16 -0500
Message-ID: <3C60F5D3.4737E54@aitel.hist.no>
Date: Wed, 06 Feb 2002 10:22:27 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.3-dj2 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@kernel.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: one-line-patch against SCSI-Read-Error-BUG()
In-Reply-To: <E16YCdv-0002ru-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Since at least kernel 2.4.16 there is a BUG() in pci.h,
> > that crashes the kernel on any attempt to read a SCSI-Sector
> > from an erased MO-Medium and on any attempt to read
> > a sector from a SCSI-disk, which returns "Read-Error".
> 
> Adaptec aic7xxx card ?

You don't need an adaptec to BUG on scsi read errors.

I have a tekram adapter using the new SYM53C8XX version 2 driver.
One of my quantum atlas IV have a few bad sectors.  Reading
the file (ext2 fs on top of raid0) tends to merely cause error messages.
badblocks also runs fine.  But fsck -c triggers the BUG.

Helge Hafting
