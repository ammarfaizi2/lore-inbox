Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWGKPas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWGKPas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWGKPas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:30:48 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:28601
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S1751290AbWGKPar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:30:47 -0400
Date: Tue, 11 Jul 2006 17:31:17 +0200
From: andrea@cpushare.com
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060711153117.GJ7192@opteron.random>
References: <20060629192121.GC19712@stusta.de> <1151628246.22380.58.camel@mindpipe> <20060629180706.64a58f95.akpm@osdl.org> <20060630014050.GI19712@stusta.de> <20060630045228.GA14677@opteron.random> <20060630094753.GA14603@elte.hu> <20060630145825.GA10667@opteron.random> <20060711073625.GA4722@elte.hu> <20060711141709.GE7192@opteron.random> <1152628374.3128.66.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152628374.3128.66.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 04:32:53PM +0200, Arjan van de Ven wrote:
> as far as I can see Fedora has SECCOMP off for a long time already

Well, I didn't know about it... Long time can't be more than a few
months because I was sure in older releases it was enabled because I had
people running seccomp code on fedora.

I never expect it was easy thing to startup the CPUShare project, but
one thing that I didn't expect however was this kind of behaviour from
the leading linux vendor, I didn't get a single email of questions and I
wasn't informed about this, despite they know me perfectly. This
effectively reminds me about the high profile news articles I keep
reading recently that on the sidelines mentions about some RH behaviour
in the industry.

> if there is overhead, and there is no general use for it (which there
> isn't really) then it should be off imo.

I hope the reason was the lack of my last patch. But even in such case
RH could have turned off the tsc thing immediately themself (they know
how to patch the kernel no?) or they could have asked me a single
question about it before turning it off, no?

I hope RH will reconsider with my last patch applied and at the light of
this email as well:

	http://www.cpushare.com/hypermail/cpushare-discuss/06/01/0080.html

If they don't reconsider I'll be forced to recommend the Fedora CPUShare
users to switch distro if they don't want having to recompile the kernel
by themself.

I guess now I understand why this new change of mind of Ingo: if he
would succeed to push the N in the main kernel, then nobody could
complain to fedora for setting it to N, while they're in a less obvious
position at the moment where the kernel says "default to y" and they set
it to N to be happy.

As for no general use, this is the people that certainly used seccomp so
far:

cpushare=> select count(*) from accounts where cpucoins != 0;
 count 
-------
   122
(1 row)

cpushare=> 

remove 1 that is myself, that leaves 121 persons using seccomp so far
in CPUShare context. One first user already started buying CPU resource
a few days ago, and he's currently computing his own seccomp bytecode
remotely as we speak. So unless they're all wasting their time by
helping me testing the stuff, I'm not the only one that find at least
one useful usage for seccomp (but I think there are many more if only
people would care to use it). Certainly the FUD about the Y and N
availability doesn't help in convincing people to use seccomp to
strengthen decompression security etc...
