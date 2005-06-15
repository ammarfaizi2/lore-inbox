Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVFOGM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVFOGM6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 02:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVFOGM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 02:12:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64443 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261504AbVFOGM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 02:12:56 -0400
Date: Wed, 15 Jun 2005 08:12:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050615061207.GB14717@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42AF20F9.20704@cybsft.com> <20050614185448.GA26731@elte.hu> <1118789122.10106.1.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118789122.10106.1.camel@dhcp153.mvista.com>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> > ah ... accidentaly had debug_direct_keyboard = 1 in kernel/irq/handle.c.  
> > Change it to 0 & recompile, or pick up the -48-33 patch i just uploaded.
> 
> I think your putting to many raw_local_irq_disable calls back in .. 
> Are you planning to do an audit at some point ?

correctness comes first. The softirq code needs to use the raw irq flag, 
because direct interrupts (the timer irq) may modify 
local_softirq_pending().

	Ingo
