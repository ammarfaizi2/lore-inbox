Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265187AbSLILpV>; Mon, 9 Dec 2002 06:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbSLILpV>; Mon, 9 Dec 2002 06:45:21 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:61194 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S265187AbSLILpU>; Mon, 9 Dec 2002 06:45:20 -0500
Message-ID: <3DF482EA.8B646BD@aitel.hist.no>
Date: Mon, 09 Dec 2002 12:47:54 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.50bk6 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Kernel mailing list <linux-kernel@vger.kernel.org>
CC: Neil Brown <neilb@cse.unsw.edu.au>, groudier@free.fr
Subject: 2.5.50-bkX don't boot sometimes. scsi or raid problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem with 2.5.50 and the later bk's.

A "warm" boot after running 2.5.49 tends to work.
A cold boot (from poweroff) usually don't.

When it goes wrong the kernel prints out normal messages
until it reach:

"md: ... autorun DONE."

The next step, which is either

"md: syncing RAID array md0"

when there is syncing to do, or

"VFS: Mounted root (ext2 filesystem) readonly."

if all is fine.  But it don't happen, the line never
shows up and there is no disk activity.
It is as if the kernel waits patiently for something that
won't happen, at least not in 10 minutes.
SYSRQ works, but there isn't much to do before
the root mount happens anyway.

This is a smp kernel, using root on a raid-1 over
two scsi disks. scsi uses a tekram controller
using the sym-2 driver. 
The kernel is monolithic (no modules, no initrd)
and is compiled with gcc 2.95.4


Helge Hafting
