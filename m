Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbTLQRy4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 12:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbTLQRy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 12:54:56 -0500
Received: from sow.visionpro.com ([63.91.95.5]:19464 "EHLO sow.visionpro.com")
	by vger.kernel.org with ESMTP id S264505AbTLQRyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 12:54:53 -0500
Message-ID: <F8E34394F337C74EA249580DEE7C240C28C3D1@chicken.machinevisionproducts.com>
From: "Brian D. McGrew" <brian@visionpro.com>
To: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: 
Date: Wed, 17 Dec 2003 09:50:34 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

I'm hoping that someone can help me out here just a bit.  I somehow need to
accomplish two tasks that I'm sure are somewhat trivial yet just out my
conceptual grasp!

I'm trying to get the scheduling figured out so that I can get/set the
priority and schedule of pthreads.  The below excerpt is the code I use.
Now, on Solaris (which is where I've been for years) it of course works
fine.  However, being new to Linux, I couldn't make it work and therefore
had to come up with a work around.  It seems the on Linux the scheduler is
just ignoring my parameters and options.  My code looks like:

#ifdef LINUX
    struct sched_param grabber_sched_param = { SCHED_RR };
    struct sched_param examine_sched_param = { 0 };
#else
    struct sched_param grabber_sched_param = { SCHED_RR, 0, 0 };
    struct sched_param examine_sched_param = { 0, 0, 0 };
#endif

As I said, on Solaris (sparc) this works just fine by on Linux, when we
call:

pthread_setschedparam(_grabber_id, policy, &grabber_sched_param);

It seems like nothing happens and everything is ignored.  Any ideas?

Also, on a (maybe) separate note, how do I go about increasing the system
stack size.  We have several programs that 'chain' together and right now on
Linux this isn't working becuase we're running out of stack space.  Again,
works fine on Solaris.  

Can someone sched some light on this for me?

Thanks so much in advance,

-brian

Brian D. McGrew {brian@visionpro.com || brian@doubledimension.com }
--
> My job is so secret ... I don't know what I do!

