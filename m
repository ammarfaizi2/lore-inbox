Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbRAQIgi>; Wed, 17 Jan 2001 03:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRAQIg2>; Wed, 17 Jan 2001 03:36:28 -0500
Received: from Prins.externet.hu ([212.40.96.161]:17426 "EHLO
	prins.externet.hu") by vger.kernel.org with ESMTP
	id <S129632AbRAQIgN>; Wed, 17 Jan 2001 03:36:13 -0500
Date: Wed, 17 Jan 2001 09:36:07 +0100 (CET)
From: Boszormenyi Zoltan <zboszor@externet.hu>
To: riel@nl.linux.org
cc: linux-kernel@vger.kernel.org
Subject: 2.4.0-vmpatch-15.1 still no go
In-Reply-To: <Pine.LNX.4.02.10101091023170.22614-100000@prins.externet.hu>
Message-ID: <Pine.LNX.4.02.10101170931540.20262-100000@prins.externet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Boszormenyi Zoltan wrote:

> Hi!
> 
> PF_RSSTRIM is not declared anywhere either in the linux-2.4.0 sources
> or in the 2.4.0-vmbigpatch.

[zozo@localhost kernel]$ tar xIf linux-2.4.0.tar.bz2
[zozo@localhost kernel]$ cd linux
[zozo@localhost linux]$ cat ../patches/2.4.0/2.4.0-vmpatch-15.1 | patch -p1
patching file `kernel/sysctl.c'
patching file `kernel/fork.c'
patching file `mm/filemap.c'
patching file `mm/memory.c'
patching file `mm/page_alloc.c'
patching file `mm/swap.c'
patching file `mm/vmscan.c'
patching file `include/linux/sysctl.h'
patching file `include/linux/swap.h'
patching file `include/linux/mm.h'
patching file `Documentation/sysctl/vm.txt'
[zozo@localhost linux]$ find . -type f | xargs grep PF_RSSTRIM
./mm/vmscan.c:		if (mm->rss > rss_limit && !(p->flags & PF_RSSTRIM)) {
./mm/vmscan.c:			p->flags |= PF_RSSTRIM;
./mm/vmscan.c:		p->flags &= ~PF_RSSTRIM;	
[zozo@localhost linux]$

Regards,
Zoltan Boszormenyi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
