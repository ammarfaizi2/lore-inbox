Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266458AbUAOEhL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 23:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUAOEhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 23:37:11 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:55937
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S266458AbUAOEhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 23:37:10 -0500
Date: Wed, 14 Jan 2004 23:36:13 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
cc: James Cleverdon <jamesclv@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Chris McDermott <lcm@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: RE: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic subarch
 UP installer kernels
In-Reply-To: <7F740D512C7C1046AB53446D3720017361883D@scsmsx402.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0401141815090.15331@montezuma.fsmlabs.com>
References: <7F740D512C7C1046AB53446D3720017361883D@scsmsx402.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jan 2004, Nakajima, Jun wrote:

> I tend to agree. I think the confusing part is the range of the IRQs on
> that machine. Assuming that irq_vector[NR_IRQ_VECTORS = 1024] requires
> more entries, then the IRQs should take that range, because
> IO_APCI_VECTOR(irq) is just irq_vector[irq], for example. If NR_IRQS is
> still 224, how can do_IRQ() can get the correct IRQ (i.e. >= 224) ? So
> in that case, the IRQ should be smaller than 224, then irq_vector[]
> should be smaller.

In my opinion we should be breaking after we've exceeded the maximum
external vectors we can install. This will of course mean less than
the number of RTEs. James have you actually managed to use the devices
connected to the high (over ~224) RTEs?

