Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265195AbSJWTro>; Wed, 23 Oct 2002 15:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbSJWTro>; Wed, 23 Oct 2002 15:47:44 -0400
Received: from [198.149.18.6] ([198.149.18.6]:30420 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S265195AbSJWTri>;
	Wed, 23 Oct 2002 15:47:38 -0400
Date: Wed, 23 Oct 2002 14:53:42 -0500
From: John Hesterberg <jh@sgi.com>
To: linux-kernel@vger.kernel.org, csa@oss.sgi.com, pagg@oss.sgi.com
Cc: Robin Holt <holt@sgi.com>
Subject: [PATCH] 2.5.44 CSA, Job, and PAGG
Message-ID: <20021023145342.A6595@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.44 versions of CSA, Job, and PAGG patches are available at:
    ftp://oss.sgi.com/projects/pagg/download/linux-2.5.44-pagg.patch
    ftp://oss.sgi.com/projects/pagg/download/linux-2.5.44-job.patch
    ftp://oss.sgi.com/projects/csa/download/linux-2.5.44-csa.patch
Apply them in that order.
The CSA and job user-level code is in the same directories.

CSA (Comprehensive System Accounting) provides methods for
collecting per-process resource usage data, monitoring disk usage,
and charging fees to specific login accounts.  CSA provides features
which are not available with the other Linux accounting packages.
For more information, see:
     http://oss.sgi.com/projects/csa/

Linux Jobs is an inescapable process container that is typically
created by point of entry processes like login, and inherited by
children.  PAGG (Process Aggregates) is a generic framework for
implementing process containers such as Linux Jobs.
For more information, see:
    http://oss.sgi.com/projects/pagg/
    
CSA depends on Linux Jobs, and Linux Jobs depends on PAGG.

diffstat linux-2.5.44-pagg.patch
 Documentation/pagg.txt    |  148 +++++++++++++++++
 include/linux/init_task.h |    4 
 include/linux/pagg.h      |  216 +++++++++++++++++++++++++
 include/linux/sched.h     |    4 
 init/Config.help          |    6 
 init/Config.in            |    1 
 kernel/Makefile           |    3 
 kernel/exit.c             |    4 
 kernel/fork.c             |   11 +
 kernel/pagg.c             |  396 ++++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 792 insertions(+), 1 deletion(-)

diffstat linux-2.5.44-job.patch
 Documentation/job.txt |  434 ++++++++++
 include/linux/job.h   |  250 ++++++
 init/Config.help      |   22 
 init/Config.in        |    3 
 kernel/Makefile       |    3 
 kernel/job.c          | 2001 ++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 2712 insertions(+), 1 deletion(-)

diffstat linux-2.5.44-csa.patch
 drivers/block/ll_rw_blk.c    |    4 
 fs/exec.c                    |    4 
 fs/read_write.c              |   25 
 include/linux/csa.h          |  518 ++++++++++++++
 include/linux/csa_internal.h |   84 ++
 include/linux/sched.h        |   20 
 init/Config.help             |   19 
 init/Config.in               |    1 
 kernel/Makefile              |    1 
 kernel/csa_job_acct.c        | 1582 +++++++++++++++++++++++++++++++++++++++++++
 kernel/exit.c                |    7 
 kernel/fork.c                |    8 
 kernel/ksyms.c               |    4 
 mm/memory.c                  |   18 
 mm/mmap.c                    |   10 
 mm/mremap.c                  |    8 
 mm/rmap.c                    |    3 
 mm/swapfile.c                |    4 
 18 files changed, 2317 insertions(+), 3 deletions(-)

John Hesterberg and Robin Holt
