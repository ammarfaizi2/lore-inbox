Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVGPTdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVGPTdz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 15:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVGPTdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 15:33:55 -0400
Received: from mx2.elte.hu ([157.181.151.9]:63652 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261158AbVGPTdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 15:33:45 -0400
Date: Sat, 16 Jul 2005 21:32:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: William Weston <weston@sysex.net>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050716193243.GA22112@elte.hu>
References: <200507121223.10704.annabellesgarden@yahoo.de> <200507130204.08824.annabellesgarden@yahoo.de> <Pine.LNX.4.58.0507121706210.21776@echo.lysdexia.org> <200507151405.59961.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507151405.59961.annabellesgarden@yahoo.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> This is it. Apply it on top of -51-30 and 'make oldconfig'. You'll be 
> asked about the new CONFIG_ONE_IOAPIC. Answering yes, io_apic_one.c 
> will be used, which is ((io_apic.c minus quirks) minus 
> multi_io_apic_capability) . It'll propably crash some machines, as the 
> quirks are there for some reason... With CONFIG_ONE_IOAPIC unset, 
> you'll get the same kernel as with my previously sent patch. have fun 
> :-)

this could only be offered if it's merged into the existing io_apic.c.  
The current IOAPIC_FAST option will go away eventually, but ONE_IOAPIC 
would/could be intentionally incompatible.

	Ingo
