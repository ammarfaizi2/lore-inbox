Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266768AbUHIRIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266768AbUHIRIU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 13:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266764AbUHIRIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 13:08:20 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:26859 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266749AbUHIRF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 13:05:59 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040809190201.64dab6ea@mango.fruits.de>
References: <1090795742.719.4.camel@mindpipe>
	 <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe>
	 <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe>
	 <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu>
	 <20040809190201.64dab6ea@mango.fruits.de>
Content-Type: text/plain
Message-Id: <1092071169.13668.23.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 09 Aug 2004 13:06:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 13:02, Florian Schmidt wrote:

> I don't use APIC, since it never worked good for me.. But i wanted to
> report that the mlockall latency still seems to be there.. I can easily
> trigger it with mlockall'ing > ~10000kb. Need to recompile with the
> preempt-timing patch, but here's an xrun trace that happened when
> mlockall'ing 20000kb:
> 

Ingo, do you plan to maintain the voluntary preempt patch against the
-mm series?  From looking at Andrew's announcement yesterday it looks
like many latency issues fixed in the voluntary preemption patches are
also fixed in -mm, so it seems like the patch would be much smaller. 
One thing that might be useful is breaking out the irq threading code as
a patch against -mm.  Judging from all the -mm latency fixes it seems
like this would work as well as the vanilla kernel+voluntary preempt.

This would also make it easier to identify which are the important
latency fixes from -mm enabling them to be pushed into mainline sooner. 
On some of my tests I got 10-20% better results using vol-preempt+mm vs
vol-preempt+vanilla, it would be nice to identify what changes are
responsible.

Lee



