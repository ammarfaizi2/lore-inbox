Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264499AbUE0ONW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbUE0ONW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 10:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbUE0ONW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 10:13:22 -0400
Received: from mx2.elte.hu ([157.181.151.9]:21683 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264499AbUE0ONV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 10:13:21 -0400
Date: Thu, 27 May 2004 16:14:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ingo Molnar <mingo@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Cleanups for APIC
Message-ID: <20040527141404.GA23566@elte.hu>
References: <20040525124937.GA13347@elf.ucw.cz> <Pine.LNX.4.58.0405270856120.28319@devserv.devel.redhat.com> <Pine.LNX.4.55.0405271525140.10917@jurand.ds.pg.gda.pl> <Pine.LNX.4.58.0405270931040.28319@devserv.devel.redhat.com> <Pine.LNX.4.55.0405271542080.10917@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0405271542080.10917@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Maciej W. Rozycki <macro@ds2.pg.gda.pl> wrote:

>  The I/O APIC need not be hooked to PCI ;-) -- I'm not sure about the
> i82093AA, but that's definitely true for the i82489DX.  The call to
> io_apic_sync() is needed for masking to make sure interrupts won't be
> dispatched after returning from the call -- this is not needed for
> unmasking as a delay here is harmless.

well, an APIC message could be on the way to the CPU even with this
synchronization. Does it matter whether it's a newly dispatched one due
to POST delays or an in-fly one due to APIC bus delays?

	Ingo
