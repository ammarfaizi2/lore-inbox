Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWBWNHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWBWNHl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 08:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWBWNHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 08:07:41 -0500
Received: from lappc-f057.in2p3.fr ([134.158.97.63]:26820 "EHLO
	lappc-f057.in2p3.fr") by vger.kernel.org with ESMTP
	id S1751206AbWBWNHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 08:07:40 -0500
Subject: Re: isolcpus weirdness
From: Emmanuel Pacaud <emmanuel.pacaud@univ-poitiers.fr>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43FDA8DD.2000500@yahoo.com.au>
References: <1140614487.13155.20.camel@localhost.localdomain>
	 <43FDA8DD.2000500@yahoo.com.au>
Content-Type: text/plain; charset=utf-8
Date: Thu, 23 Feb 2006 14:07:33 +0100
Message-Id: <1140700054.8314.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 23 février 2006 à 23:21 +1100, Nick Piggin a écrit :
> Emmanuel Pacaud wrote:
> > Hi,
> > 
> > When specifying isolcpus kernel parameters, isolated cpu is always the
> > same, not the one I asked for.
..
> > 
> > What's wrong ?
> > 
> 
> If you have 2 CPUs, and "isolate" one of them, the other is isolated
> from it. Ie. there is no difference between isolating one or the other,
> the net result is that they are isolated from each other.
> 

>From kernel-parameters.txt:

+   isolcpus=   [KNL,SMP] Isolate CPUs from the general scheduler.
+         Format: <cpu number>, ..., <cpu number>
+         This option can be used to specify one or more CPUs
+         to isolate from the general SMP balancing and scheduling
+         algorithms. The only way to move a process onto or off
+         an "isolated" CPU is via the CPU affinity syscalls.
+
+         This option is the preferred way to isolate CPUs. The
+         alternative - manually setting the CPU mask of all tasks
+         in the system can cause problems and suboptimal load
+         balancer performance.

There's a difference between isolated cpus and other cpus: by default,
there's almost no activity on isolated ones. That's what I want to be
able to do.

	Emmanuel.

