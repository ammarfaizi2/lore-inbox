Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269245AbUJKVZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269245AbUJKVZI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 17:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269257AbUJKVZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 17:25:08 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:30865 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S269245AbUJKVZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 17:25:01 -0400
Message-ID: <32863.192.168.1.5.1097529721.squirrel@192.168.1.5>
In-Reply-To: <20041011142953.GA32607@elte.hu>
References: <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>
    <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu>
    <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu>
    <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu>
    <20041005134707.GA32033@elte.hu> <20041007105230.GA17411@elte.hu>
    <20041011142953.GA32607@elte.hu>
Date: Mon, 11 Oct 2004 22:22:01 +0100 (WEST)
Subject: Re: [patch] CONFIG_PREEMPT_REALTIME, 'Fully Preemptible Kernel',
      VP-2.6.9-rc4-mm1-T4
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>, "Florian Schmidt" <mista.tapas@gmx.net>,
       mark_h_johnson@raytheon.com,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Daniel Walker" <dwalker@mvista.com>, "Andrew Morton" <akpm@osdl.org>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 11 Oct 2004 21:24:59.0846 (UTC) FILETIME=[C359DE60:01C4AFD8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ingo Molnar
>
> i've released the -T4 VP patch:
>
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T4
>

Very rough indeed. First and only attempt on my SMP/HT box stumbled very
early at make time (CONFIG_PREEMPT_REALTIME=y):
...
arch/i386/kernel/i386_ksyms.c:166: error: `rtc_lock' undeclared here (not
in a function)
arch/i386/kernel/i386_ksyms.c:166: error: initializer element is not constant
arch/i386/kernel/i386_ksyms.c:166: error: (near initialization for
`__ksymtab_rtc_lock.value')
arch/i386/kernel/i386_ksyms.c:177: error: `atomic_dec_and_lock' undeclared
here(not in a function)
arch/i386/kernel/i386_ksyms.c:177: error: initializer element is not constant
arch/i386/kernel/i386_ksyms.c:177: error: (near initialization for
`__ksymtab_atomic_dec_and_lock.value')
arch/i386/kernel/i386_ksyms.c:166: error: __ksymtab_rtc_lock causes a
section type conflict
arch/i386/kernel/i386_ksyms.c:177: error: __ksymtab_atomic_dec_and_lock
causes a section type conflict
make[1]: *** [arch/i386/kernel/i386_ksyms.o] Error 1
make: *** [arch/i386/kernel] Error 2

Bye.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

