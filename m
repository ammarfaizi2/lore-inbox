Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272696AbRIPTTc>; Sun, 16 Sep 2001 15:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272682AbRIPTTW>; Sun, 16 Sep 2001 15:19:22 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:22810 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272681AbRIPTTR>; Sun, 16 Sep 2001 15:19:17 -0400
Date: Sun, 16 Sep 2001 21:19:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Tonu Samuel <tonu@please.do.not.remove.this.spam.ee>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: vm rewrite ready [Re: broken VM in 2.4.10-pre9]
Message-ID: <20010916211934.C1315@athlon.random>
In-Reply-To: <20010916203414.B1315@athlon.random> <Pine.LNX.4.33L.0109161559500.21279-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109161559500.21279-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Sun, Sep 16, 2001 at 04:07:16PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2001 at 04:07:16PM -0300, Rik van Riel wrote:
> I doubt you'll be able to achieve all of those without
> really major changes, but I'll take a look at your code
> when you make it public ;)

as said it is quite a major change, it discards most of the the 2.4 vm
that I don't agree with, it is basically an evolution of the classzone
patch.

andrea@athlon:~/remote/kernel.org/kernels/v2.4/2.4.10pre9aa1 > diffstat 80_vm-aa-1 
 ID                      |binary
 arch/alpha/mm/fault.c   |    7 
 arch/i386/mm/fault.c    |   25 +
 fs/buffer.c             |   68 +--
 fs/dcache.c             |    2 
 fs/inode.c              |   59 +--
 fs/proc/proc_misc.c     |    8 
 include/linux/fs.h      |    2 
 include/linux/highmem.h |    2 
 include/linux/list.h    |    1 
 include/linux/mm.h      |   50 +-
 include/linux/mmzone.h  |    9 
 include/linux/pagemap.h |    1 
 include/linux/sched.h   |    3 
 include/linux/slab.h    |    2 
 include/linux/swap.h    |  148 ++-----
 include/linux/swapctl.h |   22 -
 kernel/fork.c           |    2 
 kernel/signal.c         |    2 
 kernel/sysctl.c         |    6 
 mm/filemap.c            |   38 -
 mm/memory.c             |   12 
 mm/numa.c               |    8 
 mm/oom_kill.c           |   40 --
 mm/page_alloc.c         |  501 +++++++++-----------------
 mm/shmem.c              |    2 
 mm/slab.c               |    8 
 mm/swap.c               |  105 -----
 mm/swap_state.c         |   14 
 mm/swapfile.c           |   21 -
 mm/vmscan.c             |  913 +++++++++++++++---------------------------------
 31 files changed, 699 insertions(+), 1382 deletions(-)
andrea@athlon:~/remote/kernel.org/kernels/v2.4/2.4.10pre9aa1 > 

Andrea
