Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276535AbRJ3Wqo>; Tue, 30 Oct 2001 17:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278505AbRJ3Wqe>; Tue, 30 Oct 2001 17:46:34 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:59723 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S276535AbRJ3WqX>; Tue, 30 Oct 2001 17:46:23 -0500
Date: Tue, 30 Oct 2001 23:46:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pre5 VM livelock
Message-ID: <20011030234633.B1340@athlon.random>
In-Reply-To: <3BDF1999.CAF5D101@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3BDF1999.CAF5D101@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, Oct 30, 2001 at 04:20:25PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 04:20:25PM -0500, Jeff Garzik wrote:
> 2.4.14-pre5 was looking very nice on my alpha, doing RPM builds.  It
> seems to swap only when it needs to, and subjectively, performance
> appears better.
> 
> However at this very moment, the kernel is livelocked.  I can type on
> console and do sysrq to your heart's content... I can even sysrq-s and
> sync successfully.  But no processing occurs.  I can ping, but two ssh
> sessions are frozen.
> 
> Key symptoms:  Free swab 0Kb according to sysrq-m, and several processes
> in run state according to sysrq-t.
> 
> Let me know if I should poke at this alpha further before rebooting.
> 
> further info:
> free pages: 2560 kb (0kb highmem)
> ( active 2422 inactive 38578 free 320 )
> swap cache: add 850670  delete 850666 find 323063/440091 race 1+0
> free swap: 0kb
> 49074 pages of ram
> 786 free pages
> 1299 reserved pages
> 2683 pages shared
> 4 pages swap cached
> 4 pages in page table cache
> buffer memory: 168kb
> 
> This behavior is reproducible, I am pretty sure.

can you reproduce with 2.4.14pre5aa1 too? The inactive list is pretty
big so maybe it's something else but maybe it's really mlocked anon
memory.

Andrea
