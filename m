Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUCWKcU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbUCWKcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:32:20 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:43409 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262453AbUCWKcL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:32:11 -0500
Date: Tue, 23 Mar 2004 11:32:09 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Robert_Hentosh@Dell.com,
       fleury@cs.auc.dk, Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: spurious 8259A interrupt
In-Reply-To: <Pine.LNX.4.53.0403221822230.24444@chaos>
Message-ID: <Pine.LNX.4.55.0403231129510.16819@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0403222354280.1902-100000@poirot.grange>
 <Pine.LNX.4.53.0403221822230.24444@chaos>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Richard B. Johnson wrote:

> Yes. The interrupt status, above, clearly shows that the XT-PIC is
> being used for timer interrupts. The local APIC timer is being used
> instead of the PIT (Programmable Interval Timer at port 0x40,

 The local APIC timer is never used "instead" of the PIT.  If both timers
are available, they are used independently for different puproses.

> channel 0).  The IO-APIC contains, several timers as well as a
> programmable interrupt controller and router, etc. You are not
> using its interrupt controller, but you are using its timer,
> best I can see.

 There is no timer source in any I/O APIC I know of.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
