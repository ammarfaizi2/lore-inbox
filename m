Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbTCNJrN>; Fri, 14 Mar 2003 04:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261683AbTCNJrN>; Fri, 14 Mar 2003 04:47:13 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:7081 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S261559AbTCNJrL>; Fri, 14 Mar 2003 04:47:11 -0500
Message-ID: <20030314095751.5909.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: cb-lkml@fish.zetnet.co.uk, linux-kernel@vger.kernel.org
Date: Fri, 14 Mar 2003 10:57:51 +0100
Subject: Re: 2.5.64-mm6, a new test case for scheduler interactivity problems
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Charles Baylis <cb-lkml@fish.zetnet.co.uk> 
Date: 	Thu, 13 Mar 2003 22:01:02 +0000 
To: linux-kernel@vger.kernel.org 
Subject: 2.5.64-mm6, a new test case for scheduler interactivity problems 
 
> I've just installed 2.5.64-mm6, and I've tried out the new improved  
> scheduler and it's definately not there yet. I can easily cause ogg  
> playback to skip (for example) by changing virtual desktop in windowmaker  
> to busy konqueror window. X is not reniced (has a nice level of 0) 
 
I cannot reproduce your problems... same scenario: 2.5.64-mm6, 
KDE desktop, XFree86 4.3.0 (no nice). 
 
> My experience suggests that skips occur when more than one interactive task  
> starts to become a CPU hog, for example X and konqueror can be idle for  
> long periods, and so become interactive, but during an intensive redraw  
> they briefly behave as CPU hogs but maintain their interactive bonus this  
> means that ogg123 has to wait until the hogs complete their timeslice  
> before being scheduled. 
 
Can't reproduce... 
 
> My test case tries to reproduce this by creating a number of tasks which  
> alternate between being 'interactive' and CPU hogs. On my Celery 333 laptop  
> it can sometimes cause skips with only 1 child, and is pretty much  
> guaranteed to cause skips with more child tasks. 
 
I have a Pentium III Mobile 700 Mhz, anyways... 
 
> To compile use 'gcc -o thud thud.c' 
>  
> To reproduce, I: 
> run ogg123 somefile.ogg in one xterm 
> run ./thud 1 in another xterm 
 
No ways... I start ogg123 to reproduce a very long file and then, 
launched ./thud 20 (yes, 20, but I also tried with 2 and 1), but 
ogg123 doesn't skip. No way, I can't make it skip. 
 
Try doing 
 
echo 50 > /proc/sys/sched/max_timeslice 
 
and see if it helps. 
Thanks! 
 
   Felipe 
 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
