Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317667AbSHFHEy>; Tue, 6 Aug 2002 03:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317833AbSHFHEy>; Tue, 6 Aug 2002 03:04:54 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:59405 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S317667AbSHFHEx>; Tue, 6 Aug 2002 03:04:53 -0400
Message-ID: <3D4F7636.679E27D0@aitel.hist.no>
Date: Tue, 06 Aug 2002 09:09:42 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.30 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au, mingo@redhat.com,
       linux-raid@vger.kernel.org
Subject: raid-0 oddity in 2.5.30 - can mount but not fsck
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to run 2.5.30 on a smp machine that use raid-1 and raid-0.
The RAIDs are autodetected.  The bootup fsck complained
that it couldn't find a valid superblock on /dev/md/1, which scared me
a bit.  But there is no problem with the device - mount
does not complain and mounts the fs (ext2) just fine.

The 2.5.30-kernel is patched for a max BIO size of 4k, so there
won't be trouble with BIOs crossing stripe boundaries.

2.5.7 have no problem with the RAIDs.

Helge Hafting
