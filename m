Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVA1P3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVA1P3Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 10:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVA1P3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 10:29:24 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:6240
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261451AbVA1P3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 10:29:18 -0500
Date: Fri, 28 Jan 2005 16:29:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Mauricio Lin <mauriciolin@gmail.com>
Cc: tglx@linutronix.de, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Edjard Souza Mota <edjard@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       ville.medeiros@gmail.com
Subject: Re: User space out of memory approach
Message-ID: <20050128152928.GF8518@opteron.random>
References: <3f250c7105012113455e986ca8@mail.gmail.com> <20050122033219.GG11112@dualathlon.random> <3f250c7105012513136ae2587e@mail.gmail.com> <1106689179.4538.22.camel@tglx.tec.linutronix.de> <3f250c71050125161175234ef9@mail.gmail.com> <20050126004901.GD7587@dualathlon.random> <3f250c7105012710541d3e7ad1@mail.gmail.com> <20050127221129.GX8518@opteron.random> <3f250c7105012805585c01a26@mail.gmail.com> <3f250c71050128072151b46a2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f250c71050128072151b46a2b@mail.gmail.com>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 11:21:11AM -0400, Mauricio Lin wrote:
> As you know, Andrew generated the patch. Here goes some test results
> about your OOM Killer and the Original OOm Killer. We accomplished 10
> experiments for each OOM Killer and below are average values.
> 
> "Invocations" is the number of times that out_of_memory function is
> called. "Selections" is the number of times that select_bad_process
> function is called and "Killed" is the number of killed process.
> 
> Original OOM Killer
> Invocations average = 51620/10 = 5162
> Selections average = 30/10 = 3
> Killed average = 38/10 = 3.8
> 
> Andrea OOM Killer
> Invocations average = 213/10 = 21.3
> Selections average = 213/10 = 21.3
> Killed average = 52/10 = 5.2
> 
> As you can see the number of invocations reduced significantly using
> your OOM Killer.

Yep, thanks for testing!

> I did not know about this problem when I was moving the original
> ranking algorithm to userland. As Thomaz mentioned: invocation
> madness, reentrancy problems and those strange timers and counter as
> now, since, last, lastkill and count. I guess that now i can put some
> OOM Killer stuffs in userland in a safer manner with those problems
> solved, right?

Yep ;)

> BTW, will your OOM Killer be included in the kernel tree?

Yes, Andrew said it should go in the next few days, which is a great
news, thanks everyone!
