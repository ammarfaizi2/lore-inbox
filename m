Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318910AbSG1Fgz>; Sun, 28 Jul 2002 01:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318909AbSG1Fgz>; Sun, 28 Jul 2002 01:36:55 -0400
Received: from mail.webmaster.com ([216.152.64.131]:31710 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S318906AbSG1Fgz> convert rfc822-to-8bit; Sun, 28 Jul 2002 01:36:55 -0400
From: David Schwartz <davids@webmaster.com>
To: <rusty@rustcorp.com.au>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1055) - Licensed Version
Date: Sat, 27 Jul 2002 22:40:00 -0700
In-Reply-To: <20020725163239.6c6e5ed6.rusty@rustcorp.com.au>
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020728054010.AAA25979@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>NOT waittimeofday.  You need a *new* measure which can't be set forwards
>or back if you want this to be sane.  pthreads has absolute timeouts (eg.
>pthread_cond_timedwait), but they suck IRL for this reason.

>Rusty.

	The usual way to deal with this is to have a 'clock watcher' thread. If the 
system time jumps any significant amount, you signal all condition variables. 
You're not guaranteed any particular latency anyway.

	I don't think a DVD playback skipping when the system time is changed by a 
large amount is unacceptable. However, the use of some sort of linear 
timebase is much more convenient for many things.

	DS


