Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLOIpq>; Fri, 15 Dec 2000 03:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129421AbQLOIpg>; Fri, 15 Dec 2000 03:45:36 -0500
Received: from a75d1hel.dial.kolumbus.fi ([193.229.161.75]:4620 "EHLO
	darkmoon.imagesoft") by vger.kernel.org with ESMTP
	id <S129267AbQLOIpS>; Fri, 15 Dec 2000 03:45:18 -0500
Message-ID: <3A39D2FC.BB228064@imagesoft.fi>
Date: Fri, 15 Dec 2000 10:14:52 +0200
From: Jussi Laako <jussi.laako@imagesoft.fi>
Organization: Image Soft Oy
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory subsystem error and freeze on 2.4.0-test12
In-Reply-To: <Pine.LNX.4.21.0012141515070.1437-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> > Dec 14 12:33:32 alien kernel: __alloc_pages: 2-order allocation failed.
> > System deadlocked about one minute later.
> Any idea which part of the kernel deadlocked? Was it
> the network driver, the VM subsystem, .... ?

I suspect the VM, it's been doing strange things since -test11, -test10 was
working fine. There was heavy fork operation going on (about 50 processes).

Today got also 3-order allocation failures, probably from IDE driver or SCSI
cdrom because cdda2wav triggered them. It happens every time when I start
cdda2wav (with -B option). CDRW drive is only IDE device in the system,
harddisks are SCSI.

 - Jussi Laako

-- 
PGP key fingerprint: 3827 6A53 B7F9 180E D971  362B BB53 C8A1 B578 D249
Available at: ldap://certserver.pgp.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
