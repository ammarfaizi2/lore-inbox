Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277290AbRJEApi>; Thu, 4 Oct 2001 20:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277294AbRJEAp2>; Thu, 4 Oct 2001 20:45:28 -0400
Received: from [195.223.140.107] ([195.223.140.107]:26874 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S277291AbRJEApO>;
	Thu, 4 Oct 2001 20:45:14 -0400
Date: Fri, 5 Oct 2001 02:45:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Context switch times
Message-ID: <20011005024526.E724@athlon.random>
In-Reply-To: <E15pFor-0004sC-00@fenrus.demon.nl> <200110042139.f94Ld5r09675@vindaloo.ras.ucalgary.ca> <20011004.145239.62666846.davem@redhat.com> <20011004175526.C18528@redhat.com> <9piokt$8v9$1@penguin.transmeta.com> <20011004164102.E1245@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011004164102.E1245@w-mikek2.des.beaverton.ibm.com>; from kravetz@us.ibm.com on Thu, Oct 04, 2001 at 04:41:02PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2001 at 04:41:02PM -0700, Mike Kravetz wrote:
> I know that running LMbench with 2 active tasks on an 8 CPU system
> results in those 2 tasks being 'round-robined' among all 8 CPUs.
> Prior analysis leads me to believe the reason for this is due to
> IPI latency.  reschedule_idle() chooses the 'best/correct' CPU for
> a task to run on, but before schedule() runs on that CPU another
> CPU runs schedule() and the result is that the task runs on a
> ?less desirable? CPU.  The nature of the LMbench scheduler benchmark

doesn't lmbench wakeup only via pipes? Linux uses the sync-wakeup that
avoids reschedule_idle in such case, to serialize the pipe load in the
same cpu.

Andrea
