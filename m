Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312524AbSDEMeB>; Fri, 5 Apr 2002 07:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312529AbSDEMdv>; Fri, 5 Apr 2002 07:33:51 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:41407 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S312524AbSDEMdh>; Fri, 5 Apr 2002 07:33:37 -0500
Date: Fri, 5 Apr 2002 14:33:29 +0200 (MEST)
From: Erich Focht <focht@ess.nec.de>
To: Andi Kleen <ak@suse.de>
cc: Erich Focht <efocht@ess.nec.de>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] O(1) scheduler: lockup with set_cpus_allowed
In-Reply-To: <20020405132149.A16807@wotan.suse.de>
Message-ID: <Pine.LNX.4.21.0204051430300.10372-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002, Andi Kleen wrote:

> You could just use get_task_struct/free_task_struct and drop the read lock
> to make sure the target doesn't go way

Thanks! That solves my problem. So maybe Ingo just extends the comment to
set_cpus_allowed() to warn from holding the tasklist_lock such that others
don't run into the same problem.

Regards,
Erich


