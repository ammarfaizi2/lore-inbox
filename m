Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130572AbRBKWbT>; Sun, 11 Feb 2001 17:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130600AbRBKWa7>; Sun, 11 Feb 2001 17:30:59 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:32253 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130572AbRBKWax>; Sun, 11 Feb 2001 17:30:53 -0500
Message-ID: <3A871252.45974FFF@uow.edu.au>
Date: Sun, 11 Feb 2001 22:29:38 +0000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Pavel Machek <pavel@suse.cz>,
        Tom Eastep <teastep@seattlefirewall.dyndns.org>,
        "Michael B. Trausch" <fd0man@crosswinds.net>,
        Josh Myer <jbm@joshisanerd.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift
In-Reply-To: <E14Rzyc-0004SB-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Hmm, I can make it loose 30 seconds in 12 seconds. Just cat
> > /etc/termcap. Vesafb does this kind of stuff. [Yes, 3 times slower
> > clock].
> 
> Why are interrupts being disabled for vesafb scrolling anyway ?

Console writes happen under spin_lock_irq(console_lock).

The only reason for this which I can see: the kernel
can call printk() from interrupt context.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
