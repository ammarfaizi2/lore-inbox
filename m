Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbULKMaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbULKMaT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 07:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbULKMaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 07:30:19 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:63920 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261486AbULKMaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 07:30:14 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
From: Steven Rostedt <rostedt@goodmis.org>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, emann@mrv.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1102750669.32041.8.camel@cmn37.stanford.edu>
References: <32950.192.168.1.5.1102529664.squirrel@192.168.1.5>
	 <1102532625.25841.327.camel@localhost.localdomain>
	 <32788.192.168.1.5.1102541960.squirrel@192.168.1.5>
	 <1102543904.25841.356.camel@localhost.localdomain>
	 <20041209093211.GC14516@elte.hu> <20041209131317.GA31573@elte.hu>
	 <1102602829.25841.393.camel@localhost.localdomain>
	 <1102619992.3882.9.camel@localhost.localdomain>
	 <20041209221021.GF14194@elte.hu>
	 <1102659089.3236.11.camel@localhost.localdomain>
	 <20041210111105.GB6855@elte.hu>
	 <1102731973.3228.8.camel@localhost.localdomain>
	 <1102750669.32041.8.camel@cmn37.stanford.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Sat, 11 Dec 2004 07:30:03 -0500
Message-Id: <1102768203.3480.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-10 at 23:37 -0800, Fernando Lopez-Lezcano wrote:

> Can't wait to try the patch, I don't have CONFI_PCI_MSI defined in the
> configurations I use. I've had problems with a network card (R8169
> driver) for a while (I think I reported it), the interrupts were being
> ignored. Hopefully the same problem...

Hi Fernando,

You may have the same problem but the patch I sent won't solve it.  My
patch only is a problem if you have CONFIG_PCI_MSI defined. But I'm sure
there exists other instances that threading hardirqs might not work
properly with other configurations. Send me your .config, and if I get
time I'll take a look. (also your /proc/cpuinfo might help).

Before you send this, make sure that it is the hardirqs that's the
problem. Switch to PREEMPT_DESKTOP and make sure hardirqs are not
threaded.  If the problem goes away, then this may be your problem. If
it does not, I'm afraid that it's something else, and you don't need to
send me anything.

-- Steve

