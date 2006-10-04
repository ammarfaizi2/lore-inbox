Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161164AbWJDIFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161164AbWJDIFJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 04:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161162AbWJDIFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 04:05:08 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:7645 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161164AbWJDIFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 04:05:05 -0400
Date: Wed, 4 Oct 2006 09:56:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Valdis.Kletnieks@vt.edu
Cc: tglx@linutronix.de, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Jim Gettys <jg@laptop.org>,
       John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch] dynticks core: Fix idle time accounting
Message-ID: <20061004075657.GA31485@elte.hu>
References: <20061001225720.115967000@cruncher.tec.linutronix.de> <200610021302.k92D23W1003320@turing-police.cc.vt.edu> <1159796582.1386.9.camel@localhost.localdomain> <200610021825.k92IPSnd008215@turing-police.cc.vt.edu> <1159814606.1386.52.camel@localhost.localdomain> <200610022017.k92KH4Ch004773@turing-police.cc.vt.edu> <1159824158.1386.77.camel@localhost.localdomain> <200610022135.k92LZHCn008618@turing-police.cc.vt.edu> <1159905750.1386.215.camel@localhost.localdomain> <200610040233.k942Xk1v004859@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610040233.k942Xk1v004859@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4926]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:

> Even though I have CONFIG_HZ=1000, this ends up generating a synthetic 
> count that works out to 100 per second.  gkrellm and vmstat are happy 
> with that state of affairs, but I'm not sure why it came out to 
> 100/sec rather than 1000/sec.

that's how it worked for quite some time: all userspace APIs are 
HZ-independent and depend on USER_HZ (which is 100 even if HZ is 1000).

	Ingo
