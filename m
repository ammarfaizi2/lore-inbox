Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261512AbSJQPPz>; Thu, 17 Oct 2002 11:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261531AbSJQPPz>; Thu, 17 Oct 2002 11:15:55 -0400
Received: from [198.149.18.6] ([198.149.18.6]:57805 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261512AbSJQPPy>;
	Thu, 17 Oct 2002 11:15:54 -0400
Date: Thu, 17 Oct 2002 10:21:47 -0500
From: John Hesterberg <jh@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Robin Holt <holt@sgi.com>
Subject: [PATCH] 2.5.43 CSA, Job, and PAGG
Message-ID: <20021017102146.A17642@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.43 versions of CSA, Job, and PAGG patches are available at:
    ftp://oss.sgi.com/projects/pagg/download/linux-2.5.43-pagg-job.patch
    ftp://oss.sgi.com/projects/csa/download/linux-2.5.43-csa.patch
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

diffstat linux-2.5.43-pagg-job.patch
 Documentation/job.txt     |  436 +++++++++
 Documentation/pagg.txt    |  151 +++
 include/linux/init_task.h |    4 
 include/linux/job.h       |  261 +++++
 include/linux/jobctl.h    |  167 +++
 include/linux/pagg.h      |  242 +++++
 include/linux/sched.h     |    4 
 init/Config.help          |   28 
 init/Config.in            |    4 
 kernel/Makefile           |   10 
 kernel/exit.c             |   15 
 kernel/fork.c             |   11 
 kernel/job.c              | 2023 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/pagg.c             |  418 +++++++++
 14 files changed, 3768 insertions(+), 6 deletions(-)

diffstat linux-2.5.43-csa.patch                            
 drivers/block/ll_rw_blk.c    |    4 
 fs/exec.c                    |    4 
 fs/read_write.c              |   18 
 include/linux/csa.h          |  522 ++++++++++++++
 include/linux/csa_internal.h |   87 ++
 include/linux/sched.h        |   20 
 init/Config.help             |   19 
 init/Config.in               |    1 
 kernel/Makefile              |    1 
 kernel/csa_job_acct.c        | 1586 +++++++++++++++++++++++++++++++++++++++++++
 kernel/exit.c                |    7 
 kernel/fork.c                |    7 
 kernel/ksyms.c               |    4 
 mm/memory.c                  |   18 
 mm/mmap.c                    |    9 
 mm/mremap.c                  |    8 
 mm/rmap.c                    |    3 
 mm/swapfile.c                |    4 
 18 files changed, 2319 insertions(+), 3 deletions(-)

John Hesterberg and Robin Holt
