Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTKFS5F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 13:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbTKFS5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 13:57:05 -0500
Received: from hermes.py.intel.com ([146.152.216.3]:28347 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S263435AbTKFS5B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 13:57:01 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [DMESG] cpumask_t in action
Date: Thu, 6 Nov 2003 10:56:55 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0F3751@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [DMESG] cpumask_t in action
Thread-Index: AcOkiHtkVK5RV3lEQ+eWuGHZhyK51gADlWdQ
From: "Luck, Tony" <tony.luck@intel.com>
To: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       "Jesse Barnes" <jbarnes@sgi.com>
Cc: "Matthew Wilcox" <willy@debian.org>
X-OriginalArrivalTime: 06 Nov 2003 18:56:56.0492 (UTC) FILETIME=[C0029EC0:01C3A497]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That'd cut us down to:
> 
> > CPU 3: 61 virtual and 50 physical address bits
> > CPU 3: nasid 2, slice 2, cnode 1
> > CPU 3: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
> > Calibrating delay loop... 2241.08 BogoMIPS
> > CPU3: CPU has booted.
> > Starting migration thread for cpu 3

Perhaps we could drop printing the number of virtual/physical address
bits, and the frequency&ratio information (or maybe just print if they
are different from the boot cpu ... which would most likely surprise
the kernel in bad ways, and thus be worthy of printing).  That would
cut another two lines for all bar one cpu.

-Tony
