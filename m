Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271377AbTHMEOn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 00:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271383AbTHMEOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 00:14:43 -0400
Received: from fmr05.intel.com ([134.134.136.6]:18932 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S271377AbTHMEOk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 00:14:40 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Updated MSI Patches
Date: Tue, 12 Aug 2003 21:14:37 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304A66A@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Updated MSI Patches
Thread-Index: AcNhPRZQLnlgUdLuTeW6P7HTKAhm2wAFB0Og
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>
Cc: "Jeff Garzik" <jgarzik@pobox.com>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "long" <tlnguyen@snoqualmie.dp.intel.com>
X-OriginalArrivalTime: 13 Aug 2003 04:14:38.0171 (UTC) FILETIME=[693322B0:01C36151]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But back to the subject, your patch looks good, i'll test it for
> regression (no MSI devices but regression testing is just as
important)
> when you next post.

Thanks. Long will make another patch that reflects my last comments.

Jun

> -----Original Message-----
> From: Zwane Mwaikambo [mailto:zwane@linuxpower.ca]
> Sent: Tuesday, August 12, 2003 6:37 PM
> To: Nakajima, Jun
> Cc: Jeff Garzik; Nguyen, Tom L; Linux Kernel; long
> Subject: RE: Updated MSI Patches
> 
> On Tue, 12 Aug 2003, Nakajima, Jun wrote:
> 
> > Salability means many things. I'm not sure which aspect you are
talking
> > about, but a good thing with MSI is that it does not depend on I/O
> > APICs. A typical I/O APIC has 24 RTEs, and we need about 10 I/O
APICs to
> > consume the vectors.
> 
> Yes there are already a number of systems which exhibit this problem
(see
> the URL in the next comment)
> 
> > You can make this scale on SMP systems. The vector-based approach
would
> > be easier to extend it per-CPU because vectors are inherently
per-CPU,
> > compared with IRQ-based. Today we have IRQ balancing as you know,
and
> > the key part is to bind IRQ to a particular CPU (BTW, with our patch
it
> > happens automatically because the balancer does not care if they are
IRQ
> > or vector).
> 
> Sorry, yeah i meant device scalability essentially, the ability to
plug in
> a fair amount of these and other devices into the same system. The per
cpu
> IDT route is also worthwhile following a bit later on. I've already
> written something along the lines of a per node IDT (you could make
the
> granularity per cpu of course) if you're interested you can have a
look
> here http://www.osdl.org/projects/numaqhwspprt/results/patch-numaq-
> highirq10 it
> also has a companion patch to dynamically allocate the irq_desc's
which
> applies on top of it
http://function.linuxpower.ca/patches/patch-dynirq-
> wli
> 
> But back to the subject, your patch looks good, i'll test it for
> regression (no MSI devices but regression testing is just as
important)
> when you next post.
> 
> Thanks!
> 	Zwane
