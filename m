Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268457AbUJJTof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268457AbUJJTof (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 15:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268458AbUJJTof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 15:44:35 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64914 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268457AbUJJTod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 15:44:33 -0400
Date: Sun, 10 Oct 2004 21:46:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       linux-kernel@vger.kernel.org,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>,
       "Amakarov@Ru. Mvista. Com" <amakarov@ru.mvista.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       "Ext-Rt-Dev@Mvista. Com" <ext-rt-dev@mvista.com>,
       New Zhang Haitao <hzhang@ch.mvista.com>,
       "Yyang@Ch. Mvista. Com" <yyang@ch.mvista.com>
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041010194604.GA10561@elte.hu>
References: <41677E4D.1030403@mvista.com> <20041010084633.GA13391@elte.hu> <1097437314.17309.136.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097437314.17309.136.camel@dhcp153.mvista.com>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> On Sun, 2004-10-10 at 01:46, Ingo Molnar wrote:
> >  - the generic irq subsystem: irq threading is a simple ~200-lines,
> >    architecture-independent add-on to this. It makes no sense to offer 3
> >    different implementations - pick one and help make it work well.
> > 
> >  - preemptible BKL. Related to this is new debugging infrastructure in
> >    -mm that allows the safe and slow conversion of spinlocks to mutexes. 
> >    In the case of the BKL this conversion is expected to be permanent, 
> >    for most of the other spinlocks it will be optional - but the 
> >    debugging code can still be used.
> 
> 	Are you referring to the lock metering? I've ported our changes
> to -mm3-VP-T3 on top of lock metering. It needs some clean up but It
> will be released soon. It's very similar to our rc3 release only
> without the IRQ threads patch.

no, i mean the smp_processor_id() debugger, and the other bits triggered
by CONFIG_DEBUG_PREEMPT.

	Ingo
