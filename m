Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbTIPMiV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 08:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTIPMiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 08:38:21 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:23168 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S261871AbTIPMiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 08:38:19 -0400
Date: Tue, 16 Sep 2003 14:34:55 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
In-Reply-To: <20030912190728.GN27368@fs.tum.de>
Message-ID: <Pine.GSO.3.96.1030916143015.9516A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Sep 2003, Adrian Bunk wrote:

> What about the original 386?

 The i386 is irrelevant -- it didn't have an on-chip APIC and it didn't
directly support an external one.  At the time the APIC was manufactured,
i386 systems were inefficient enough not to justify designing glue logic
for the APIC.

> Then I can simply change it in my patch to
> 
> config X86_GOOD_APIC
>         bool
> 	depends on !CPU_586TSC
> 	default y

 It's a good estimate, although Pentium systems support an external APIC
which is always good.  If the on-chip APIC is used, a system suffers from
the erratum as mentioned previously, if an external one is used, a system
is good.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

