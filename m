Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316620AbSFFBOt>; Wed, 5 Jun 2002 21:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316640AbSFFBOs>; Wed, 5 Jun 2002 21:14:48 -0400
Received: from blv-smtpout-01.boeing.com ([192.161.36.5]:38376 "EHLO
	blv-smtpout-01.boeing.com") by vger.kernel.org with ESMTP
	id <S316620AbSFFBOr>; Wed, 5 Jun 2002 21:14:47 -0400
From: Rick Bressler <bressler@mushroom.ca.boeing.com>
Message-Id: <200206060114.g561Eef04181@mushroom.ca.boeing.com>
Subject: Re: [PATCH] scheduler hints
To: rml@tech9.net (Robert Love)
Date: Wed, 5 Jun 2002 18:14:40 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1023324831.912.376.camel@sinai> from "Robert Love" at Jun 05, 2002 05:53:36 PM
Reply-To: Rick Bressler <rickb@mushroom.ca.boeing.com>
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We don't need a scheduler "hint" for this, though.  A big loud command
> "bind me to this processor!" would do fine, and in 2.5 we have that:
> 
> just have one of the tasks do:
> 
> 	sched_setaffinity(0, sizeof(unsigned long), 1);
> 	sched_setaffinity(other_guys_pid, sizeof(unsigned long), 1);
> 
> and both will be affined to CPU 1.

I think that in some ways they were trying to simplify the code.  It is
a bit more complicated to do well from user space.  You're talking
dozens to thousands of process pairs, and maybe dozens of CPU's.  I
think the idea was that the scheduler has a better idea of what CPU's
are least busy, where to put the processes and indeed should migrate
tasks as necessary.  I just does it in pairs.  Keep em together is the
idea, rather than keep them in any one specific place, thus the hint.

I note that Gerrit replied also and as I recall he is one of those ex
Sequent guys who really knows this stuff, so I'll bow out in favor of
the experts. :-)

-- 
+--------------------------------------------+ Rick Bressler
|Mushrooms and other fungi have several      | G-4781 (425)342-1554
|important roles in nature.  They help things| Pager 1-800-946-4646
|grow, they are a source of food, they       |         Pin: 1700898
|decompose organic matter and they           | bressler@mushroom.ca.boeing.com
|infect, debilitate and kill organisms.      | Linux: Because a PC is a
+--------------------------------------------+ terrible thing to waste.
