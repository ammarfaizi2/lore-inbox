Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWCLDqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWCLDqp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 22:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWCLDqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 22:46:45 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:59360 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751305AbWCLDqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 22:46:44 -0500
Subject: Re: can I bring Linux down by running "renice -20
	cpu_intensive_process"?
From: Lee Revell <rlrevell@joe-job.com>
To: Luke-Jr <luke@dashjr.org>
Cc: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200603120141.08129.luke@dashjr.org>
References: <441180DD.3020206@wpkg.org>
	 <Pine.LNX.4.61.0603101540310.23690@yvahk01.tjqt.qr>
	 <yw1xbqwe2c2x.fsf@agrajag.inprovide.com>
	 <200603120141.08129.luke@dashjr.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 11 Mar 2006 22:46:42 -0500
Message-Id: <1142135202.25358.50.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-12 at 01:41 +0000, Luke-Jr wrote:
> On Friday 10 March 2006 22:01, Måns Rullgård wrote:
> > Sysrq+n changes all realtime tasks to normal priority.
> 
> Would the kernel's main loop (where I presume Sysreq is handled) get a chance 
> to run with a constantly busy realtime task?

No, other tasks will not get to run at all.  A SCHED_FIFO task that
spins forever is a fatal bug.  Making it less dangerous would require
making it less useful.

Lee

