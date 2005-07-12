Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVGLOEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVGLOEH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVGLOEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:04:06 -0400
Received: from mx2.elte.hu ([157.181.151.9]:4585 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261459AbVGLODk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:03:40 -0400
Date: Tue, 12 Jul 2005 16:02:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050712140251.GB18296@elte.hu>
References: <200507121223.10704.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507121223.10704.annabellesgarden@yahoo.de>
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

> Hi Ingo
> 
> I've refined io_apic.c a little more:

great. I've applied these changes and have released the -28 patch. (note 
that the last chunk of your patch was malformed, have applied it by 
hand.)

i'm wondering what your thoughts are about IOAPIC_POSTFLUSH - i had to 
turn it on unconditionally again, to get rid of spurious interrupts and 
outright interrupt storms (and resulting lockups) on some systems.  
IOAPIC_POSTFLUSH is now causing much of the IO-APIC related IRQ handling 
overhead.

	Ingo
