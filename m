Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUHJMiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUHJMiB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUHJMg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:36:27 -0400
Received: from the-village.bc.nu ([81.2.110.252]:52940 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264726AbUHJMgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:36:01 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040810092249.GA29875@elte.hu>
References: <1090832436.6936.105.camel@mindpipe>
	 <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu>
	 <20040809190201.64dab6ea@mango.fruits.de> <1092103522.761.2.camel@mindpipe>
	 <20040810085849.GC26081@elte.hu>  <20040810092249.GA29875@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092137588.16885.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 10 Aug 2004 12:33:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-10 at 10:22, Ingo Molnar wrote:
> another (more remote) possibility is that the timestamp counter gets
> somehow messed up during MMX ops. Does the ALSA detector use the
> timestamp counter, or does it only use jiffies? (if it only used jiffies
> that would give us some robustness since it's an independent
> time-source.) I suspect 'music indeed skips' isnt a good enough test for
> this case, given that jackd starts up ...

The standard VIA EPIA boards are 133Mhz SDRAM or 266Mhz DDR, which
is shared with video and the graphics engine. Could the MMX copier
simply be eating all the remaining memory bandwidth so that its
in fact memory not latency ?

