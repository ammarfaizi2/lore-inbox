Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267630AbUHJRRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267630AbUHJRRI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 13:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267627AbUHJRLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 13:11:18 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:38537 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267567AbUHJRK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 13:10:28 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040810085849.GC26081@elte.hu>
References: <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040809130558.GA17725@elte.hu> <20040809190201.64dab6ea@mango.fruits.de>
	 <1092103522.761.2.camel@mindpipe>  <20040810085849.GC26081@elte.hu>
Content-Type: text/plain
Message-Id: <1092157841.3290.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 13:10:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 04:58, Ingo Molnar wrote:

> another idea: you are running this on a C3, using CONFIG_MCYRIXIII,
> correct? That is one of the rare configs that triggers X86_USE_3DNOW and
> MMX ops. If 3dnow is in any way handicapped in that CPU then that could
> cause trouble. Could you compile for e.g. CONFIG_M586TSC? [that option
> should be fully compatible with a C3.] - this will exclude the MMX page
> clearing ops.
> 

OK, with CONFIG_M586TSC, I am getting a lot of lockups.  A few happened
during normal desktop use, and it locks up hard when starting jackd. 
Could this have anything to do with the ALSA drivers (which I am
compiling seperately from ALSA cvs) detecting my build system as i686? 
I have read that the C3 is more like a 486 (with MMX & 3DNow) than a
686.

Lee

 

