Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbUCQPaA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 10:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbUCQPaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 10:30:00 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:63152 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261531AbUCQP36
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 10:29:58 -0500
Date: Wed, 17 Mar 2004 16:29:45 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thomas Schlichter <thomas.schlichter@web.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: idle Athlon with IOAPIC is 10C warmer since 2.6.3-bk1
In-Reply-To: <200403032119.58817.thomas.schlichter@web.de>
Message-ID: <Pine.LNX.4.55.0403171626090.14525@jurand.ds.pg.gda.pl>
References: <200403032119.58817.thomas.schlichter@web.de>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2004, Thomas Schlichter wrote:

> a few days ago I noticed that my Athlon 3000+ was relatively hot (49C) 
> although it was completely idle. At that time I was running 2.6.3-mm3 with 
> ACPI and IOAPIC-support enabled.
> 
> As I tried 2.6.3, the idle temperature was at normal 39C. So I did do some 
> binary search with the -bk patches and found the patch that causes the high 
> idle temperature. It is ChangeSet@1.1626 aka 8259-timer-ack-fix.patch.

 Interesting -- the patch removes a pair of unnecessary for your
configuration PIC accesses when using an I/O APIC NMI watchdog.  You have 
the NMI watchdog enabled, don't you?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
