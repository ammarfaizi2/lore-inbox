Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132726AbRDILh2>; Mon, 9 Apr 2001 07:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132727AbRDILhS>; Mon, 9 Apr 2001 07:37:18 -0400
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:25121 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S132726AbRDILhO>; Mon, 9 Apr 2001 07:37:14 -0400
Message-ID: <3AD19EDF.5959BF92@stud.uni-saarland.de>
Date: Mon, 09 Apr 2001 11:37:03 +0000
From: Studierende der Universitaet des Saarlandes 
	<masp0008@stud.uni-sb.de>
Reply-To: manfred@colorfullife.com
Organization: Studierende Universitaet des Saarlandes
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: acahalan@cs.uml.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: softirq buggy
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'd prefer to inline cpu_is_idle(), but optimizing the idle 
> >code path is probably not that important ;-) 
>
> Sure it is, in one way: how fast can you get back to work? 
> (not OK to take a millisecond getting out of the idle loop) 

2 short function calls instead of 2 "if(current->need_resched)" on the
way out.

I didn't try very hard to fix the inline dependencies, could you try to
move cpu_is_idle() from kernel/sched.c into <linux/pm.h>?

I'm sure it won't be more difficult than the last "Athlon+SMP doesn't
compile" problem ;-)

--
	Manfred
