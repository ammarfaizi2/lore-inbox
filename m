Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267401AbUHPDyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267401AbUHPDyK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 23:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267407AbUHPDyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 23:54:09 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:6123 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267401AbUHPDyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 23:54:06 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816034618.GA13063@elte.hu>
References: <1092432929.3450.78.camel@mindpipe>
	 <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu>
	 <20040816022554.16c3c84a@mango.fruits.de>
	 <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu>
	 <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu>
Content-Type: text/plain
Message-Id: <1092628493.810.3.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 15 Aug 2004 23:54:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-15 at 23:46, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Sun, 2004-08-15 at 23:36, Ingo Molnar wrote:
> > > doh - i think i found a brown-paperbag bug.
> > 
> > Heh, this would explain all those latency traces with repeated 
> > calls to voluntary_resched...
> 
> hm, didnt those traces show preempt_schedule()?
> 

Yes, they did.

Anyway, the change to sched.c fixes the mlockall bug, it works perfectly
now.  Thanks!

I will try next with /dev/random disabled.  Don't most/many new machines
have a hardware RNG that would eliminate the need for this code?

Lee

