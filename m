Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWGMJR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWGMJR5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 05:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWGMJR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 05:17:57 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:30094 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964859AbWGMJR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 05:17:56 -0400
Date: Thu, 13 Jul 2006 11:12:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Roman Zippel <zippel@linux-m68k.org>,
       Thomas Gleixner <tglx@linutronix.de>, mikpe@it.uu.se
Subject: Re: [RFC][PATCH] Kill i386 references to xtime
Message-ID: <20060713091218.GB7480@elte.hu>
References: <1152749914.11963.33.camel@localhost.localdomain> <1152750597.11963.43.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152750597.11963.43.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5286]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john stultz <johnstul@us.ibm.com> wrote:

> All,
> 	Just another cleanup patch from the C3 timekeeping tree (which you can
> find here: http://sr71.net/~jstultz/tod/ ) I wanted to RFC.
> 
> This patch kills all xtime references in i386 and replaces them with 
> proper settimeofday()/gettimeofday() calls.
> 
> I'm not sure the APM changes are 100% right, as that code is very
> muddled (take the i8253_lock before calling reinit_timer, which would
> take the i8253_lock again and hang if it weren't ifdef'ed out!).

yeah, that code looks very suspect.

> Anyway, testing, feedback or comments would be appreciated!

These cleanups look good to me. I gave your patch a testrun on a 
lockdep-enabled allyesconfig bzImage kernel on i686, and there are no 
apprent problems - it booted up just fine.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
