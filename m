Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129717AbQKSNbc>; Sun, 19 Nov 2000 08:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129904AbQKSNbV>; Sun, 19 Nov 2000 08:31:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44826 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129717AbQKSNbF>; Sun, 19 Nov 2000 08:31:05 -0500
Subject: Re: [Fwd: [Linux-usb-users] Re: 2.4.0-test11-pre7 -- The USB ORB Drive works vastly better when the media is formatted with FAT32.]
To: miles@speakeasy.org (Miles Lane)
Date: Sun, 19 Nov 2000 13:01:42 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A1797A5.4060003@speakeasy.org> from "Miles Lane" at Nov 19, 2000 01:04:37 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13xU6K-0002iK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > > protocol for USB communication being diluted down.  Realize that a 1KB
>  > > block has 4 times the overhead of a 4KB block (on a per-byte-of-data
>  > > basis).  The usb-storage driver attempts to get the SCSI layer to give it

That guess would be dubious. Its also not IMHO enough to explain the
speed difference. That looks like something is causing far bigger delays
internally.

>  > > the largest requests possible, but that layer is limited by what the
>  > > filesystem layer is willing to give.

Providing your driver supports scatter gather you will get large chunks handed
down to the driver. In the scsi world you can control that with the
scsi host template settings. (both the scatter/gather limit and whether you
want the scsi layer to try and merge requests for you)

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
