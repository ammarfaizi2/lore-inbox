Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131468AbQLGRxm>; Thu, 7 Dec 2000 12:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131692AbQLGRxZ>; Thu, 7 Dec 2000 12:53:25 -0500
Received: from icarus.com ([208.36.26.146]:22788 "EHLO icarus.com")
	by vger.kernel.org with ESMTP id <S131220AbQLGRxG>;
	Thu, 7 Dec 2000 12:53:06 -0500
Message-Id: <200012071722.JAA07401@icarus.com>
X-Mailer: exmh version 2.1.1 10/15/1999
To: linux-kernel@vger.kernel.org
cc: steve@icarus.com
Subject: 40Gig IDE disk wrapping around at 32Gig?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Dec 2000 09:22:38 -0800
From: Stephen Williams <steve@icarus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


During an install of RedHat 6.1 onto a Dell Dimension L600cx, I partitioned
the internal 40gig disk to include 4 partitions. I initially let the disk
druid do it, but it rendered the partition table unreadable. So I used
fdisk and partitioned it with primary partitions like so:

(sectors = 255, heads = 63)

/dev/hda1  1 -- 17         (136521 blocks)
/dev/hda2  18 -- 50        (265072 blocks)
/dev/hda3  51 -- 3967      (31463302 blocks)
/dev/hda4  3968 -- 4865    (7213185 blocks)

Problem is, any attempt to mkfs on /dev/hda4 seems to trash the filesystems
on hda1, hda2 and hda3. It makes an ugly mess.

RedHat 6.1 installs a 2.2.12 kernel, with patches. I'm ignoring /dev/hda4
for now and I've installed 2.2.17 from source. It seems reliable as long
as I ignore /dev/hda4. I haven't tried it w/ 2.2.17 installed.

Am I running into some limit here? Are there any known issues with
Linux 2.2.12 or fdisk (or mkfs.ext2) that might relate to this?
-- 
Steve Williams                "The woods are lovely, dark and deep.
steve@icarus.com              But I have promises to keep,
steve@picturel.com            and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
