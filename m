Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTLPQu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 11:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTLPQu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 11:50:58 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:19350 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261929AbTLPQu4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 11:50:56 -0500
Date: Tue, 16 Dec 2003 17:50:54 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: George Anzinger <george@mvista.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Catching NForce2 lockup with NMI watchdog
In-Reply-To: <Pine.LNX.4.53.0312161135510.19922@chaos>
Message-ID: <Pine.LNX.4.55.0312161745330.8262@jurand.ds.pg.gda.pl>
References: <3FD5F9C1.5060704@nishanet.com> <Pine.LNX.4.55.0312101421540.31543@jurand.ds.pg.gda.pl>
 <brcoob$a02$1@gatekeeper.tmr.com> <3FDA40DA.20409@mvista.com>
 <Pine.LNX.4.55.0312151412270.26565@jurand.ds.pg.gda.pl> <3FDE2AC6.30902@mvista.com>
 <Pine.LNX.4.55.0312161426060.8262@jurand.ds.pg.gda.pl>
 <Pine.LNX.4.53.0312160846530.17690@chaos> <Pine.LNX.4.55.0312161645100.8262@jurand.ds.pg.gda.pl>
 <Pine.LNX.4.53.0312161135510.19922@chaos>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2003, Richard B. Johnson wrote:

> Although I haven't looked at recent source-code, with APIC, the
> problem is even simpler. If you booted with APIC, just set
> the global "using_apic_timer" to zero and, voila`, timer-ticks
> stop.

 Except we are writing of the 8254 timer, not the local APIC one...

> ...the machine will lock-up forever because without that timer,
> there will be no preemption. Once a CPU-hog gets the CPU, only
> and interrupt can get it away.

 And the 8254 timer isn't used for preemption when local APICs are used,
so disabling it won't break the whole system, only the timekeeping.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
