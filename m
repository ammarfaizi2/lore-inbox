Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129939AbRAKDVM>; Wed, 10 Jan 2001 22:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130340AbRAKDVD>; Wed, 10 Jan 2001 22:21:03 -0500
Received: from [24.65.192.120] ([24.65.192.120]:63734 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S129939AbRAKDUu>;
	Wed, 10 Jan 2001 22:20:50 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101110320.f0B3Klc09014@webber.adilger.net>
Subject: Re: [linux-lvm] Oops in 2.4.0 (@ LVM)
In-Reply-To: <3A5D1AA5.FED4D37E@zacarias.com.ar> "from Gustavo Zacarias at Jan
 10, 2001 11:29:57 pm"
To: linux-lvm@sistina.com
Date: Wed, 10 Jan 2001 20:20:47 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gustavo Zacarias writes:
> I was just trying LVM's vgextend, maybe i'm missing something??
> LVM works as long as i don't try to extend the VG.
> I can do testing/patching without trouble here...

There is a patch to the LVM kernel code which should help:
ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.0ac4/lvm-fix-2

You should also get the LVM user tools from CVS (with TAG LVM_0-9-patches)
to solve this problem.  There will hopefully be a new LVM release soon.

> # pvcreate /dev/hdb1
> pvcreate -- physical volume "/dev/hdb1" successfully created
> 
> # pvcreate /dev/hdb2
> pvcreate -- physical volume "/dev/hdb2" successfully created
> 
> # pvcreate /dev/hdb3
> pvcreate -- physical volume "/dev/hdb3" successfully created

Actually, unless you are simply doing this for testing, it is best to
have only 1 partition for the whole disk.  It wastes less space.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
