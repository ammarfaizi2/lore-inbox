Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132581AbRDEJHf>; Thu, 5 Apr 2001 05:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132580AbRDEJHZ>; Thu, 5 Apr 2001 05:07:25 -0400
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:55895 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S132581AbRDEJHK>; Thu, 5 Apr 2001 05:07:10 -0400
Message-ID: <3ACC358C.E86D9478@stud.uni-saarland.de>
Date: Thu, 05 Apr 2001 09:06:20 +0000
From: Studierende der Universitaet des Saarlandes 
	<masp0008@stud.uni-sb.de>
Reply-To: manfred@colorfullife.com
Organization: Studierende Universitaet des Saarlandes
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: f.v.heusden@ftr.nl
CC: linux-kernel@vger.kernel.org
Subject: RE: random PIDs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Finished & tested my random PID kernel/fork.c:get_pid() replacement. 
> > This one keeps track of the last N (default is 64) pids who have exited. 
> > These are then not used. So, one cannot have more then 32767 - (64 + 1 
> > (init) + 1 (idle)) = 32761 processes :o) 
> DW> Huh, should be 32701, right?! 
> 
> You're absolutely right. It must've been the victory trance :o) 
>
Have you actually tried to create lots of threads?

IIRC get_pid will loop forever if it doesn't find a free pid, and in the
worst case you can trigger that with ~11000 running threads.

And the current code can create multiple threads with the same pid (I
never tried to trigger that bug, but it seems to be possible)

--
	Manfred
