Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUJLO0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUJLO0z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUJLOYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:24:37 -0400
Received: from ipx20189.ipxserver.de ([80.190.249.56]:62085 "EHLO
	ipx20189.ipxserver.de") by vger.kernel.org with ESMTP
	id S264098AbUJLOXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:23:54 -0400
Date: Tue, 12 Oct 2004 17:24:05 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.9-rc4-mm1
In-Reply-To: <20041011125507.3d733256.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0410121720080.4190@musoma.fsmlabs.com>
References: <20041011032502.299dc88d.akpm@osdl.org>
 <Pine.LNX.4.61.0410111844450.2873@musoma.fsmlabs.com> <20041011125507.3d733256.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2004, Andrew Morton wrote:

> > allow-x86_64-to-reenable-interrupts-on-contention.patch
> >   Allow x86_64 to reenable interrupts on contention
> 
> IIRC Andi made skeptical noises about this one.

Yes he did (although he did say it would be ok if spinlocks were made 
out of line to make up for the text size increase in the spinlock 
assembly) and Ingo said his preempt_enable on contention spinlock changes 
should have the same effect, however how about the case where we hold a 
lock above the contended one (so preempt is disabled) and interrupts enabled? 
At least with this we still process interrupts, plus it can coexist with 
the preempt friendly spinlock changes. Ingo?
