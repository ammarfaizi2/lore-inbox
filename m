Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263521AbTDTDjZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 23:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTDTDjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 23:39:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:22042 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263521AbTDTDjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 23:39:24 -0400
Message-Id: <5.2.0.9.2.20030420054147.01fa78d0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Sun, 20 Apr 2003 05:55:50 +0200
To: Nick Piggin <piggin@cyberone.com.au>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
Cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3E88024D.5000604@cyberone.com.au>
References: <5.2.0.9.2.20030331085710.01aa6d30@pop.gmx.net>
 <5.2.0.9.2.20030331033120.00cf0d08@pop.gmx.net>
 <20030330141404.GG917@suse.de>
 <3E8610EA.8080309@telia.com>
 <1048992365.13757.23.camel@localhost>
 <20030330141404.GG917@suse.de>
 <5.2.0.9.2.20030331033120.00cf0d08@pop.gmx.net>
 <5.2.0.9.2.20030331085710.01aa6d30@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:54 PM 3/31/2003 +1000, Nick Piggin wrote:


>Mike Galbraith wrote:
>
>>At 08:35 AM 3/31/2003 +0200, Jens Axboe wrote:
>>
>>>What drugs are you on? 2.5.65/66 is the worst interactive kernel I've
>>>ever used, it would be _embarassing_ to release a 2.6-test with such a
>>>rudimentary flaw in it. IOW, a big show stopper.
>>
>>
>>It's only horrible when you trigger the problems, otherwise it's wonderful.
>
>Heh heh, yeah the anticipatory io scheduler is like that too ;)

I gave 2.5.67-mm4 a go yesterday, and let it fsck my old 10gig ext3-ified 
source partition (1k bs, 333k files).  MAJOR improvement over deadline for 
this job.  With the deadline scheduler, it takes 30 minutes to fsck this 
partition, and when pdflush starts it's dinky little writes, it sounds like 
the heads are about to fly through the chassis.  The anticipatory scheduler 
cuts fsck time in half, and the disk is no longer screams in (seek) 
agony.  15 minutes still seems like ages when you're waiting, but it beats 
the HECK out of 30 minutes :)  Nice work.

         -Mike 

