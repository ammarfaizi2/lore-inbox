Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S157153AbPJLSAe>; Tue, 12 Oct 1999 14:00:34 -0400
Received: by vger.rutgers.edu id <S157074AbPJLR6q>; Tue, 12 Oct 1999 13:58:46 -0400
Received: from colorfullife.com ([216.156.138.34]:4310 "EHLO colorfullife.com") by vger.rutgers.edu with ESMTP id <S157053AbPJLRxl>; Tue, 12 Oct 1999 13:53:41 -0400
Message-ID: <380375A4.B5887095@colorfullife.com>
Date: Tue, 12 Oct 1999 19:53:40 +0200
From: Manfred Spraul <manfreds@colorfullife.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: viro@math.psu.edu, linux-kernel@vger.rutgers.edu, linux-mm@kvack.org
Subject: Re: vma_list_sem
References: <Pine.LNX.4.10.9910121943300.17128-100000@clmsdevli>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

manfreds wrote:
> I found one more find_vma() caller which performs no locking:
> fs/super.c: copy_mount_options().
> 
I overlooked a stupid bug in copy_mount_options(), it can return without
releasing the mm semaphore.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
