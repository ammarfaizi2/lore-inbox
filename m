Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbVJFXLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVJFXLu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVJFXLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:11:50 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:8903 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1751190AbVJFXLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:11:49 -0400
Subject: Re: [PATCH 2.6.14-rc1-git5] sched: disable preempt in idle tasks
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, shaohua.li@intel.com, vatsa@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, spyro@f2s.com,
       Andi Kleen <ak@suse.de>
In-Reply-To: <43322445.6050003@yahoo.com.au>
References: <43317F3E.9090207@yahoo.com.au>
	 <20050921183138.52bcdf27.akpm@osdl.org>  <43322445.6050003@yahoo.com.au>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1128639828.13507.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 07 Oct 2005 09:03:48 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-09-22 at 13:25, Nick Piggin wrote:
> Andrew Morton wrote:
> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > 
> >>This patch should hopefully fix Nigel's bug.
> >>
> >> Split out from sched-resched-opt.patch. Tested on i386 with acpi idle
> >> and poll idle (previous iterations tested on various other architectures).
> > 
> > 
> > This makes the emt64 machine reboot itself, which iirc was the behaviour in
> > the failing patch from which this one was split out.
> > 
> > The machine is using acpi_processor_idle().
> > 
> 
> OK, thanks. That must be the preempt_disable() being called in
> start_secondary(). Maybe I should have listened to the comment.
> 
> Can you try the following patch?

Ok. Well I've fun with that patch for a couple of weeks and had no
recurrences of the issue whatsoever - until I upgraded my kernel
yesterday and forgot to apply it again. In short, it seems to fix the
problem here.

Regards,

Nigel

