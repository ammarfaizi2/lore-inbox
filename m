Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262564AbTCISoj>; Sun, 9 Mar 2003 13:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262566AbTCISoj>; Sun, 9 Mar 2003 13:44:39 -0500
Received: from pop.gmx.de ([213.165.64.20]:35688 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262564AbTCISoi>;
	Sun, 9 Mar 2003 13:44:38 -0500
Message-Id: <5.2.0.9.2.20030309192837.00c95468@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Sun, 09 Mar 2003 19:59:50 +0100
To: rwhron@earthlink.net, linux-kernel@vger.kernel.org
From: Mike Galbraith <efault@gmx.de>
Subject: Re: scheduler starvation running irman with 2.5.64bk2
In-Reply-To: <20030309025015.GA2843@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:50 PM 3/8/2003 -0500, rwhron@earthlink.net wrote:
>irman triggers some odd behavior with 2.5.64bk2 on uniprocessor
>K6/2 475.  "ps aux" hasn't returned for a couple hours, though
>irman appears to be doing it's thing.  I haven't tried irman on smp.
>
>Time to run irman 3x.
>
>2.5.63                  4066 seconds
>2.5.63-mjb1             2993 seconds
>2.5.63-mm2-dline        2856 seconds
>2.5.64                  3473 seconds
>2.5.64bk2               ??

It _appears_ to be a valid test-case. I can reproduce this with 
2.5.64+combo and B2.  I can also influence it to behave.  (that doesn't 
mean that the scheduler changes are bust... could be that the test-case is 
doing something bad)

Q/indicator:  do you ever see ksoftirqd _wanting_ to run?  (set top SCHED_RR)

         -Mike 

