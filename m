Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWCNO1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWCNO1Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 09:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbWCNO1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 09:27:25 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:4483 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750786AbWCNO1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 09:27:25 -0500
Date: Tue, 14 Mar 2006 15:24:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Jan Altenberg <tb10alj@tglx.de>
Subject: Re: 2.6.16-rc6-rt3
Message-ID: <20060314142458.GA21796@elte.hu>
References: <20060314084658.GA28947@elte.hu> <4416C6DD.80209@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4416C6DD.80209@cybsft.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> This one doesn't want to boot on the old SMP box. Log and config attached.

>  [<c0111e19>] do_page_fault+0x36f/0x48a (88)
>  [<c010357f>] error_code+0x4f/0x54 (76)
>  [<c0132cc6>] resolve_symbol+0x22/0x5d (44)
>  [<c013321c>] simplify_symbols+0x81/0xf4 (40)
>  [<c0133e2d>] load_module+0x637/0x968 (168)
>  [<c01341c1>] sys_init_module+0x3d/0x1d3 (28)
>  [<c0102a1b>] sysenter_past_esp+0x54/0x75 (-8116)

hm, this seems to suggest some module building mismatch. Could you 
double-check that by doing a full rebuild?

	Ingo
