Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129221AbQKLBhX>; Sat, 11 Nov 2000 20:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129265AbQKLBhN>; Sat, 11 Nov 2000 20:37:13 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:24743 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129221AbQKLBhA>; Sat, 11 Nov 2000 20:37:00 -0500
Message-ID: <3A0DF347.43807CB5@uow.edu.au>
Date: Sun, 12 Nov 2000 12:32:55 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jasper Spaans <jasper@spaans.ds9a.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11pre2-ac1 and previous problem
In-Reply-To: <Pine.LNX.4.30.0011101806140.29502-100000@tfuj.ahoj.pl> <3A0C91DC.97693969@uow.edu.au>,
		<3A0C91DC.97693969@uow.edu.au>; from andrewm@uow.edu.au on Sat, Nov 11, 2000 at 11:25:00AM +1100 <20001111162750.A1031@spaans.ds9a.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jasper Spaans wrote:
> 
> On Sat, Nov 11, 2000 at 11:25:00AM +1100, Andrew Morton wrote:
> 
> > > NMI Watchdog detected LOCKUP on CPU3, registers:
> 
> > Oh no.  Another one.  Could you please try this attached
> > patch (against test11-pre2) and see if the diagnostics
> > come out?
> 
> And yet another one... I applied your patch, and ran my oopses through
> ksymoops, results attached.
> 
> Kernel: 2.4.0-test11-pre2 + reiserfs-3.6.18
> 2 * P-II 350, 256 MB RAM, no special hardware, AFAIK.
> 
> Of course, more details are available.

That's a pretty wierd trace.  You seem to have addresses related
to the `apm' kernel thread on mysqld's stack.

Are you saying that your machine is getting NMI lockups but
it is not usually able to print the register and stack
dumps? (ie: a printk deadlock)?

Do they go away if you disable APM?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
