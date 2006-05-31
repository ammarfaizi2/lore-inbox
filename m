Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbWEaVw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbWEaVw7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbWEaVw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:52:59 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:56463 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965146AbWEaVw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:52:58 -0400
Date: Wed, 31 May 2006 23:53:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@google.com>,
       linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060531215315.GB4059@elte.hu>
References: <447DEF47.6010908@google.com> <20060531140823.580dbece.akpm@osdl.org> <20060531211530.GA2716@elte.hu> <447E0A49.4050105@mbligh.org> <20060531213340.GA3535@elte.hu> <447E0DEC.60203@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447E0DEC.60203@mbligh.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5893]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Martin J. Bligh <mbligh@mbligh.org> wrote:

> >>Grrr. Humpf. I can't see the option being turned on for lockdep ...
> >>what was the config option, and is it enabled by default?
> 
> In the -mm1 patch:
> 
>  config DEBUG_MUTEXES
> -       bool "Mutex debugging, deadlock detection"
> -       default n
> +       bool "Mutex debugging, basic checks"
> +       default y
> 
> Please don't do thatas a default.

but ... i fixed the performance problem that caused the previous 
DEBUG_MUTEXES scalability problems. (there's no global mutex list 
anymore) We also default to e.g. DEBUG_SLAB which is alot more costly.

> It fucks up all the performance checking ;-(

i'm wondering, why doesnt your config have DEBUG_MUTEXES disabled? Then 
'make oldconfig' would pick it up automatically.

	Ingo
