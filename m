Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQJ3Pby>; Mon, 30 Oct 2000 10:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129064AbQJ3Pbo>; Mon, 30 Oct 2000 10:31:44 -0500
Received: from mailer3.bham.ac.uk ([147.188.128.54]:45753 "EHLO
	mailer3.bham.ac.uk") by vger.kernel.org with ESMTP
	id <S129086AbQJ3Pbe>; Mon, 30 Oct 2000 10:31:34 -0500
Date: Mon, 30 Oct 2000 15:31:25 +0000 (GMT)
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Possible critical VIA vt82c686a chip bug
In-Reply-To: <20001030162345.A5469@suse.cz>
Message-ID: <Pine.LNX.4.21.0010301526340.2576-100000@pc24.sr.bham.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000, Vojtech Pavlik wrote:

> I don't think so. If you check the code paths more closely, you'll see
> that the timer is used even in the fast TSC case, the error causes by
> too big 'count' variable propagates up to the TSC routine. That's where
> I started hunting for the bug.
> 
> So no, it wasn't a placebo effect. Put a printk() in the fix statement
> to see if it's triggered.

Mmmm.  Okay.  Maybe I fixed the 'wrong' place, but the place I 'fixed'
was in do_slow_gettimeoffset, which is inside #ifndef CONFIG_X86_TSC.

I'll compile with a printk in there at home tonight though.

*peers more closely*  Ho-ho.  I see.  There's one further down in the
timer interrupt itself.  Oops.  My bad.

Cheers,

Mark

-- 
+-------------------------------------------------------------------------+
Mark Cooke                  The views expressed above are mine and are not
Systems Programmer          necessarily representative of university policy
University Of Birmingham    URL: http://www.sr.bham.ac.uk/~mpc/
+-------------------------------------------------------------------------+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
