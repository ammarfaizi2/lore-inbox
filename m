Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVAYCkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVAYCkY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 21:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVAYCiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 21:38:52 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:25266 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261775AbVAYCgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 21:36:10 -0500
Date: Mon, 24 Jan 2005 18:35:48 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: George Anzinger <george@mvista.com>
cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH 4/7] posix-timers: CPU clock support for POSIX timers
In-Reply-To: <41F5AF72.8000502@mvista.com>
Message-ID: <Pine.LNX.4.58.0501241834190.19044@schroedinger.engr.sgi.com>
References: <200501232325.j0NNPUg7006501@magilla.sf.frob.com>
 <41F5AF72.8000502@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005, George Anzinger wrote:

> > The apparent pervasive changes to posix-timers.c are simply that some
> > fields of struct k_itimer have changed name and moved into a union.
> > This was appropriate since the data structures required for the existing
> > real-time timer support and for the new thread/process CPU-time timers are
> > quite different.
>
> Possibly you could bury these name changes in defines.  I suspect the code would
> be easier to read and that we really don't need to be reminded that it is a
> union on each reference.

It would be great to have a kind of private field that other clocks (like
clock drivers) could use for their purposes. mmtimer f.e. does use some
of the fields for the tick based timers for its purposes.
