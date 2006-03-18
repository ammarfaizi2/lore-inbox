Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWCRTMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWCRTMU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 14:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWCRTMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 14:12:20 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:65171 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750817AbWCRTMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 14:12:19 -0500
Date: Sat, 18 Mar 2006 20:10:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>
Subject: Re: [patch 1/2] Validate itimer timeval from userspace
Message-ID: <20060318191006.GA3939@elte.hu>
References: <20060318142827.419018000@localhost.localdomain> <20060318142830.607556000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318142830.607556000@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> According to the specification the timeval must be validated and an 
> errorcode -EINVAL returned in case the timeval is not in canonical 
> form. Before the hrtimer merge this was silently ignored by the 
> timeval to jiffies conversion. The validation is done inside 
> do_setitimer so all callers are catched.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

ok - bad (invalid) timevals were thus randomly interpreted? I agree that 
even though this is new behavior, it is much better to return -EINVAL 
than to behave randomly. OTOH, since 2.6.15 and earlier did this too, is 
there any urgency to apply this to 2.6.16?

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
