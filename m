Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275211AbTHMPTN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275213AbTHMPTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:19:13 -0400
Received: from fmr06.intel.com ([134.134.136.7]:8136 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S275211AbTHMPTM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:19:12 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Updated MSI Patches
Date: Wed, 13 Aug 2003 08:19:08 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024015416FB@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Updated MSI Patches
Thread-Index: AcNhPRChaD6tgzB1RXerj906LEjVdAAcInuw
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: "Jeff Garzik" <jgarzik@pobox.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "long" <tlnguyen@snoqualmie.dp.intel.com>
X-OriginalArrivalTime: 13 Aug 2003 15:19:09.0459 (UTC) FILETIME=[3E56DE30:01C361AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Salability means many things. I'm not sure which aspect you are talking
>> about, but a good thing with MSI is that it does not depend on I/O
>> APICs. A typical I/O APIC has 24 RTEs, and we need about 10 I/O APICs to
>> consume the vectors. 

> Yes there are already a number of systems which exhibit this problem (see 
> the URL in the next comment)
 
>> You can make this scale on SMP systems. The vector-based approach would
>> be easier to extend it per-CPU because vectors are inherently per-CPU,
>> compared with IRQ-based. Today we have IRQ balancing as you know, and
>> the key part is to bind IRQ to a particular CPU (BTW, with our patch it
>> happens automatically because the balancer does not care if they are IRQ
>> or vector). 

>Sorry, yeah i meant device scalability essentially, the ability to plug in 
>a fair amount of these and other devices into the same system. The per cpu 
>IDT route is also worthwhile following a bit later on. I've already 
>written something along the lines of a per node IDT (you could make the 
>granularity per cpu of course) if you're interested you can have a look 
>here http://www.osdl.org/projects/numaqhwspprt/results/patch-numaq-highirq10 it 
>also has a companion patch to dynamically allocate the irq_desc's which 
>applies on top of it http://function.linuxpower.ca/patches/patch-dynirq-wli

>But back to the subject, your patch looks good, i'll test it for 
>regression (no MSI devices but regression testing is just as important) 
>when you next post.
I already had discussion with Jun about this change. We will post it as soon as
we validate this change on our system.

Thanks,
Long
