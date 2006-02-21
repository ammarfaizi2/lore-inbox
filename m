Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWBUVqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWBUVqU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWBUVqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:46:20 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:34054 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932137AbWBUVqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:46:19 -0500
Date: Tue, 21 Feb 2006 22:41:51 +0100
From: Willy Tarreau <willy@w.ods.org>
To: David Golombek <daveg@permabit.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.31 hangs, no information on console or serial port
Message-ID: <20060221214151.GM11380@w.ods.org>
References: <7yirr8hh0z.fsf@questionably-configured.permabit.com> <20060221152949.GA31273@kvack.org> <7ylkw4bsuu.fsf@questionably-configured.permabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ylkw4bsuu.fsf@questionably-configured.permabit.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 11:04:57AM -0500, David Golombek wrote:
> Benjamin LaHaise <bcrl@kvack.org> writes:
> > On Tue, Feb 21, 2006 at 10:23:56AM -0500, David Golombek wrote:
> > > Any suggestions as to how we might debug this or possible causes would
> > > be greatly appreciated.
> > 
> > Have you tried turning on the NMI watchdog (nmi_watchdog=1)?  It
> > should be able to kick the machine out of the locked state, as these
> > symptoms would hint at a spinlock deadlock with interrupts disabled.
> > Also, try to reproduce on the latest 2.4.33pre.  That said, for an
> > io intensive workload like you're running, 2.6 is much better,
> > especially for systems using highmem.
> 
> I'll enable nmi_watchdog as soon as we can bring the machine down,
> thanks for the excellent suggestion. I'd entirely forgotten about the
> watchdog.  I'll try to switch to 2.4.33pre out as soon as poosible, it
> certainly has several fixes we've been waiting for.  2.6 is still a
> ways off, lots of qualification work to do.

BTW, if your console blanks, you should use this :

   # setterm -blank 0

Maybe you'll notice some "OOM: killing process" messages indicating
that some hungry process is going mad (possibly the NFS server).

> Thanks,
> Dave

Regards,
Willy

