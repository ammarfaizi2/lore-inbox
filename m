Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWJPGuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWJPGuk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 02:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWJPGuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 02:50:40 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:57228 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751479AbWJPGuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 02:50:39 -0400
Date: Mon, 16 Oct 2006 08:43:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nicholas Miell <nmiell@comcast.net>
Cc: Jan Beulich <jbeulich@novell.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [build bug] x86_64, -git: Error: unknown pseudo-op: `.cfi_signal_frame'
Message-ID: <20061016064300.GA5839@elte.hu>
References: <20061016061037.GA12020@elte.hu> <1160980603.2388.9.camel@entropy> <20061016063602.GA4392@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061016063602.GA4392@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> Note that i override 'CC' instead of specifying a 'CROSS' prefix. I 
> suspect this means as-instr does not switch over to the 
> cross-environment and thus mis-detected the gas version?

this did not solve it either - it seems if both CROSS and CC are set 
then CC overrides it and CROSS is ignored? Removing the CC override 
solved the problem. But how do i insert the 'distcc' that way? Seems 
like a Kbuild breakage to me.

	Ingo
