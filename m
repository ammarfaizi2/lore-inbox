Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbRBLL3x>; Mon, 12 Feb 2001 06:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129142AbRBLL3n>; Mon, 12 Feb 2001 06:29:43 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:23282 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129107AbRBLL3h>; Mon, 12 Feb 2001 06:29:37 -0500
Message-ID: <3A87CB3B.B05C03B5@uow.edu.au>
Date: Mon, 12 Feb 2001 22:38:35 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Pavel Machek <pavel@suse.cz>,
        Tom Eastep <teastep@seattlefirewall.dyndns.org>,
        "Michael B. Trausch" <fd0man@crosswinds.net>,
        Josh Myer <jbm@joshisanerd.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift
In-Reply-To: <20010212113213.B235@bug.ucw.cz> from "Pavel Machek" at Feb 12, 2001 11:32:13 AM <E14SGLm-0006es-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > >                     queued_writes=1;
> > >                     return;
> > >             }
> > >     }
> >
> > Unfortunately, that means that if machine crashes in interrupt, it may
> > "loose" printk message. That is considered bad (tm).
> 
> The alternative is that the machine clock slides continually and the machine
> is unusable. This is considered even worse by most people

Neither.  I was going to dust off my enhanced "bust_spinlocks"
patch which sets a little flag when we're doing an
oops, BUG(), panic() or die().  If the flag
is set, printk() just punches through the lock.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
