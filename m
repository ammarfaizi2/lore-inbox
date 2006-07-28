Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161294AbWG1Uol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161294AbWG1Uol (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161295AbWG1Uol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:44:41 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:62597 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161294AbWG1Uok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:44:40 -0400
Subject: Re: 2.6.18-rc2-mm1
From: Matt Helsley <matthltc@us.ibm.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>
In-Reply-To: <6bffcb0e0607281253j28e04ba2icec85589e9390b3e@mail.gmail.com>
References: <20060727015639.9c89db57.akpm@osdl.org>
	 <6bffcb0e0607270632i2ae56e21k40fb12c712980de0@mail.gmail.com>
	 <6bffcb0e0607280117k68184559t531b737815b2c6e9@mail.gmail.com>
	 <20060728013442.6fabae54.akpm@osdl.org> <1154112567.21787.2522.camel@stark>
	 <6bffcb0e0607281253j28e04ba2icec85589e9390b3e@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 13:39:50 -0700
Message-Id: <1154119190.21787.2528.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 21:53 +0200, Michal Piotrowski wrote:
> On 28/07/06, Matt Helsley <matthltc@us.ibm.com> wrote:
> > On Fri, 2006-07-28 at 01:34 -0700, Andrew Morton wrote:
> > > On Fri, 28 Jul 2006 10:17:44 +0200
> > > "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
> > >
> > > > Matt, can you look at this?
> > > >
> > > > My hunt file shows me, that this patches are causing oops.
> > > > GOOD
> > > > #
> > > > #
> > > > task-watchers-task-watchers.patch
> > > > task-watchers-register-process-events-task-watcher.patch
> > > > task-watchers-refactor-process-events.patch
> > > > task-watchers-make-process-events-configurable-as.patch
> > > > task-watchers-allow-task-watchers-to-block.patch
> > > > task-watchers-register-audit-task-watcher.patch
> > > > task-watchers-register-per-task-delay-accounting.patch
> > > > task-watchers-register-profile-as-a-task-watcher.patch
> > > > task-watchers-add-support-for-per-task-watchers.patch
> > > > task-watchers-register-semundo-task-watcher.patch
> > > > task-watchers-register-per-task-semundo-watcher.patch
> > > > BAD
> > >
> > > Thanks for working that out.
> >
> >         I noticed the delay accounting functions in the stack trace. Perhaps
> > task-watchers-register-per-task-delay-accounting.patch is causing the
> > problem.
> 
> Confirmed.

Excellent, thanks for the rapid confirmation. I'll work with Shailabh
and Balbir to fix this. In the meantime perhaps
task-watchers-register-per-task-delay-accounting.patch should be dropped
from -mm.

Cheers,
	-Matt Helsley

