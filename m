Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUCSWGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 17:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbUCSWES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 17:04:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:35776 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263089AbUCSWEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 17:04:08 -0500
X-Authenticated: #20450766
Date: Fri, 19 Mar 2004 23:01:55 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Robert_Hentosh@Dell.com, <fleury@cs.auc.dk>,
       <linux-kernel@vger.kernel.org>
Subject: RE: spurious 8259A interrupt
In-Reply-To: <Pine.LNX.4.55.0403191426180.18215@jurand.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.44.0403192258350.3619-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004, Maciej W. Rozycki wrote:

>  The best way to deal with spurious interrupts is to ack the interrupt at
> the device ASAP in the handler, especially if you know that the response
> is slow.

I am getting those from the lAPIC timer interrupt (on a VIA KM133 Duron
system). And the APIC timer interrupt IS acked (almost) immediately. So, I
have a choice: no NMI watchdog or that uncomfortably increasing ERR:
counter. Kernel 2.6.3.

Guennadi
---
Guennadi Liakhovetski


