Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271308AbTHMBs6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 21:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271319AbTHMBs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 21:48:58 -0400
Received: from [66.212.224.118] ([66.212.224.118]:20232 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271308AbTHMBs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 21:48:57 -0400
Date: Tue, 12 Aug 2003 21:37:06 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Subject: RE: Updated MSI Patches
In-Reply-To: <7F740D512C7C1046AB53446D3720017304AE9B@scsmsx402.sc.intel.com>
Message-ID: <Pine.LNX.4.53.0308122126350.4047@montezuma.mastecende.com>
References: <7F740D512C7C1046AB53446D3720017304AE9B@scsmsx402.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003, Nakajima, Jun wrote:

> Salability means many things. I'm not sure which aspect you are talking
> about, but a good thing with MSI is that it does not depend on I/O
> APICs. A typical I/O APIC has 24 RTEs, and we need about 10 I/O APICs to
> consume the vectors. 

Yes there are already a number of systems which exhibit this problem (see 
the URL in the next comment)
 
> You can make this scale on SMP systems. The vector-based approach would
> be easier to extend it per-CPU because vectors are inherently per-CPU,
> compared with IRQ-based. Today we have IRQ balancing as you know, and
> the key part is to bind IRQ to a particular CPU (BTW, with our patch it
> happens automatically because the balancer does not care if they are IRQ
> or vector). 

Sorry, yeah i meant device scalability essentially, the ability to plug in 
a fair amount of these and other devices into the same system. The per cpu 
IDT route is also worthwhile following a bit later on. I've already 
written something along the lines of a per node IDT (you could make the 
granularity per cpu of course) if you're interested you can have a look 
here http://www.osdl.org/projects/numaqhwspprt/results/patch-numaq-highirq10 it 
also has a companion patch to dynamically allocate the irq_desc's which 
applies on top of it http://function.linuxpower.ca/patches/patch-dynirq-wli

But back to the subject, your patch looks good, i'll test it for 
regression (no MSI devices but regression testing is just as important) 
when you next post.

Thanks!
	Zwane
