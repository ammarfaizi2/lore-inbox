Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277309AbRJEEh0>; Fri, 5 Oct 2001 00:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277310AbRJEEhR>; Fri, 5 Oct 2001 00:37:17 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:60354 "EHLO
	e32.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277309AbRJEEg7>; Fri, 5 Oct 2001 00:36:59 -0400
Date: Thu, 4 Oct 2001 21:35:07 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Context switch times
Message-ID: <20011004213507.B1032@w-mikek2.sequent.com>
In-Reply-To: <E15pFor-0004sC-00@fenrus.demon.nl> <200110042139.f94Ld5r09675@vindaloo.ras.ucalgary.ca> <20011004.145239.62666846.davem@redhat.com> <20011004175526.C18528@redhat.com> <9piokt$8v9$1@penguin.transmeta.com> <20011004164102.E1245@w-mikek2.des.beaverton.ibm.com> <20011005024526.E724@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011005024526.E724@athlon.random>; from andrea@suse.de on Fri, Oct 05, 2001 at 02:45:26AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 02:45:26AM +0200, Andrea Arcangeli wrote:
> doesn't lmbench wakeup only via pipes? Linux uses the sync-wakeup that
> avoids reschedule_idle in such case, to serialize the pipe load in the
> same cpu.

That's what I thought too.  However, kernel profile data of a
lmbench run on 2.4.10 reveals that the pipe routines only call
the non-synchronous form of wake_up.  I believe I reached the
same conclusion in the 2.4.7 time frame by instrumenting this
code.

-- 
Mike
