Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbULBTCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbULBTCy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 14:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbULBTCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 14:02:45 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:20608
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261286AbULBTCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 14:02:01 -0500
Subject: Re: [PATCH] oom killer (Core)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>, nickpiggin@yahoo.com.au
In-Reply-To: <20041202102935.5d75c2be.akpm@osdl.org>
References: <20041201104820.1.patchmail@tglx>
	 <20041201211638.GB4530@dualathlon.random>
	 <1101938767.13353.62.camel@tglx.tec.linutronix.de>
	 <20041202033619.GA32635@dualathlon.random>
	 <1101985759.13353.102.camel@tglx.tec.linutronix.de>
	 <1101995280.13353.124.camel@tglx.tec.linutronix.de>
	 <20041202164725.GB32635@dualathlon.random>
	 <20041202085518.58e0e8eb.akpm@osdl.org>
	 <20041202180823.GD32635@dualathlon.random>
	 <20041202102935.5d75c2be.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 02 Dec 2004 20:01:58 +0100
Message-Id: <1102014119.13353.235.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-02 at 10:29 -0800, Andrew Morton wrote:
> Could be, I dunno.  I've never done any work on the oom-killer and I tend
> to regard it as a stupid thing which is only there so you can get back into
> the machine to shut down and restart everything.
> 
> I mean, if you ran the machine out of memory then it is underprovisioned
> and it *will* become unreliable whatever we do.  The answer is to Not Do
> That.  As long as the oom-killer allows you to get in and admin the machine
> later on then that's good enough as far as I'm concerned.  Others probably
> disagree ;)

I agree, but the current situation made me drive 150km, because sshd or
even init was killed.

I hit this problem, when a forking server application got out of control
because there were suddenly connecting hundreds of clients due to a
different problem.

As long as I can log into the machine and fix the crap it's ok. There's
no need for anything else than accessability and a half way
deterministic behaviour.

tglx


