Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264763AbUF3RzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbUF3RzO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 13:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266781AbUF3RzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 13:55:14 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:16355 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S264763AbUF3RxI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 13:53:08 -0400
Message-Id: <200406301752.i5UHqa1q011464@localhost.localdomain>
To: Jakub Jelinek <jakub@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK 
In-reply-to: Your message of "Wed, 30 Jun 2004 12:57:56 EDT."
             <20040630165756.GX21264@devserv.devel.redhat.com> 
Date: Wed, 30 Jun 2004 13:52:36 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [141.152.253.159] at Wed, 30 Jun 2004 12:53:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, Jun 30, 2004 at 12:32:03PM -0400, Paul Davis wrote:
>> >One thing to note is that NPTL defaults to PTHREAD_INHERIT_SCHED
>> >while LinuxThreads defaults to PTHREAD_EXPLICIT_SCHED.
>> >So, if you care about what scheduling created threads will have
>> >and want it to work with both NPTL and LinuxThreads, you want
>> >pthread_attr_setinheritsched (&attr, PTHREAD_*_SCHED);
>> >explicitely.
>> 
>> But since we always set the scheduling class explicitly, should the
>> inherited scheduler class make any difference?
>
>Of course.

i understand that in the context of "pthread_attr_*; pthread_create();",
but we use pthread_create() and then set scheduling class/priority
within the new thread. Why would INHERIT_SCHED affect that? Does it?
