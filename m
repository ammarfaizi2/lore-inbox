Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVADVjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVADVjP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVADVii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:38:38 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:60097 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262008AbVADVhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:37:20 -0500
Subject: Re: Real-Time Preemption, comparison to 2.6.10-mm1
From: Lee Revell <rlrevell@joe-job.com>
To: Mark_H_Johnson@raytheon.com
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Bill Huey <bhuey@lnxw.com>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <OF57960072.EA98312D-ON86256F7F.006EF463-86256F7F.006EF501@raytheon.com>
References: <OF57960072.EA98312D-ON86256F7F.006EF463-86256F7F.006EF501@raytheon.com>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 16:37:16 -0500
Message-Id: <1104874637.8850.3.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 14:11 -0600, Mark_H_Johnson@raytheon.com wrote:
> The non RT application starvation for mm1 was much less
> pronounced but still present. I could watch the disk light
> on the last two tests & see it go out (and stay out) for an
> extended period. It does not make sense to me that a single RT
> application (on a two CPU machine) and a nice'd non RT application
> can cause this starvation behavior. This behavior was not
> present on the 2.4 kernels and seems to be a regression to me.

I think I am seeing this problem too.  It doesn't just apply to RT
tasks, it seems that CPU bound tasks starve each other.  I noticed that
with the RT kernel, a kernel compile or dpkg will starve evolution, to
the point where it takes 30 seconds to display a message.  If I go and
background the CPU hog, the message renders _instantly_.

It's definitely present with 2.6.10-rc2 + RT (PK config) and absent with
2.6.10 vanilla.  I need to figure out whether -mm has the problem.

Lee

