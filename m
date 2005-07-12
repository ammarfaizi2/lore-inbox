Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVGLQED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVGLQED (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVGLQDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:03:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:52612 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261504AbVGLQBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:01:49 -0400
Date: Tue, 12 Jul 2005 18:01:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Daniel Walker <dwalker@mvista.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050712160150.GA23943@elte.hu>
References: <200507121223.10704.annabellesgarden@yahoo.de> <20050712140251.GB18296@elte.hu> <1121178339.10199.8.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050712142828.GA20798@elte.hu> <42D3D7ED.7000805@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D3D7ED.7000805@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> Ingo Molnar wrote:
> >* Daniel Walker <dwalker@mvista.com> wrote:
> >
> >
> >>I observed a situation on a dual xeon where IOAPIC_POSTFLUSH , if on, 
> >>would actually cause spurious interrupts. It was odd cause it's 
> >>suppose to stop them .. If there was a lot of interrupt traffic on one 
> >>IRQ , it would cause interrupt traffic on another IRQ. This would 
> >>result in "nobody cared" messages , and the storming IRQ line would 
> >>get shutdown.
> >>
> >>This would only happen in PREEMPT_RT .
> >
> >
> >does it happen with the latest kernel too? There were a couple of things 
> >broken in the IOAPIC code in various earlier versions.
> >
> >	Ingo
> 
> Is this why I have been able to boot the latest versions without the 
> noapic option (and without noticeable keyboard repeat problems) or has 
> it just been dumb luck?

yes, i think it's related - the IO-APIC code is now more robust than 
ever, and that's why any known-broken system would be important to 
re-check.

	Ingo
