Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267489AbUHJSA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267489AbUHJSA0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbUHJR6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 13:58:00 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:58510 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267481AbUHJRlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 13:41:35 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Jones <davej@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040810173302.GA22928@redhat.com>
References: <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040809130558.GA17725@elte.hu> <20040809190201.64dab6ea@mango.fruits.de>
	 <1092103522.761.2.camel@mindpipe> <20040810085849.GC26081@elte.hu>
	 <1092157841.3290.3.camel@mindpipe>  <20040810173302.GA22928@redhat.com>
Content-Type: text/plain
Message-Id: <1092159714.782.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 13:41:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 13:33, Dave Jones wrote:
> On Tue, Aug 10, 2004 at 01:10:42PM -0400, Lee Revell wrote:
> If you have an early C3  (ie, pre Nehemiah model), then you will lack
> the cmov instruction that gcc assumes is in 686's.  If the ALSA scripts
> aren't aware of this, they will generate code which your CPU cannot run.
> 

This is what I have, the first of their fanless models I believe, 600Mhz
C3.

However ALSA always detected the CPU as a 686 and I never had problems,
it's definitely the change from CONFIG_MCYRIXIII to CONFIG_M586TSC that
started the lockups.

I recompiled all the ALSA libs and jackd, same problem - starting jackd
causes immediate lockup.  Now building with M486.

Lee

