Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTLUJO7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 04:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbTLUJO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 04:14:59 -0500
Received: from mx2.elte.hu ([157.181.151.9]:30922 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262344AbTLUJO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 04:14:58 -0500
Date: Sun, 21 Dec 2003 09:57:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christian Meder <chris@onestepahead.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
Message-ID: <20031221085716.GA21322@elte.hu>
References: <200312201355.08116.kernel@kolivas.org> <1071891168.1044.256.camel@localhost> <3FE3C6FC.7050401@cyberone.com.au> <1071893802.1363.21.camel@localhost> <3FE3D0CB.603@cyberone.com.au> <1071897314.1363.43.camel@localhost> <20031220111917.GA18267@elte.hu> <1071938978.1025.48.camel@localhost> <20031220174232.GA29189@elte.hu> <1071970825.1025.87.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071970825.1025.87.camel@localhost>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christian Meder <chris@onestepahead.de> wrote:

> I tried to verify your suggestion and found that the P_RTEMS symbol is
> not defined on Linux. It seems to be some other kind of realtime
> operating system. So the code in question already uses usleep. Now I'm
> still digging for other occurances of sched_yield in the pwlib
> sources.

could you try to strace -f gnomemeeting? Maybe there's no sched_yield()
at all. Could you also try to run the non-yielding loop code via:

	nice -19 ./loop &

do a couple of such loops still degrade gnomemeeting?

	Ingo
