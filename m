Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbTDUSNK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTDUSNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:13:10 -0400
Received: from fmr01.intel.com ([192.55.52.18]:56513 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S261783AbTDUSNI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:13:08 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] 2.5.68 Fix IO_APIC IRQ assignment bug
Date: Mon, 21 Apr 2003 11:24:26 -0700
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB56401A45755@fmsmsx407.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.5.68 Fix IO_APIC IRQ assignment bug
Thread-Index: AcMIKktKGQDKSlmGQsG29jqqeis6sQABZ2ug
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>
Cc: "Chuck Ebbert" <76306.1226@compuserve.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Apr 2003 18:24:26.0740 (UTC) FILETIME=[3DA9D340:01C30833]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I know there are more people who want to get rid of NR_IRQS e.g. due to
> very sparse irq distribution. For one of the platforms i'm interested in,
> we have to make a clear distinction between irqs and vectors so that we
> can have seperate vector allocations per interrupt handling domain. I
> believe IA-64 does the same but instead per cpu (our domain/node consists
> of 4 cpus) NR_IRQS gets in the way due to it being set at 224 when we
> actually

I heard such requests too, and suggested the same thing, i.e. seperate vector allocations per interrupt handling domain. 

> can service NR_IRQ_VECTORS * NUM_MAXNODES I/O vectors. Can you post your
> patch?

Yes, we'll post it after cleanups.

> 
> Also what MSI devices are you using?
> 

Adaptec 39320 SCSI HBA (it has the 7902 ASIC), which has two MSI-capable functions. You don't need to change the driver (aic79xx) to enable MSI.

Thanks,
Jun

