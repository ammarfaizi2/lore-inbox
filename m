Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267461AbUHPGrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267461AbUHPGrP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 02:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbUHPGrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 02:47:15 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:38540 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267461AbUHPGrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 02:47:13 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P1
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816040515.GA13665@elte.hu>
References: <20040815115649.GA26259@elte.hu>
	 <20040816022554.16c3c84a@mango.fruits.de>
	 <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu>
	 <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu>
Content-Type: text/plain
Message-Id: <1092638883.793.16.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 02:48:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 00:05, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Anyway, the change to sched.c fixes the mlockall bug, it works
> > perfectly now.  Thanks!
> 
> great! This fix also means that we've got one more lock-break in the
> ext3 journalling code and one more lock-break in dcache.c. I've released
> -P1 with the fix included:
> 
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P1
> 

Ok, there is a visible difference from P0 to P1 with the extract_entropy
and via-rhine hacks:

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P0
http://krustophenia.net/testresults.php?dataset=2.6.8.1-P1

The left spike is bigger with P1, which is more easily visible on linear
scaled graph on the left, as we are hitting the fast path more often. 
Also the smaller spike at 400 usecs disappears.

Lee

