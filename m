Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131576AbRAKVog>; Thu, 11 Jan 2001 16:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132957AbRAKVo0>; Thu, 11 Jan 2001 16:44:26 -0500
Received: from [24.65.192.120] ([24.65.192.120]:21498 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S131576AbRAKVoU>;
	Thu, 11 Jan 2001 16:44:20 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101112142.f0BLgXE05982@webber.adilger.net>
Subject: Re: Strange umount problem in latest 2.4.0 kernels
In-Reply-To: <3A5E0886.4389692E@Hell.WH8.TU-Dresden.De> "from Udo A. Steinberg
 at Jan 11, 2001 08:24:54 pm"
To: "Udo A. Steinberg" <sorisor@hell.wh8.tu-dresden.de>
Date: Thu, 11 Jan 2001 14:42:32 -0700 (MST)
CC: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Udo, you write:
> Anyway, disabled both lpd and httpd from the startup scripts
> and now the bug is triggered *every* time. I cannot reboot
> a single time without partitions being busy. When neither
> lpd nor httpd run, fsck finds nothing wrong.
> 
> The very strange stuff is umount at reboot:
> 
> umount: none busy - remounted read-only
          ^^^^
Check the output of "mount" and/or your /etc/fstab for a device called
"none".  On my system, there is devpts which has device "none", so it
is possible this is busy, and can't be unmounted, and hence root is also
busy and can't be ro remounted.  Maybe also check /proc/mounts for "none".

> umount: /: device is busy
> Remounting root-filesystem read-only
> mount: / is busy
> Rebooting.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
