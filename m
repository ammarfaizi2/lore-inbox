Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbUJXVWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbUJXVWw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 17:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbUJXVWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 17:22:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:53455 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261196AbUJXVWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 17:22:50 -0400
Date: Sun, 24 Oct 2004 23:23:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jon Masters <jonathan@jonmasters.org>
Cc: paulmck@us.ibm.com, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, karim@opersys.com
Subject: Re: [RFC][PATCH] Restricted hard realtime
Message-ID: <20041024212359.GA7328@elte.hu>
References: <20041023194721.GB1268@us.ibm.com> <1098562921.3306.182.camel@thomas> <20041023212421.GF1267@us.ibm.com> <35fb2e5904102315066c6892aa@mail.gmail.com> <20041024153204.GA1262@us.ibm.com> <417C19D5.7050802@jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417C19D5.7050802@jonmasters.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jon Masters <jonathan@jonmasters.org> wrote:

> I guess it would. But then we've just had a slew of RT implementations
> crawl out of the woodwork and wave at us over the past few weeks and
> there are three other major RT implementations which combine Linux
> with a Microkernel or other external support (RTLinux, RTAI, KURT,
> etc.). Perhaps it's worth working on one of the Linux patch projects
> (Monta/Ingo/etc.) rather than going all out to implement it all again.

also note that (as i mentioned it in an earlier reply to Paul) the
'CPU[s] isolated for hard-RT use' scheduler feature has already been
implemented by Dimitri Sivanich and was accepted and integrated into the
2.6.9 kernel a couple of weeks ago.

Isolated CPUs can be set up via the "isolcpus=" boot parameter, and can
be entered via the affinity syscall. The feature came with related fixes
to the scheduler and other kernel code to eliminate cross-effects
between domains. (such as the scheduler balancing code, or the swap
tick)

So this all is banging on open doors, this particular mode of hard-RT
scheduling is there and available in vanilla Linux. If anyone wants to
try it, just download 2.6.9 and use it.

	Ingo
