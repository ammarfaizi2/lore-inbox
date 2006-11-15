Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030791AbWKOSFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030791AbWKOSFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030792AbWKOSFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:05:52 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:2715 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030791AbWKOSFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:05:50 -0500
Date: Wed, 15 Nov 2006 19:04:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: sleeping functions called in invalid context during resume
Message-ID: <20061115180436.GB29795@elte.hu>
References: <20061114223002.10c231bd@localhost.localdomain> <20061115012025.13c72fc1.akpm@osdl.org> <20061115093354.GA30813@elte.hu> <20061115100119.460b7a4e@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061115100119.460b7a4e@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Stephen Hemminger <shemminger@osdl.org> wrote:

> > The patch below makes use of that capability of lockdep for all 
> > stackdumps that are printed to the console. Stephen, please apply 
> > this patch, enable CONFIG_PROVE_LOCKING and try to trigger another 
> > message.
> 
> I tried but with CONFIG_PROVE_LOCKING, resume gets stuck in an 
> infinite loop backtracing to the console.  Unfortunately, the serial 
> console isn't up at that point so it it isn't capturable.

hm - could you change the stack- UNWIND option (to on or off) to see 
whether that makes a difference? If it doesnt help, could you try 
CONFIG_DISABLE_CONSOLE_SUSPEND [but that might hang your resume earlier 
than the bug triggers].

	Ingo
