Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbULAQIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbULAQIS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 11:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbULAQIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 11:08:18 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:23714 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S261295AbULAQFw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 11:05:52 -0500
Message-Id: <200412011605.iB1G5mRT009267@localhost.localdomain>
To: Ingo Molnar <mingo@elte.hu>
cc: Florian Schmidt <mista.tapas@gmx.net>, Rui Nuno Capela <rncbc@rncbc.org>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2 
In-reply-to: Your message of "Wed, 01 Dec 2004 16:53:53 +0100."
             <20041201155353.GA30193@elte.hu> 
Date: Wed, 01 Dec 2004 11:05:48 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [141.151.23.119] at Wed, 1 Dec 2004 10:05:51 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>your point is correct, the best way to have a system-wide namespace for
>synchronization objects is ... the filesystem hierarchy. If you create a
>unix domain socket then you can distribute your pipe fds, but that's
>indeed somewhat painful.

this is where Mach ports come in. they were designed to be passed
around from process to process, painlessly, but without any system
wide namespace. you can create ports that can be looked up by anyone,
but not all ports are required meet this condition. this makes it easy
to set up a private communication channel between two processes.

a bit like futexes :)

--p

