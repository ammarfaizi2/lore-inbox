Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266472AbRGFMHb>; Fri, 6 Jul 2001 08:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266467AbRGFMHV>; Fri, 6 Jul 2001 08:07:21 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:62653 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266473AbRGFMHK>;
	Fri, 6 Jul 2001 08:07:10 -0400
Message-ID: <3B45A9E5.218D55C4@mandrakesoft.com>
Date: Fri, 06 Jul 2001 08:07:01 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Ville Nummela <ville.nummela@mail.necsom.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: tasklets in 2.4.6
In-Reply-To: <7an16iy2wa.fsf@necsom.com> <3B4563D5.89A1ACA3@mandrakesoft.com> <3B45760D.6F99149C@mandrakesoft.com> <20010706135755.G2425@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Fri, Jul 06, 2001 at 04:25:49AM -0400, Jeff Garzik wrote:
> > Why does tasklet_trylock go away?
> 
> because the logic is different, that's perfectly ok. In short when irq
> are enabled and the TASKLET_STATE_SCHED bit is set, then the tasklet is
> also queued. That's the old cleaner and not buggy logic implemented by
> Alexey originally, it fixes the missed tasklet event in the other case
> mentioned in the other email. It is also more efficient.

nice :)

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
