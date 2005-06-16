Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVFPRfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVFPRfs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 13:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVFPRfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 13:35:48 -0400
Received: from mx2.elte.hu ([157.181.151.9]:7902 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261777AbVFPRfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 13:35:39 -0400
Date: Thu, 16 Jun 2005 19:32:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050616173247.GA32552@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com> <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B160F5.9060208@cybsft.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> > could you uncomment the IO_APIC_CACHE define in 
> > arch/i386/kernel/io_apic.c, and could you uncomment line 1109 in 
> > drivers/ide/ide-io.c - does this fix things? (in apic mode)

> Couple of things: 1) I could not find IO_APIC_CACHE anywhere. I could 
> find IOAPIC_CACHE but the define was not commented in io_apic.c. Also 
> the BUG_ON at line 1109 in ide-io.c was not commented out either. So I 
> made the mental leap that you actually meant to comment these out 
> instead of uncomment them??? [...]

yeah, sorry :-|

> [...] That works to get the system booted. Although I am getting many 
> soft lockups now, minutes after the boot. Log attached. [...]

hm, do you get actual lockups, or only the messages about them? I.e.  
does the system work fine if you [the sounds of careful thinking to get 
the word right] disable CONFIG_DETECT_SOFTLOCKUP, or does it lock up 
silently?

> [...] 2) In my infinite wisdom before :-) I failed to attach my config 
> as I should have done before. Also, commenting out

this looks like a sentence worth finishing? :)

	Ingo
