Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310827AbSCHMeo>; Fri, 8 Mar 2002 07:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310828AbSCHMeg>; Fri, 8 Mar 2002 07:34:36 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:20959 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S310827AbSCHMeX>; Fri, 8 Mar 2002 07:34:23 -0500
Date: Fri, 8 Mar 2002 14:19:34 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH][2.5] BUG check in elevator.c:237
In-Reply-To: <Pine.LNX.4.44.0203081350190.5383-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0203081417180.5383-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002, Zwane Mwaikambo wrote:

> > However for cd-rom there are commands, which can
> > take quite a long time. Therefore there is the possiblity there
> > to provide a polling function, which will be engaged after the
> > interrupt happens in the above function:
> 
> So are you suggesting perhaps that we change the request servicing to 
> polling? I'm a bit confused as to how this would fit in with 
> cdrom_decode_status (which in this case is called from the read_intr).

Ok how about the scenario i'm seeing. The cdrom is spewing constant I/O 
errors and we go and check on these, they are actually _not_ in fact 
taking a long time and actually preempting each other! Looking at the 
code and the usage of ide_preempt, my guess is that checking the status is 
a higher priority hence the queue jumping. How can we use a timer for this 
one?

Thanks,
	Zwane


