Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130636AbRCTTRe>; Tue, 20 Mar 2001 14:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130617AbRCTTRN>; Tue, 20 Mar 2001 14:17:13 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:60119 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S130616AbRCTTRK>; Tue, 20 Mar 2001 14:17:10 -0500
Message-ID: <3AB7AB66.46D0AB8E@mvista.com>
Date: Tue, 20 Mar 2001 11:11:34 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dawson Engler <engler@csl.Stanford.EDU>
CC: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
        mc@cs.Stanford.EDU
Subject: Re: [CHECKER] blocking w/ spinlock or interrupt's disabled
In-Reply-To: <200103190213.SAA23463@csl.Stanford.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson Engler wrote:
> 
> > Is it difficult to split it into "interrupts disabled" and "spin lock
> > held"?
> 
Is it difficult to test for matching spinlock pairs such as
spin_lock_irq/spin_unlock_irq.  Sometimes a spin_lock_irq is followed by
a spin_unlock and a separate interrupt re-enable.  This sort of usage,
while not strictly wrong, does make it hard to use the spin_lock/unlock
macros to do preemption.  This said, pairing information would be very
helpful.  Note, there are several flavors here, not just the one I
cited.

George
