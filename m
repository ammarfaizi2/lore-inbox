Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269116AbUJQNUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269116AbUJQNUV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 09:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269117AbUJQNUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 09:20:20 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52396 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269116AbUJQNUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 09:20:05 -0400
Date: Sun, 17 Oct 2004 15:21:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Daniel Walker <dwalker@mvista.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>, Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
Message-ID: <20041017132107.GA18462@elte.hu>
References: <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <1097888438.6737.63.camel@krustophenia.net> <1097894120.31747.1.camel@krustophenia.net> <20041016064205.GA30371@elte.hu> <1097917325.1424.13.camel@krustophenia.net> <20041016103608.GA3548@elte.hu> <32801.192.168.1.5.1098018846.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32801.192.168.1.5.1098018846.squirrel@192.168.1.5>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> The point where the boot/init sequence stalls is marked with a
> "<<<---STALL--->>>" line mark. Then it follows the output of SysRq-S
> (Sync), SysRq-T (Trace), another SysRq-S (Sync), and finally a SysRq-B
> (reBoot).

thanks. Could you send me the full successful bootlog of -U4 with
PREEMPT_REALTIME disabled (but otherwise the same .config)?

this looks suspicious:

eth0: -- ERROR --
        Class:  internal Software error
        Nr:  0x1ae
        Msg:  General: Driver release date not initialized
eth0: -- ERROR --
        Class:  internal Software error
        Nr:  0x1ae
        Msg:  General: Driver release date not initialized
eth0: 3Com Gigabit LOM (3C940)
eth0: network connection down
      PrefPort:A  RlmtMode:Check Link State

is this normal? Could the stall simply be a bootup stall due to no
network available?

	Ingo
