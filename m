Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278416AbRJMV1i>; Sat, 13 Oct 2001 17:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278415AbRJMV12>; Sat, 13 Oct 2001 17:27:28 -0400
Received: from [202.135.142.194] ([202.135.142.194]:52749 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S278418AbRJMV1U>; Sat, 13 Oct 2001 17:27:20 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Paul E. McKenney" <pmckenne@us.ibm.com>
Cc: torvalds@transmeta.com (Linus Torvalds), dipankar@in.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion ^M 
In-Reply-To: Your message of "Sat, 13 Oct 2001 09:28:15 PDT."
             <200110131628.f9DGSGW09534@eng4.beaverton.ibm.com> 
Date: Sun, 14 Oct 2001 07:23:11 +1000
Message-Id: <E15sWFT-0005tf-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200110131628.f9DGSGW09534@eng4.beaverton.ibm.com> you write:
> OK, here is an RFC patch with the read_barrier_depends().  (I know that
> the indentation is messed up, will fix when I add the read_barrier()
> and friends).

Yep, this is a 2.5 thing: we should probably combine change the
barriers so read_barrier et. al. only have effect on SMP, and then
have io_read_barrier for IO (these can be usefully differentiated on
PPC IIUC).

The stillborn smp_mb() etc. can then be abandoned.

Rusty.
--
Premature optmztion is rt of all evl. --DK
