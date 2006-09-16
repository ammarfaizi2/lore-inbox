Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWIPXcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWIPXcv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 19:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWIPXcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 19:32:50 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:4561 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964870AbWIPXcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 19:32:50 -0400
Date: Sun, 17 Sep 2006 01:24:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: karim@opersys.com, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>, fche@redhat.com
Subject: Re: [patch] kprobes: optimize branch placement
Message-ID: <20060916232446.GB23132@elte.hu>
References: <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal> <20060916173552.GA7362@elte.hu> <20060916175606.GA2837@Krystal> <20060916191043.GA22558@elte.hu> <20060916193745.GA29022@elte.hu> <20060916202939.GA4520@elte.hu> <20060916204342.GA5208@elte.hu> <450C7039.20208@opersys.com> <20060916155704.ef425542.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060916155704.ef425542.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Sat, 16 Sep 2006 17:44:25 -0400
> Karim Yaghmour <karim@opersys.com> wrote:
> 
> > So now you're resorting to your uber-talents as a kernel guru to 
> > bury the other side?
> 
> It's hardly rocket science - it appears that nobody has ever bothered.

yeah. Performance of kprobes was never really a big issue, kprobes were 
always more than fast enough in my opinion. Would be nice if Mathieu 
could try to re-run his kprobes test with these patches applied. I still 
havent given up on the hope of convincing the LTT folks that they 
shouldnt let their sizable codebase drop on the floor but should attempt 
to integrate it with kprobes/systemtap. There's nothing wrong with what 
LTT gives to users, it's just the tracing engine itself (the static hook 
based component) that i have a conceptual problem with - not with the 
rest. Most of the know-how of tracers is in the identification of the 
information that should be extracted, its linkup and delivery to 
user-space tools.

	Ingo
