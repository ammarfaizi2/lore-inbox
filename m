Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVC3Vn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVC3Vn5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbVC3Vn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 16:43:56 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:27039 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262221AbVC3Vnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 16:43:51 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1112218750.3691.165.camel@localhost.localdomain>
References: <Pine.OSF.4.05.10503302042450.2022-100000@da410.phys.au.dk>
	 <1112212608.3691.147.camel@localhost.localdomain>
	 <1112218750.3691.165.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 30 Mar 2005 16:43:43 -0500
Message-Id: <1112219023.3691.168.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2005-03-30 at 16:39 -0500, Steven Rostedt wrote:
> On Wed, 2005-03-30 at 14:56 -0500, Steven Rostedt wrote:
> 
> > Because of the stupid BKL, I'm going with a combination of your idea and
> > my idea for the solution of pending owners.  I originally wanted the
> > stealer of the lock to put the task that was robbed back on the list.
> > But because of the BKL, you end up with a state that a task can be
> > blocked by two locks at the same time. This causes hell with priority
> > inheritance.
> > 

 [snip]

> It's a relatively simple patch, but it took a lot of pain since I was
> trying very hard to have the stealer do the work. But the BKL proved to
> be too much.

Oh, I forgot, this is patched against V0.7.41-11. Ingo, you're moving so
fast, I can't keep up. I'll download your latest later, and see if this
patch still qualifies.

-- Steve


