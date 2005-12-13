Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbVLMIPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbVLMIPv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbVLMIPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:15:51 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:17644 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932271AbVLMIPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:15:50 -0500
Date: Tue, 13 Dec 2005 09:15:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lee Revell <rlrevell@joe-job.com>, david singleton <dsingleton@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.15-rc5-rt1 will not compile (was Re: 2.6.14-rt15: cannot build with !PREEMPT_RT)
Message-ID: <20051213081502.GB10088@elte.hu>
References: <1133189789.5228.7.camel@mindpipe> <20051128160052.GA29540@elte.hu> <1133217651.4678.2.camel@mindpipe> <1133230103.5640.0.camel@mindpipe> <20051129072922.GA21696@elte.hu> <20051129093231.GA5028@elte.hu> <1134090316.11053.3.camel@mindpipe> <1134174330.18432.46.camel@mindpipe> <1134409469.15074.1.camel@mindpipe> <1134424143.24145.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134424143.24145.6.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Looks like Ingo has a generic rwsem to work with, but if your arch 
> turns on CONFIG_RWSEM_XCHGADD_ALGORITHM, it will compile lib/rwsem.c 
> which won't compile as you've seen.
> 
> Try out this patch: I changed the Makefile, instead of going to each 
> and every arch and change its Kconfig to do it properly.

i rather went for fixing up the Kconfig, that makes things easier to 
follow. If it turns out to be lots of duplicate stuff we could create a 
lib/Kconfig.rwsem that architectures can include.

	Ingo
