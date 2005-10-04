Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVJDOBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVJDOBt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 10:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbVJDOBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 10:01:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:24006 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932136AbVJDOBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 10:01:48 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vadim Lobanov <vlobanov@speakeasy.net>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <20051002204703.GG6290@lkcl.net>
	<Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com>
	<20051002230545.GI6290@lkcl.net>
	<Pine.LNX.4.58.0510021637260.28193@shell2.speakeasy.net>
	<20051003005400.GM6290@lkcl.net>
	<1128367120.26992.44.camel@localhost.localdomain>
	<20051003210722.GI8548@lkcl.net>
	<1128377145.26992.53.camel@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 04 Oct 2005 16:01:46 +0200
In-Reply-To: <1128377145.26992.53.camel@localhost.localdomain>
Message-ID: <p73y859z8hh.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Llu, 2005-10-03 at 22:07 +0100, Luke Kenneth Casson Leighton wrote:
> >  made?  _cool_.  actual hardware.  new knowledge for me.  do you know
> >  of any online references, papers or stuff?  [btw just to clarify:
> >  you're saying you have a NUMA bus or you're saying you have an
> >  augmented SMP+NUMA+separate-parallel-message-passing-bus er .. thing]
> 
> Its a standard current Intel feature. See "mwait" in the processor
> manual. The CPUs are also smart enough to do cache to cache transfers.
> No special hardware no magic.

It's unfortunately useless for anything but kernels right now because
Intel has disabled it in ring 3 (and AMD doesn't support it yet)
And the only good use the kernel found for it so far is fast wakeup
from the idle loop.

> And unless I want my messages to cause interrupts and wake events (in
> which case the APIC does it nicely) then any locked operation on memory
> will do the job just fine. I don't need funky hardware on a system. The
> first point I need funky hardware is between boards and that isn't
> consumer any more.

Firewire + CLFLUSH should do the job.

-Andi
 
