Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbVKJUCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVKJUCK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 15:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVKJUCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 15:02:09 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:6052 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751221AbVKJUCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 15:02:08 -0500
Date: Thu, 10 Nov 2005 21:02:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Dinakar Guniguntala <dino@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: IO-APIC problem with 2.6.14-rt9
Message-ID: <20051110200205.GA4696@elte.hu>
References: <20051110200226.GA18780@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110200226.GA18780@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dinakar Guniguntala <dino@in.ibm.com> wrote:

> Hi,
> 
> I get this on boot with 2.6.14-rt9
> 
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#3.
> CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU3: Intel(R) Xeon(TM) MP CPU 2.50GHz stepping 05
> Total of 4 processors activated (11165.69 BogoMIPS).
> ENABLING IO-APIC IRQs
> ..TIMER: vector=0x31 pin1=2 pin2=-1
> ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> ...trying to set up timer (IRQ0) through the 8259A ...  failed.
> ...trying to set up timer as Virtual Wire IRQ... failed.
> ...trying to set up timer as ExtINT IRQ... failed :(.
> Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot with apic=debug and send a report.  Then try booting with the

does it help if you edit include/asm-i386/timex.h and change this line:

//#define ARCH_HAS_READ_CURRENT_TIMER  1

to:

#define ARCH_HAS_READ_CURRENT_TIMER  1

?

	Ingo

