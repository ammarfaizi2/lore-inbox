Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267868AbUGaAel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267868AbUGaAel (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 20:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267887AbUGaAel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 20:34:41 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:6078 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267868AbUGaAej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 20:34:39 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-M5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Scott Wood <scott@timesys.com>
In-Reply-To: <1091228074.805.6.camel@mindpipe>
References: <1090732537.738.2.camel@mindpipe>
	 <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <1091141622.30033.3.camel@mindpipe>  <20040730064431.GA17777@elte.hu>
	 <1091228074.805.6.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1091234100.1677.41.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 30 Jul 2004 20:35:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 18:54, Lee Revell wrote:

> Here are my results with 2.6.8-rc2-mm1-M5.
> 
> 							max usecs
> All IRQs threaded					349
> Soundcard IRQ not threaded				227
> Soundcard IRQ not threaded + max_sectors_kb -> 64	119
> 
> I will test next with 2.6.8-rc2-M5.
> 

Results with 2.6.8-rc2-M5:

Configuration						max usecs
-----------------------------------------------------------------
All IRQs threaded					370 
Soundcard IRQ not threaded				335
Soundcard IRQ not threaded + max_sectors_kb -> 64	161

So, it looks like the added configurability does add some overhead - 161
usecs vs. 50.  mm1 is significantly better than the stock kernel.  The
above results imply that 2.6.8-rc2-mm1 with the irq.c hack would be
frighteningly good.

Lee

