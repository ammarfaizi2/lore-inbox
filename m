Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272839AbRIGUhv>; Fri, 7 Sep 2001 16:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272840AbRIGUhl>; Fri, 7 Sep 2001 16:37:41 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:5947 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272839AbRIGUha>; Fri, 7 Sep 2001 16:37:30 -0400
Subject: Re: Trouble with update Preemptive patch for 2.4.9-ac9
From: Robert Love <rml@tech9.net>
To: Stephen Frost <sfrost@snowman.net>
Cc: Jordan Breeding <ledzep37@home.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010907072357.A11136@ns>
In-Reply-To: <3B985287.2385275B@home.com> <999839075.865.7.camel@phantasy> 
	<20010907072357.A11136@ns>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.05.07.08 (Preview Release)
Date: 07 Sep 2001 16:37:50 -0400
Message-Id: <999895073.2127.5.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-09-07 at 07:23, Stephen Frost wrote:
> 	If you need a guinea pig for testing it on SMP I may be willing
> 	to do that on one of my SMP machines. :)  Let me know, I'll need
> 	to do some setup work (attaching and setting up a serial
> 	console, testing the machine without the patch to make sure it's
> 	mostly happy, etc).

I would certainly take you up on that offer.  I honestly don't think the
patch is ready for SMP, yet -- but we have to start somewhere.

apply the patch and set CONFIG_SMP and CONFIG_PREEMPT to 'y' and let it
run.  Any errors, OOPS, etc, pass them this way.

Unfortunately, if the patch fails, its going to fall hard.  If the
preemption is imperfect during SMP, certainly you will hardlock.

It might help to enable CONFIG_DEBUG_SPINLOCKS and
CONFIG_DEBUG_BUGVERBOSE -- these are present in the -ac tree.  The NMI
watchdog might prove useful, too.

But honestly, just telling me it locks on boot is useful, so whatever
you can manage.

I appreciate any help.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

