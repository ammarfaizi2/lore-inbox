Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266786AbUF3Rus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266786AbUF3Rus (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 13:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266788AbUF3Rus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 13:50:48 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:35007 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S266781AbUF3Rui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 13:50:38 -0400
Message-Id: <200406301750.i5UHo3FN011419@localhost.localdomain>
To: Ulrich Drepper <drepper@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK 
In-reply-to: Your message of "Wed, 30 Jun 2004 10:07:08 PDT."
             <40E2F33C.90106@redhat.com> 
Date: Wed, 30 Jun 2004 13:50:03 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [141.152.253.159] at Wed, 30 Jun 2004 12:50:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> this has me thinking. one of the major changes with NPTL is that all
>> threads share the same PID. so how in the world do we ever set the
>> scheduling policy of a single thread (as opposed to something
>> identified by a pid_t) to SCHED_FIFO?
>
>If you have to ask this question than it's no wonder you get erratic
>behavior.  It means you haven't looked at the pthread interface at all.

thanks, i appreciate the ad hominem remarks. you think we could ever
get SCHED_FIFO if we were not familiar with these calls? this is
really unnecessary...

my question wasn't about the pthread API. it was about what kernel API
was used to implement it. the simple answer would have been that we
use the TID, not the PID, or to have just pointed me at the source.

>And use a recent enough nptl version.   Very early versions didn't have
>any of the scheduler handling implemented.

we already discovered that. the people testing this stuff are using
the most recent "stable" release of glibc, for the most part.

--p
