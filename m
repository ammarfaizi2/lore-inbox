Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129468AbQJ0Uj3>; Fri, 27 Oct 2000 16:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129536AbQJ0UjT>; Fri, 27 Oct 2000 16:39:19 -0400
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:33787 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129468AbQJ0UjH>; Fri, 27 Oct 2000 16:39:07 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200010272037.e9RKbPj05203@webber.adilger.net>
Subject: Re: Question: multiple major numbers - one driver
In-Reply-To: <Pine.LNX.4.05.10010271201430.18801-100000@gemini.procom.com>
 "from chris parker at Oct 27, 2000 12:07:38 pm"
To: chris parker <chrisp@procom.com>
Date: Fri, 27 Oct 2000 14:37:24 -0600 (MDT)
CC: linux-kernel@vger.kernel.org, chris_parker@procom.com, hnguyen@procom.com
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Parker writes:
> I have a need for more than 256 minor numbers.  I could add some 
> more major numbers, thus getting the number of majors * 256.
> I would like to have only device driver loaded to handle the
> multiple majors.

Look at the SCSI/IDE/COMPAQ Smart RAID/etc drivers that have multiple
major numbers registered (per Documentation/devices.txt).  Some of
the storage drivers have been allocating blocks of 8 major numbers at
a time.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
