Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRAHXUM>; Mon, 8 Jan 2001 18:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130516AbRAHXUC>; Mon, 8 Jan 2001 18:20:02 -0500
Received: from quechua.inka.de ([212.227.14.2]:20588 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129387AbRAHXTy>;
	Mon, 8 Jan 2001 18:19:54 -0500
From: Bernd Eckenfels <inka-user@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Message-Id: <E14FlZx-00003w-00@sites.inka.de>
Date: Tue, 9 Jan 2001 00:19:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010105230950.B301@bug.ucw.cz> you wrote:
> Also thing about cases where powerplant fails, or when electricity in
> the house fails. I've seen places where electricity failed 5 times a
> day, because someone put 10A fuse and we were using just about 2kW...

Especially evil is a power failure, and then a second failure while fsck is
running...

So i hope Journaling FSs will have the power of normal FSs soon, so we can
have them as a default for consumers. Otherwise:

/dev/scsi/host0/bus0/target6/lun0/part1 on / type ext2 (ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw)
/dev/sda5 on /usr type ext2 (ro)
/dev/sda6 on /var type ext2 (r,noexec)
/dev/sda7 on /home type ext2 (rw,nosuid)
/dev/scd0 on /cdrom type iso9660 (ro)

some read only filesystems :)

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
