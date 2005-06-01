Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVFAPe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVFAPe0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVFAPdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:33:16 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:5678
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261434AbVFAPco
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:32:44 -0400
Date: Wed, 1 Jun 2005 17:32:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601153232.GN5413@g5.random>
References: <20050601150527.GL5413@g5.random> <Pine.OSF.4.05.10506011709500.1707-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10506011709500.1707-100000@da410.phys.au.dk>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 05:15:23PM +0200, Esben Nielsen wrote:
> redifiing cli()/sti() in Linux, which is what the patent covers.

I'm glad at least I understood something right about the patent
contents.

These days cli/sti are more commonly called
local_irq_disable/local_irq_enable.

So clearly renaming cli/sti to local_irq_disable/enable isn't going to
invalidate the patent.

I don't know if spin_lock_irq can be considered a way to disable hard
irqs or not, and if doing the _irq part in a "soft" mode that leaves
hard-irq enabled can be considered "software emulation".

It'm not a laywer so I can't know that.

> Neither am I. But I know if I start to interpret patens that way I would
> have to stop writing software right now as every line of code would be
> covered by some patent if you start to look at it your way.

This is true. Well, the only thing I really known was the patent covered
the redefinition of cli not to do an hard "cli" asm instruction, but to
do it in software (i.e. emulated). nanokernel worked around that since
it did it for ages before the patent was filed (so at the very least
that would make the patent invalid, sure nanokernel non-GPL usage isn't
infringing).

This one of preempt-rt looked to redefine a hard-disable-irq to a
soft-disable-irq in the context of the OS, and in turn my mind
immediatly went back to the patent.

BTW, I remind people to sign the petition (I already signed it some time
ago):

	http://petition.eurolinux.org/
