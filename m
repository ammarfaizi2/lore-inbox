Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130399AbRASUc6>; Fri, 19 Jan 2001 15:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131353AbRASUct>; Fri, 19 Jan 2001 15:32:49 -0500
Received: from gateway.sequent.com ([192.148.1.10]:31109 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S130399AbRASUcj>; Fri, 19 Jan 2001 15:32:39 -0500
Date: Fri, 19 Jan 2001 12:32:30 -0800
From: Mike Kravetz <mkravetz@sequent.com>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: multi-queue scheduler update
Message-ID: <20010119123230.F26968@w-mikek.des.sequent.com>
In-Reply-To: <20010119091104.A26968@w-mikek.des.sequent.com> <LYR76657-5332-2001.01.19-12.12.38--mikek#sequent.com@lyris.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <LYR76657-5332-2001.01.19-12.12.38--mikek#sequent.com@lyris.sequent.com>; from hahn@coffee.psychology.mcmaster.ca on Fri, Jan 19, 2001 at 03:12:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 03:12:11PM -0500, Mark Hahn wrote:
> > incurred in the current implementation.  To maintain existing
> > scheduler behavior, we look at all CPU specific runqueues to find
> > the highest priority (goodness) task in the system.  Therefore,
> 
> do you have cpu-affinity?  the mainstream scheduler at one time
> actually tuned the decision to move a task based on its expected
> timeslice and the worstcase cache-flush time.

We use the same same cpu-affinity mechanism as the current scheduler.
This simply gives a 'priority boost' to tasks that last ran on the
current CPU.  In our multi-queue scheduler, tasks on a remote queue
must have high enough priority (to overcome this boost) before being
moved to the local queue.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
15450 SW Koll Parkway
Beaverton, OR 97006-6063                     (503)578-3494
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
