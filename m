Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRAINad>; Tue, 9 Jan 2001 08:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131027AbRAINaX>; Tue, 9 Jan 2001 08:30:23 -0500
Received: from www.wen-online.de ([212.223.88.39]:25862 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129534AbRAINaD>;
	Tue, 9 Jan 2001 08:30:03 -0500
Date: Tue, 9 Jan 2001 14:29:03 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Andrew Morton <andrewm@uow.edu.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [testcase] madvise->semaphore deadlock 2.4.0
In-Reply-To: <3A5B00F4.55FB83FE@uow.edu.au>
Message-ID: <Pine.Linu.4.10.10101091412110.471-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Andrew Morton wrote:

> Mike Galbraith wrote:
> > 
> > Greetings,
> > 
> > While trying to configure ftpsearch, the process hangs while running
> > it's madvise confidence test below.  It appears to be taking a fault
> > in madvise_fixup_middle():atomic_add(2, &vma->vm_file->f_count) and
> > immediately deadlocking forever on mm->mmap_sem per IKD.  (Virgin 2.4.0
> > agrees)
> >
> 
> This should fix it.

Indeed it does.   (benchmark _that_ OS rags;)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
