Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVIYXZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVIYXZr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 19:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbVIYXZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 19:25:47 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:19891 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1750780AbVIYXZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 19:25:46 -0400
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
Message-Id: <1127690695.11522.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 26 Sep 2005 09:24:56 +1000
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


Well, I did manage to reproduce the bug again without Nick's patches. It
seems it only occurs when I really want it to suspend because I'm going
home :). I'll apply Nick's patches now and give it some testing for a
few days.

Regards,

Nigel


