Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVFKQTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVFKQTY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 12:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVFKQTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 12:19:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:33009 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261504AbVFKQTV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 12:19:21 -0400
Date: Sat, 11 Jun 2005 09:19:10 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <20050611134609.GA31025@elte.hu>
Message-ID: <Pine.LNX.4.10.10506110914230.27294-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Jun 2005, Ingo Molnar wrote:

> 
> one way to make it safe/reviewable is to runtime warn if 
> local_irq_disable() is called from a !preempt_count() section. But this 
> will uncover quite some code. There's some code in the VM, in the 
> buffer-cache, in the RCU code - etc. that uses per-CPU data structures 
> and assumes non-preemptability of local_irq_disable().


Are you talking about make those section preemptible? Or a safety problem
in the current method.

Daniel

