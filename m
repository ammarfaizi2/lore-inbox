Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269595AbUICKdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269595AbUICKdd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 06:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269599AbUICKdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 06:33:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:45788 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269595AbUICKbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 06:31:33 -0400
Date: Fri, 3 Sep 2004 12:32:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: linux-kernel@vger.kernel.org, rlrevell@joe-job.com,
       felipe_alfaro@linuxmail.org
Subject: Re: lockup with voluntary preempt R0 and VP, KP, etc, disabled
Message-ID: <20040903103244.GB23726@elte.hu>
References: <20040903120957.00665413@mango.fruits.de> <20040903100946.GA22819@elte.hu> <20040903123139.565c806b@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903123139.565c806b@mango.fruits.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> > best would be to enable the NMI watchdog (nmi_watchdog=1 (or 2) boot
> > option) - check that it's working via the attached lockupcli.c
> > userspace code (run it as root). To have an NMI watchdog you need
> > APIC/IOAPIC support in the .config.
> 
> Hmm, my local APIC kinda sux and i had all kinds of trouble using it
> [ERR count went up, stuff didn't work; XT-PIC always worked very well
> here]. So i'm kinda reluctant to compile with APIC. I suppose i can
> compile with it but turn it off via boot option? Or does the watchdog
> need a APIC that actually does stuff? 

in theory you should be able to boot with just the local APIC enabled
and "nmi_watchdog=2" and get a working NMI watchdog. You'll still have
the normal PIC IRQ handling.

	Ingo
