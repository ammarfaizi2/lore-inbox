Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267312AbUHPAXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUHPAXF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 20:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267306AbUHPAXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 20:23:04 -0400
Received: from pop.gmx.net ([213.165.64.20]:22220 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267298AbUHPAWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 20:22:48 -0400
X-Authenticated: #4399952
Date: Mon, 16 Aug 2004 02:33:21 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
Message-Id: <20040816023321.26da7694@mango.fruits.de>
In-Reply-To: <1092615621.867.36.camel@krustophenia.net>
References: <20040726204720.GA26561@elte.hu>
	<20040729222657.GA10449@elte.hu>
	<20040801193043.GA20277@elte.hu>
	<20040809104649.GA13299@elte.hu>
	<20040810132654.GA28915@elte.hu>
	<20040812235116.GA27838@elte.hu>
	<1092382825.3450.19.camel@mindpipe>
	<20040813104817.GI8135@elte.hu>
	<1092432929.3450.78.camel@mindpipe>
	<20040814072009.GA6535@elte.hu>
	<20040815115649.GA26259@elte.hu>
	<20040816022554.16c3c84a@mango.fruits.de>
	<1092615621.867.36.camel@krustophenia.net>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004 20:20:22 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> > Jackd also uses IPC mechnisms for remote procedure calls [i think,
> > please correct me] and makes heavy use of shared memory. Might
> > mlock(all) have influence of this? is jackd maybe producing xruns
> > because some IPC stuff blocks when mlockall is used?
> > 
> > I'm just guessing wildly and uneducatedly..
> 
> FWIW, mlockall by an unrelated normal-priority process still causes
> xruns in the SCHED_FIFO jackd process even when jackd is run with no
> clients.

Hmm, yes, my thought was that jackd maybe expects some IPC stuff to
return immeaditly or have bounded execution times while this maybe is
not really always garanteed.. Need to look at the source.

Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/

