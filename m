Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129809AbQKDIir>; Sat, 4 Nov 2000 03:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131714AbQKDIii>; Sat, 4 Nov 2000 03:38:38 -0500
Received: from ares.ssi.bg ([195.138.149.70]:6916 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S131653AbQKDIiU>;
	Sat, 4 Nov 2000 03:38:20 -0500
Date: Sat, 4 Nov 2000 10:37:54 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
To: Andrea Arcangeli <andrea@suse.de>
cc: Josue Emmanuel Amaro <Josue.Amaro@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Value of TASK_UNMAPPED_SIZE on 2.4
In-Reply-To: <20001104015110.A32767@athlon.random>
Message-ID: <Pine.LNX.4.04.10011040953230.511-100000@u>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Sat, 4 Nov 2000, Andrea Arcangeli wrote:

> On Sat, Nov 04, 2000 at 01:09:42AM +0000, Julian Anastasov wrote:
> > 	Something like the attached old patch for 2.2. It is very
>
> It's not ok for 64bit archs.

	Agreed. I see very different definitions for TASK_UNMAPPED_BASE
and ELF_ET_DYN_BASE in all archs and I'm not a guru to make this patch
for all archs but everyone can see the idea. May be the signed int max
value is not suitable for users that need large brk allocations with
more than 2GB on 32bit, i.e. cur_task_unmapped_base is enough. Using
machines with this RAM size and more are already a common practice but
I'm not sure if this feature is so useful compared to the difficulties
to implement it for all archs.

> Andrea


Regards

--
Julian Anastasov <ja@ssi.bg>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
