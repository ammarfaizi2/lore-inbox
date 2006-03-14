Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbWCNWVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbWCNWVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWCNWVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:21:46 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:57247
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932546AbWCNWVq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:21:46 -0500
Subject: Re: 2.6.16-rc6-rt1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org
In-Reply-To: <20060314221111.GA7118@elte.hu>
References: <20060314101811.GA10450@elte.hu>
	 <Pine.LNX.4.44L0.0603142256050.1291-100000@lifa01.phys.au.dk>
	 <20060314221111.GA7118@elte.hu>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 23:22:17 +0100
Message-Id: <1142374937.19916.665.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 23:11 +0100, Ingo Molnar wrote:
> > > no. We have to run deadlock detection to avoid things like circular lock
> > > dependencies causing an infinite schedule+wakeup 'storm' during priority
> > > boosting. (like possible with your wakeup based method i think)
> > No, all tasks would just settle on the highest priority and then the
> > wakeups would stop.
> 
> you are right, that shouldnt be possible. But how about other, SMP 
> artifacts? What if the woken up task runs on another CPU, and the whole 
> chain of boosting is thus delayed?

And it does not solve the problem of ad hoc deadlock detection at all.

	tglx


