Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbULJSE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbULJSE4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 13:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbULJSEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 13:04:55 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:21890 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261777AbULJSC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 13:02:28 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
From: Steven Rostedt <rostedt@goodmis.org>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>, emann@mrv.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <41B9CFB9.5070503@cybsft.com>
References: <32950.192.168.1.5.1102529664.squirrel@192.168.1.5>
	 <1102532625.25841.327.camel@localhost.localdomain>
	 <32788.192.168.1.5.1102541960.squirrel@192.168.1.5>
	 <1102543904.25841.356.camel@localhost.localdomain>
	 <20041209093211.GC14516@elte.hu> <20041209131317.GA31573@elte.hu>
	 <1102602829.25841.393.camel@localhost.localdomain>
	 <1102619992.3882.9.camel@localhost.localdomain>
	 <20041209221021.GF14194@elte.hu>
	 <1102659089.3236.11.camel@localhost.localdomain>
	 <20041210111105.GB6855@elte.hu>  <41B9CFB9.5070503@cybsft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Fri, 10 Dec 2004 13:02:08 -0500
Message-Id: <1102701728.3325.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-10 at 10:32 -0600, K.R. Foley wrote:

> >>I have a (from lspci) 
> >>0000:02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M
> >>[Tornado] (rev 78)
> >>
> >>
> 

<snip> 

> I actually have this same card in the system I am sending this from 
> currently running 2.6.10-rc2-mm3-V0.7.32-12 #15 SMP.

I have a dual Athlon MP system with Tyan S2466N4 Motherboard. It looks
more of a problem with the interrupt controller.  I downloaded -17 and
tried that, but now it hangs on starting up cups and the last message
from the kernel is:

lp0: using parport0 (interrupt-driven).

It looks like a pretty bad lock up, since I know exactly when it happens
since the cursor stops blinking.

I'm right now compiling the PREEMPT_DESKTOP kernel to see if that gives
me the same problems.

-- Steve

