Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266029AbTLIPUy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 10:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266037AbTLIPUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 10:20:54 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:5032 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S266029AbTLIPUx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 10:20:53 -0500
Date: Tue, 9 Dec 2003 16:20:27 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ross Dickson <ross@datscreative.com.au>
Cc: linux-kernel@vger.kernel.org, AMartin@nvidia.com, andre@linux-ide.org,
       kernel@kolivas.org
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
In-Reply-To: <200312072312.01013.ross@datscreative.com.au>
Message-ID: <Pine.LNX.4.55.0312091610320.20948@jurand.ds.pg.gda.pl>
References: <200312072312.01013.ross@datscreative.com.au>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Dec 2003, Ross Dickson wrote:

> b) I was also disappointed to see I could not have irq0 timer IO-APIC-edge. 
> So I have fixed it too (tested on both my epox and albatron MOBOs).
> Firstly I found 8254 connected directly to pin 0 not pin 2 of io-apic.
> I have modified check_timer() in io_apic.c to trial connect pin and test for it
> after the existing test for connection to io-apic.

 I'm pretty sure this part is bogus.  Have you actually verified it either
by using a hardware probe or at least by investigating documentation you
really have IRQ 0 routed to the I/O APIC interrupt #0 (INTIN 0)?  If no,
then you can almost surely see interrupts travelling across the pair of
8259A PICS which are connected to the INTIN 0 input of the first I/O APIC
in every IA32-based PC system providing an I/O APIC seen so far.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
