Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263449AbTFPFrI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 01:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTFPFrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 01:47:08 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:8205 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S263449AbTFPFrB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 01:47:01 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel@vger.kernel.org
Subject: 2.4 Bitkeeper repo not updated ?
Date: Mon, 16 Jun 2003 14:00:37 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306161245.33196.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.21 seems not be at  http://linux.bkbits.net/linux-2.4
Tried yesterday and again today

Also tag for -rc8 is missing


Regards
Michael

[mhf@mhfl2 11:52:41 linux-2.4]$ bk pull -R
---------------------- Receiving the following csets -----------------------
1.1201 1.1200 1.1199 1.1198 1.1197
----------------------------------------------------------------------------
ChangeSet: 5 deltas
drivers/net/wan/lmc/lmc_proto.c: 2 deltas
fs/ext2/balloc.c: 1 deltas
net/sched/sch_ingress.c: 2 deltas
---------------------------------------------------------------------------
takepatch: saved entire patch in PENDING/2003-06-16.01
---------------------------------------------------------------------------
Applying   5 revisions to ChangeSet
Applying   2 revisions to drivers/net/wan/lmc/lmc_proto.c
Applying   1 revisions to fs/ext2/balloc.c
Applying   2 revisions to net/sched/sch_ingress.c
takepatch: 10 new revisions, 0 conflicts in 4 files
1171 bytes uncompressed to 5488, 4.69X expansion

[mhf@mhfl2 12:14:41 linux-2.4]$ bk resolve
Using :0.0 as graphical display
Verifying consistency of the RESYNC tree...
resolve: applied 4 files in pass 4
resolve: running consistency check, please wait...
Consistency check passed, resolve complete.

[mhf@mhfl2 12:18:27 linux-2.4]$ bk changes -t
ChangeSet@1.1193, 2003-06-03 13:03:50-03:00, marcelo@freak.distro.conectiva
    Changed EXTRAVERSION to -rc7
  TAG: v2.4.21-rc7

[mhf@mhfl2 12:48:44 linux-2.4]$ bk changes
ChangeSet@1.1201, 2003-06-09 17:42:11-03:00, marcelo@freak.distro.conectiva
  Cset exclude: geert@linux-m68k.org|ChangeSet|20030609201907|11405

ChangeSet@1.1200, 2003-06-09 17:41:58-03:00, marcelo@freak.distro.conectiva
  Cset exclude: geert@linux-m68k.org|ChangeSet|20030609201637|12385

ChangeSet@1.1199, 2003-06-09 17:19:07-03:00, geert@linux-m68k.org
  [PATCH] lmc_proto.c includes <asm/smp.h>

  lmc_proto.c includes <asm/smp.h>, causing build failures on UMP-only
  architectures

ChangeSet@1.1198, 2003-06-09 17:17:55-03:00, geert@linux-m68k.org
  [PATCH] Fix ext2fs warning

  ext2fs: Fix incorrect printf() format (already fixed in 2.5)

ChangeSet@1.1197, 2003-06-09 17:16:37-03:00, geert@linux-m68k.org
  [PATCH] sch_ingress.c includes <asm/smp.h>

  sch_ingress.c includes <asm/smp.h>, causing build failures on UMP-only
  architectures

ChangeSet@1.1196, 2003-06-05 18:05:17-03:00, hugh@veritas.com
  [PATCH] Fix shmctl(SHM_LOCK/UNLOCK) deadlock

  On Wed, 4 Jun 2003, Andrea Arcangeli wrote:
  > this patch fixes an SMP deadlock that triggered in some production
  > usage:

  Yes, worth fixing in 2.4.21, thanks Andrea:
  shmem_lock tried for a semaphore while sys_shmctl holds a spinlock.

  Patch below against 2.4.21-rc7 - Andrea's patch against his own tree
  may have deterred you!  As he said, using spin_lock here is actually
  superfluous, but raises fewer eyebrows than omitting it.  I want to
  send you patches in early 2.4.22 to bring many of the 2.5 tmpfs mods
  into 2.4, which would fix this: but the hangfix is worth taking now.

ChangeSet@1.1195, 2003-06-05 04:00:23-03:00, marcelo@freak.distro.conectiva
    Changed EXTRAVERSION to -pre8

ChangeSet@1.1194, 2003-06-04 13:52:56-03:00, marcelo@freak.distro.conectiva
  Backout erroneous kiobuf dcache flush changes
  Cset exclude: jsun@mvista.com|ChangeSet|20030425203656|60956



-- 
Powered by linux-2.5.71-mm1, compiled with gcc-2.95-3 because it's rock solid

My current linux related activities in rough order of priority:
- Testing of Swsusp for 2.4
- Learning 2.5 kernel debugging with kgdb - it's in the -mm tree
- Studying 2.5 serial and ide drivers, ACPI, S3

The 2.5 kernel could use your usage. More info on setting up 2.5 kernel at 
http://www.codemonkey.org.uk/post-halloween-2.5.txt


