Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262584AbVA1S73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbVA1S73 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 13:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVA1S4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:56:20 -0500
Received: from mx1.elte.hu ([157.181.1.137]:40159 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262718AbVA1SyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:54:24 -0500
Date: Fri, 28 Jan 2005 19:53:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Doug Niehaus <niehaus@ittc.ku.edu>,
       Benedikt Spranger <bene@linutronix.de>
Subject: Re: High resolution timers and BH processing on -RT
Message-ID: <20050128185356.GD25164@elte.hu>
References: <1106871192.21196.152.camel@tglx.tec.linutronix.de> <20050128044301.GD29751@elte.hu> <1106900411.21196.181.camel@tglx.tec.linutronix.de> <20050128082439.GA3984@elte.hu> <1106901013.21196.194.camel@tglx.tec.linutronix.de> <20050128084725.GB5004@elte.hu> <41FA85A7.4000805@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FA85A7.4000805@mvista.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* George Anzinger <george@mvista.com> wrote:

> The primary thing needed for this is a simple and quick way to switch
> a tasks priority, both from outside and from the task itself.

check out sched.c's mutex_setprio(p, prio) and mutex_getprio(p), which
is used by the PI code in kernel/rt.c. It's pretty robust and heavily
used.

	Ingo
