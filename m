Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWIPXtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWIPXtZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 19:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWIPXtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 19:49:25 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:64195 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964873AbWIPXtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 19:49:24 -0400
Date: Sun, 17 Sep 2006 01:40:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060916234047.GA26846@elte.hu>
References: <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal> <20060916173552.GA7362@elte.hu> <20060916175606.GA2837@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060916175606.GA2837@Krystal>
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


* Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:

> > > Third run : same LTTng instrumentation, with a kprobe handler 
> > > triggered by each event traced.
> > 
> > where exactly did you put the kprobe handler?
> 
> ltt_relay_reserve_slot.
> 
> See http://ltt.polymtl.ca/svn/tests/kernel/test-kprobes.c to insert 
> the kprobe. Tests done on LTTng 0.5.111, on a x86 3GHz with 
> hyperthreading.

ok. In what way did you enable LTTng instrumentation? I have 0.5.108 
installed, and i'd like to make sure i do everything as you did, to make 
the tests comparable. Which kernel config options (default ones?), and 
what precise lttcl commands did you use, were they the usual:

  lttctl -n trace -d -l /mnt/debugfs/ltt -t /tmp/trace

? What filesystem does /tmp/trace reside on?

	Ingo
