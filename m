Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTEGRJQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbTEGRJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:09:16 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:61428 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S264127AbTEGRJP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:09:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: petter wahlman <petter@bluezone.no>, root@chaos.analogic.com
Subject: Re: The disappearing sys_call_table export.
Date: Wed, 7 May 2003 12:21:11 -0500
X-Mailer: KMail [version 1.2]
Cc: Linux kernel <linux-kernel@vger.kernel.org>
References: <1052321673.3727.737.camel@badeip> <Pine.LNX.4.53.0305071147510.12652@chaos> <1052323711.3739.750.camel@badeip>
In-Reply-To: <1052323711.3739.750.camel@badeip>
MIME-Version: 1.0
Message-Id: <03050712211100.06848@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 May 2003 11:08, petter wahlman wrote:
> On Wed, 2003-05-07 at 18:00, Richard B. Johnson wrote:
> > On Wed, 7 May 2003, petter wahlman wrote:
> > > It seems like nobody belives that there are any technically valid
> > > reasons for hooking system calls, but how should e.g anti virus
> > > on-access scanners intercept syscalls?
> > > Preloading libraries, ptracing init, patching g/libc, etc. are
> >
> >   ^^^^^^^^^^^^^^^^^^^
> >
> >                     |________  Is the way to go. That's how
> >
> > you communicate every system-call to a user-mode daemon that
> > does whatever you want it to do, including phoning the National
> > Security Administrator if that's the policy.
> >
> > > obviously not the way to go.
> >
> > Oviously wrong.
>
> And how would you force the virus to preload this library?

You don't have to... The preload is performed by the program image loader,
before the virus, or even the application, can be started.

You don't really want to do it anyway... Consider a file open (like tar)... 
you gonna try to scan the entire archive for a virus???? 
