Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267304AbUHPATw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267304AbUHPATw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 20:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267298AbUHPATw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 20:19:52 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:27029 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267311AbUHPATg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 20:19:36 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816022554.16c3c84a@mango.fruits.de>
References: <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu>
	 <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe>
	 <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe>
	 <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu>
	 <20040816022554.16c3c84a@mango.fruits.de>
Content-Type: text/plain
Message-Id: <1092615621.867.36.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 15 Aug 2004 20:20:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-15 at 20:25, Florian Schmidt wrote:
> On Sun, 15 Aug 2004 13:56:49 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > i've uploaded the -P0 patch:
> > 
> >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P0
> 
> I haven't tried this patch yet, but i have a question regarding the
> mlockall issue:
> 
> Jackd also uses IPC mechnisms for remote procedure calls [i think,
> please correct me] and makes heavy use of shared memory. Might
> mlock(all) have influence of this? is jackd maybe producing xruns
> because some IPC stuff blocks when mlockall is used?
> 
> I'm just guessing wildly and uneducatedly..

FWIW, mlockall by an unrelated normal-priority process still causes
xruns in the SCHED_FIFO jackd process even when jackd is run with no
clients.

Lee

