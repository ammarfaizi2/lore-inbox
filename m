Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129067AbRBFOwK>; Tue, 6 Feb 2001 09:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129105AbRBFOwB>; Tue, 6 Feb 2001 09:52:01 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14860 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129067AbRBFOv4>; Tue, 6 Feb 2001 09:51:56 -0500
Subject: Re: sync & asyck i/o
To: aer-list@mailandnews.com (Anders Eriksson)
Date: Tue, 6 Feb 2001 14:52:40 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200102061424.PAA32284@hell.wii.ericsson.net> from "Anders Eriksson" at Feb 06, 2001 03:24:11 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Q9U2-0005gX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> According to the man page for fsync it copies in-core data to disk 
> prior to its return. Does that take async i/o to the media in account? 
> I.e. does it wait for completion of the async i/o to the disk?

Undefined. 

In theory for a journalling file system it means the change is committed to the
log and the log to the media, and for other fs that the change is committed
to the final disk and recoverable by fsck worst case

In practice some IDE disks do write merging and small amounts of write
caching in the drive firmware so you cannot trust it 100%. In addition some
higher end controllers will store to battery backed memory caches which is
normally just fine since the reboot will play through the ram cache.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
