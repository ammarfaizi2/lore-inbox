Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbSJYIiP>; Fri, 25 Oct 2002 04:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261316AbSJYIiN>; Fri, 25 Oct 2002 04:38:13 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:61253 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261312AbSJYIhV>; Fri, 25 Oct 2002 04:37:21 -0400
Date: Fri, 25 Oct 2002 01:51:51 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: linux-kernel@vger.kernel.org
cc: lkcd-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] LKCD for 2.5.44 - full patch set (2002.10.23)
In-Reply-To: <Pine.LNX.4.44.0210230241050.27315-100000@nakedeye.aparity.com>
Message-ID: <Pine.LNX.4.44.0210250141380.766-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest set of patches are available on the LKCD web site.
We've corrected all (but one of) the issues with the patches that
Christoph reported.  We've also put the latest lkcdutils RPM for
doing full dump testing (if you want).  I've commented on all the
fixes in responses to the LKCD patch set thread.  The only other
thing not corrected is the ioctl() addition, which we'd like to
keep unless we absolutely have to change it.

The LKCD patches and lkcdutils RPM can be downloaded from the web at:

	http://lkcd.sourceforge.net/download/latest

Please E-mail me if you have any problems.  Otherwise, I'm hoping
there's nothing else that needs to be done.  Please put it in 2.5! :)

--Matt

The diffstat is below:

 arch/i386/boot/Makefile              |    2
 arch/i386/boot/install.sh            |   24
 arch/i386/config.in                  |   11
 arch/i386/kernel/Makefile            |    2
 arch/i386/kernel/irq.c               |    5
 arch/i386/kernel/nmi.c               |    9
 arch/i386/kernel/smp.c               |   15
 arch/i386/kernel/traps.c             |   28
 arch/i386/mach-generic/irq_vectors.h |    1
 arch/i386/mm/Makefile                |    2
 arch/i386/mm/init.c                  |    5
 arch/s390/boot/Makefile              |    2
 arch/s390/boot/install.sh            |   24
 arch/s390x/boot/Makefile             |    2
 arch/s390x/boot/install.sh           |   24
 drivers/Makefile                     |    1
 drivers/char/sysrq.c                 |   13
 drivers/dump/Makefile                |   15
 drivers/dump/dump_base.c             | 1544 +++++++++++++++++++++++++++++++++++
 drivers/dump/dump_blockdev.c         |  421 +++++++++
 drivers/dump/dump_gzip.c             |  117 ++
 drivers/dump/dump_i386.c             |  318 +++++++
 drivers/dump/dump_rle.c              |  174 +++
 include/asm-i386/dump.h              |  101 ++
 include/asm-i386/smp.h               |    1
 include/linux/dump.h                 |  330 +++++++
 include/linux/dumpdev.h              |  115 ++
 include/linux/major.h                |    2
 include/linux/page-flags.h           |    5
 init/Makefile                        |    5
 init/kerntypes.c                     |   24
 init/main.c                          |   10
 kernel/Makefile                      |    2
 kernel/panic.c                       |   20
 kernel/sched.c                       |   30
 kernel/sys.c                         |   36
 lib/Config.in                        |    2
 mm/page_alloc.c                      |   22
 38 files changed, 3429 insertions(+), 35 deletions(-)

On Wed, 23 Oct 2002, Matt D. Robinson wrote:
|>These are the latest LKCD patches for 2.5.44.  We have incorporated
|>just about every fix (with a few exceptions) from all users who have
|>made requests up through yesterday.  We ask that these be included
|>in the kernel tree.  If they are incorporated, please copy me on the
|>check-in.
|>
|>The patches can be downloaded from the web at:
|>
|>      http://lkcd.sourceforge.net/download/latest
|>
|>The full diffstat for LKCD in 2.5.44 tree (the majority of the
|>changes are the addition of the dump modules and headers):
|>


