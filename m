Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbULNWCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbULNWCS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbULNWBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:01:51 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:7590 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261689AbULNV6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 16:58:35 -0500
Date: Tue, 14 Dec 2004 13:58:25 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Roland McGrath <roland@redhat.com>
cc: Ulrich Drepper <drepper@redhat.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] cpu-timers: high-resolution CPU clocks for POSIX
 clock_* syscalls
In-Reply-To: <200412142150.iBELoJc0011582@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0412141355170.4330@schroedinger.engr.sgi.com>
References: <200412142150.iBELoJc0011582@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004, Roland McGrath wrote:

> I believe Christoph may have been referring exclusively to the per-process
> clocks, not the per-thread clocks.  I'm not entirely sure since he used the
> term "process" exclusively, but quoted my paragraph about the per-thread
> clock access.  Ulrich's reply is apropos to the individual thread clocks.
>
> It was about the per-process clocks that I raised the question.  For those,
> POSIX says it's implementation-defined what process can see the CPU clock
> of another process.  That means we can make it as restricted or as free as
> we like, but we are obliged to document up front for the users what the
> semantics are.  That's why I would like to make sure we have thought a
> little about the choices now, rather than someone coming along later and
> deciding we really ought to impose security on it (which might be be
> changing the story after developers reasonably coded to the
> implementation-defined behavior we documented in the first place).

The threads are processes under Linux and thus may also be identified by a
pid. You are right, this is a Linux centric view and this identificaition
is not applicable to other systems.
