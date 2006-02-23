Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWBWODc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWBWODc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 09:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWBWODc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 09:03:32 -0500
Received: from lappc-f057.in2p3.fr ([134.158.97.63]:56775 "EHLO
	lappc-f057.in2p3.fr") by vger.kernel.org with ESMTP
	id S1751249AbWBWODc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 09:03:32 -0500
Subject: Re: isolcpus weirdness
From: Emmanuel Pacaud <emmanuel.pacaud@univ-poitiers.fr>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43FDB910.1080402@yahoo.com.au>
References: <1140614487.13155.20.camel@localhost.localdomain>
	 <43FDA8DD.2000500@yahoo.com.au>
	 <1140700054.8314.44.camel@localhost.localdomain>
	 <43FDB910.1080402@yahoo.com.au>
Content-Type: text/plain; charset=utf-8
Date: Thu, 23 Feb 2006 15:03:14 +0100
Message-Id: <1140703394.8314.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 24 février 2006 à 00:30 +1100, Nick Piggin a écrit :
> Emmanuel Pacaud wrote: 
> > There's a difference between isolated cpus and other cpus: by default,
> > there's almost no activity on isolated ones. That's what I want to be
> > able to do.
> > 
> 
> Nothing in kernel-parameters.txt says there will be almost no activity
> on them. 

isolcpus=   [KNL,SMP] Isolate CPUs from the general scheduler.
+         Format: <cpu number>, ..., <cpu number>
+         This option can be used to specify one or more CPUs
+         to isolate from the general SMP balancing and scheduling
+         algorithms.

If a cpu is isolated from general SMP balancing and scheduling algorithm
(I know this isolation is not complete), there will be no activity on
it, no ? Unless one explicitely move one process on this cpu.

At least, that's what I've seen with my 2.6.15 vanilla kernel with
hyperthreading activated, or with distribution supplied kernel
(Scientific linux 4).  With these kernels, with isolcpus=n, there's
almost no activity on cpun.

My problem is I'm not able to obtain this behaviour with a kernel.org
2.6.15 kernel, when HT is disabled, either in BIOS, kernel config or
acpi=off parameter.


	Emmanuel.

(FWIW, I'm working on a RTAI setup. Use of isolcpus in the context of a
realtime setup is explained in their ISOLCPUS document:

http://cvs.gna.org/cvsweb/vulcano/README.ISOLCPUS?rev=1.6;cvsroot=rtai
)

