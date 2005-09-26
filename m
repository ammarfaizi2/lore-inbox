Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbVIZSYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbVIZSYD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 14:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVIZSYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 14:24:03 -0400
Received: from fmr16.intel.com ([192.55.52.70]:40630 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S932458AbVIZSYB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 14:24:01 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFT][PATCH] i386 per cpu IDT (2.6.12-rc1-mm1)
Date: Mon, 26 Sep 2005 11:23:31 -0700
Message-ID: <7F740D512C7C1046AB53446D37200173055345A1@scsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFT][PATCH] i386 per cpu IDT (2.6.12-rc1-mm1)
Thread-Index: AcXB+ksihk3CZlInRyWMhqUbHJLPPwAyA8EQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>, "Andi Kleen" <ak@suse.de>,
       "Raj, Ashok" <ashok.raj@intel.com>, <bjorn.helgaas@hp.com>
X-OriginalArrivalTime: 26 Sep 2005 18:23:33.0958 (UTC) FILETIME=[676FAE60:01C5C2C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

Zwane, Hi

> Apologies for the long periods between updates, i've been doing some
> relocating.
> 
> Changes since last post:
> 
> * Current interrupt handling domain is still on a node basis,
> although i 
> have moved over to dynamically allocated per cpu IDTs.

I think it might be better if you define some cpu group where the cpus
share the same IDT. Then you can handle big SMP machines as well; it's a
kind of software partitioning limited to I/O device interrupts. That
will be helpful for virtulization like Xen.

> 
> * MSI now allocates vectors per node too, i've introduced a policy
> whereupon the node its allocated on depends on where the code is
> running. 
> I'd like to move towards a policy where we allocate the vector on the
> node 
> the bus/device belongs to, objections? This code is totally untested
> as i 
> don't have any MSI capable devices.
> 
> Thanks,
> 	Zwane
> 

Jun
---
Intel Open Source Technology Center
