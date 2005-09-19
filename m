Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVISUtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVISUtf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 16:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVISUtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 16:49:35 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:16856 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932171AbVISUtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 16:49:35 -0400
Subject: Re: 2.6.13-rt13 SMP crashes on boot
From: Steven Rostedt <rostedt@goodmis.org>
To: John Rigg <lk@sound-man.co.uk>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <E1EHQmY-0001MS-8L@localhost.localdomain>
References: <E1EHQmY-0001MS-8L@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 19 Sep 2005 16:49:15 -0400
Message-Id: <1127162955.5097.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

First, always CC Ingo on all issues related to the -rt patch.  Although
I think he's on vacation now, but even so, he will probably miss this
email.

On Mon, 2005-09-19 at 19:54 +0100, John Rigg wrote:
> I've been trying to get 2.6.13 with RT-preempt patch to run on my
> dual Opteron with debugging code (with CONFIG_PREEMPT_RT=y).
> It crashes on boot if I enable latency tracing in .config. This happens 
> with -rt13, -rt12, and -rt4 versions of the patch. Unfortunately it

What was the last release that it worked on?  If you could try older
releases, that would really help to know when the problem occurred.
Lots of things have gone on recently since -rt1 and it would help if we
can pin point when this happened, so we would have a good idea of what
happened.
	
> occurs before any logging, so I can't provide any log data.

Do you have a serial output? Or compile your network driver into the
kernel and turn on netconsole.  Usually when someone says "before any
logging", I think of before there's output to the screen. But your next
statements seems to show that that is not the case.

> The crash appears to happen just after drive hda is
> detected, while it's trying to mount my ext3 / filesystem (on hda7).
> The mount fails then the screen fills with a segfault message in an
> infinite loop:

This may just be a 64bit issue as well somewhere.

-- Steve


