Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263071AbTCWOor>; Sun, 23 Mar 2003 09:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263074AbTCWOor>; Sun, 23 Mar 2003 09:44:47 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:48569 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263071AbTCWOoq>; Sun, 23 Mar 2003 09:44:46 -0500
Date: Sun, 23 Mar 2003 15:59:15 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: 2.5.65-ac2 -- hda/ide trouble on ICH4
Message-ID: <20030323145915.GA865@brodo.de>
References: <20030322140337.GA1193@brodo.de> <1048350905.9219.1.camel@irongate.swansea.linux.org.uk> <20030322162502.GA870@brodo.de> <1048354921.9221.17.camel@irongate.swansea.linux.org.uk> <20030323010338.GA886@brodo.de> <1048434472.10729.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048434472.10729.28.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 03:47:54PM +0000, Alan Cox wrote:
> On Sun, 2003-03-23 at 01:03, Dominik Brodowski wrote:
> > 	while (!list_empty(&list)) {
> > 		ide_drive_t *drive = list_entry(list.next, ide_drive_t,
> > list);
> > 		list_del_init(&drive->list);
> > 		if (drive->present)
> > 			ata_attach(drive);
> 
> Can you boot and printk the drive name out each iteration see if the list
> is hosed somewhere.

printk("%4s\n", drive->name) prints out "hdd" all the time. 

hda is an ATA disk drive
hdb is empty
hdc is an ATAPI CD/DVD-ROM drive
hdd is an ATAPI CD-ROM CD-R/RW drive

	Dominik
