Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbVISUyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbVISUyF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 16:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVISUyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 16:54:04 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:52436
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932464AbVISUyA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 16:54:00 -0400
Subject: Re: 2.6.13-rt13 SMP crashes on boot
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Cc: John Rigg <lk@sound-man.co.uk>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1127162955.5097.25.camel@localhost.localdomain>
References: <E1EHQmY-0001MS-8L@localhost.localdomain>
	 <1127162955.5097.25.camel@localhost.localdomain>
Content-Type: text/plain
Organization: linutronix
Date: Mon, 19 Sep 2005 22:54:04 +0200
Message-Id: <1127163244.24044.237.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 16:49 -0400, Steven Rostedt wrote:
> Hi John,
> 
> First, always CC Ingo on all issues related to the -rt patch.  Although
> I think he's on vacation now, but even so, he will probably miss this
> email.
> 
> On Mon, 2005-09-19 at 19:54 +0100, John Rigg wrote:
> > I've been trying to get 2.6.13 with RT-preempt patch to run on my
> > dual Opteron with debugging code (with CONFIG_PREEMPT_RT=y).
> > It crashes on boot if I enable latency tracing in .config. This happens 
> > with -rt13, -rt12, and -rt4 versions of the patch. Unfortunately it

Do you have high resolution timers turned on ?

If yes, there is a SMP bug in -rt13. -rt14 has fixed this

tglx


