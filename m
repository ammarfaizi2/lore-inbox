Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVAYXvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVAYXvM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 18:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVAYXtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 18:49:55 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:41193 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262243AbVAYXtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 18:49:13 -0500
Date: Tue, 25 Jan 2005 15:48:55 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: George Anzinger <george@mvista.com>
cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] posix-timers: CPU clock support for POSIX timers
In-Reply-To: <41F6D8A0.5090404@mvista.com>
Message-ID: <Pine.LNX.4.58.0501251547010.27922@schroedinger.engr.sgi.com>
References: <200501232325.j0NNPUg7006501@magilla.sf.frob.com>
 <41F5AF72.8000502@mvista.com> <Pine.LNX.4.58.0501241834190.19044@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501251450080.26368@schroedinger.engr.sgi.com>
 <41F6D8A0.5090404@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005, George Anzinger wrote:

> > Your patch breaks the mmtimer driver because it used k_itimer values for
> > its own purposes. Here is a fix by defining an additional structure
> > in k_itimer (same approach for mmtimer as the cpu timers):
>
> I would like to get a read on the following defines...
> #define mmclock mmtimer.clock
> #define mmnode  mmtimer.node
> #define mmincr  mmtimer.incr
> #define mmexpires mmtimer.expires
>
> Then, of course, you would use the defines instead of the "." references.  Is
> this a big no-no in kernel code.  Seems to me it makes things a bit easier to read.

Less code to get to the values would be preferable. Maybe this could be
another patch to clean up the clock driver stuff and provide some
standardized mechanism to provide private data space for future clock
drivers?

