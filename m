Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbUCVJDF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 04:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbUCVJDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 04:03:05 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:21411 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261615AbUCVJDB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 04:03:01 -0500
Date: Mon, 22 Mar 2004 10:02:59 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Robert_Hentosh@Dell.com, fleury@cs.auc.dk, linux-kernel@vger.kernel.org
Subject: RE: spurious 8259A interrupt
In-Reply-To: <Pine.LNX.4.44.0403192258350.3619-100000@poirot.grange>
Message-ID: <Pine.LNX.4.55.0403221000530.6539@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0403192258350.3619-100000@poirot.grange>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004, Guennadi Liakhovetski wrote:

> >  The best way to deal with spurious interrupts is to ack the interrupt at
> > the device ASAP in the handler, especially if you know that the response
> > is slow.
> 
> I am getting those from the lAPIC timer interrupt (on a VIA KM133 Duron
> system). And the APIC timer interrupt IS acked (almost) immediately. So, I
> have a choice: no NMI watchdog or that uncomfortably increasing ERR:
> counter. Kernel 2.6.3.

 Do you really get "spurious 8259A interrupt" messages for the local APIC 
timer???  They don't ever leave the unit bound to the processor -- it has 
to be something else.  What is your contents of /proc/interrupts?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
