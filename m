Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWCZVeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWCZVeA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 16:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWCZVeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 16:34:00 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:9706 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S932133AbWCZVeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 16:34:00 -0500
Date: Sun, 26 Mar 2006 22:33:54 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
cc: tglx@linutronix.de, <linux-kernel@vger.kernel.org>
Subject: Re: Are ALL_TASKS_PI on in 2.6.16-rt7?
In-Reply-To: <20060326212738.GA32562@elte.hu>
Message-ID: <Pine.LNX.4.44L0.0603262231110.8060-100000@lifa03.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Mar 2006, Ingo Molnar wrote:

>
> * Esben Nielsen <simlo@phys.au.dk> wrote:
>
> > It just looks like also normal, non-rt tasks are boosting.
>
> correct. We'd like to make sure the PI code is correct - and for
> PI-futex it makes sense anyway.
>

It wont work 100% when a task is boosted to a normal, non-rt prio well
since at scheduler_tick()
 		p->prio = effective_prio(p);
can be executed overwriting the boost.

> 	Ingo
>

Esben

