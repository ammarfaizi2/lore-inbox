Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262767AbVA1VPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbVA1VPB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 16:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVA1VPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 16:15:01 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:23517 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262767AbVA1VNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 16:13:17 -0500
Subject: Re: Real-time rw-locks (Re: [patch] Real-Time Preemption,
	-RT-2.6.10-rc2-mm3-V0.7.32-15)
From: Lee Revell <rlrevell@joe-job.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Ingo Molnar <mingo@elte.hu>, Esben Nielsen <simlo@phys.au.dk>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       mark_h_johnson@raytheon.com, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Shane Shrybman <shrybman@aei.ca>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <1106939910.14321.37.camel@lade.trondhjem.org>
References: <20041214113519.GA21790@elte.hu>
	 <Pine.OSF.4.05.10412271404440.25730-100000@da410.ifa.au.dk>
	 <20050128073856.GA2186@elte.hu>
	 <1106939910.14321.37.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 16:13:15 -0500
Message-Id: <1106946796.3705.20.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-28 at 11:18 -0800, Trond Myklebust wrote:
> In the NFS client code we may use rwsems in order to protect stateful
> operations against the (very infrequently used) server reboot recovery
> code. The point is that when the server reboots, the server forces us to
> block *all* requests that involve adding new state (e.g. opening an
> NFSv4 file, or setting up a lock) while our client and others are
> re-establishing their existing state on the server.

Hmm, when I was an ISP sysadmin I used to use this all the time.  NFS
mounts from the BSD/OS clients would start to act up under heavy web
server load and the cleanest way to get them to recover was to simulate
a reboot on the NetApp.  Of course Linux clients were unaffected, they
were just along for the ride ;-)

Lee

