Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbVBBXPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVBBXPM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 18:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbVBBXPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:15:10 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:13745 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S262502AbVBBXER
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:04:17 -0500
Message-Id: <200502022303.j12N3nZa002055@localhost.localdomain>
To: Peter Williams <pwil3058@bigpond.net.au>
cc: "Bill Huey (hui)" <bhuey@lnxw.com>, "Jack O'Quin" <joq@io.com>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature 
In-reply-to: Your message of "Thu, 03 Feb 2005 08:54:24 +1100."
             <42014C10.60407@bigpond.net.au> 
Date: Wed, 02 Feb 2005 18:03:49 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.197.207.111] at Wed, 2 Feb 2005 17:04:11 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>As Ingo said in an earlier a post, with a little ingenuity this problem 
>can be solved in user space.  The programs in question can be setuid 
>root so that they can set RT scheduling policy BUT have their 
>permissions set so that they only executable by owner and group with the 
>group set to a group that only contains those users that have permission 
>to run this program in RT mode.  If you wish to allow other users to run 
>the program but not in RT mode then you would need two copies of the 
>program: one set up as above and the other with normal permissions.

Just a reminder: setuid root is precisely what we are attempting to
avoid. 

>If you have the source code for the programs then they could be modified 
>to drop the root euid after they've changed policy.  Or even do the 

This is insufficient, since they need to be able to drop RT scheduling
and then reacquire it again later.

--p
