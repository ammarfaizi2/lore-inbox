Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271820AbTG2XkL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 19:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272134AbTG2XkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 19:40:11 -0400
Received: from waste.org ([209.173.204.2]:42655 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S271820AbTG2XkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 19:40:07 -0400
Date: Tue, 29 Jul 2003 18:40:04 -0500
From: Matt Mackall <mpm@selenic.com>
To: Eric Sandall <eric@sandall.us>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] automate patch names in kernel versions
Message-ID: <20030729234003.GG6049@waste.org>
References: <20030729204419.GE6049@waste.org> <13036.134.121.40.89.1059516902.squirrel@mail.sandall.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13036.134.121.40.89.1059516902.squirrel@mail.sandall.us>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 03:15:02PM -0700, Eric Sandall wrote:
> 
> Oliver Xymoron said:
> > Perhaps times have changed enough that I can revive this idea from a
> > few years ago:
> >
> > http://groups.google.com/groups?q=patchname+oxymoron&hl=en&lr=&ie=UTF-8&selm=fa.jif8l5v.1b049jd%40ifi.uio.no&rnum=1
> >
> > <quote year=1999>
> > This four-line patch provides a means for listing what patches have
> > been built into a kernel. This will help track non-standard kernel
> > versions, such as those released by Redhat, or Alan's ac series, etc.
> > more easily.
> >
> > With this patch in place, each new patch can include a file of the
> > form "patchname.[identifier]" in the top level source directory and
> > [identifier] will then be added to the kernel version string. For
> > instance, Alan's ac patches could include a file named patchdesc.ac2
> > (containing a change log, perhaps), and the resulting kernel would be
> > identified as 2.2.0-pre6+ac2, both at boot and by uname.
> >
> > This may prove especially useful for tracking problems with kernels
> > built by distribution packagers and problems reported by automated
> > tools.
> > </quote>
> >
> > The patch now appends patches as -name rather than +name to avoid
> > issues that might exist with packaging tools and scripts.
> <snip>
> 
> One problem I see right off the bat with this is that your kernel image
> name (and label) in LILO can only be so long, and if you apply too many
> patches (acpi+xfs+preempt+low etc.) it would become too long.  This may be
> an extreme case, but it can happen (I usually apply apci, preempt, low,
> sched, etc., though the ck patch does most of this for me now).

There's already code in the makefile that warns when it grows over 64
characters.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
