Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262678AbUKXOJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbUKXOJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbUKXOHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:07:52 -0500
Received: from zeus.kernel.org ([204.152.189.113]:54735 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262678AbUKXNn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:43:58 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-9
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, LKML <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <20041124034520.GA12785@elte.hu>
References: <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>
	 <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
	 <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu>
	 <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu>
	 <20041123175823.GA8803@elte.hu>
	 <1101257903.13780.15.camel@krustophenia.net>
	 <20041124034520.GA12785@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Wed, 24 Nov 2004 08:33:24 -0500
Message-Id: <1101303204.32068.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 04:45 +0100, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:

> > 
> > The symptom is that CPU bound tasks like kernel compiles will starve
> > I/O bound tasks like evolution for a _long_ time.  If I have a kernel
> > build and external modules building at the same time and Evolution
> > goes to "Update message list...", it can sit and spin with a blank
> > message pane for a minute or two.  If I suspend the builds, the
> > message list renders immediately.
> 
> could you try the vanilla -rc2-mm2 kernel (with PREEMPT enabled), does
> it behave in such a way too? At first sight this could be a property of
> the upstream scheduler, but maybe it's special to PREEMPT_RT.
> 

Have you notice this behavior with other interactive (I/O) tasks, such
as bash.  Evolution is quite a big utility, and might be doing something
in the background. If you see the same behavior with bash then there is
no doubt that the compile is slowing down an I/O intensive task.

Another variable can be memory. Are you running this on something with
adequate memory, or is you harddrive churning like mad and you're
constantly thrashing the swap space?
 
-- Steve

