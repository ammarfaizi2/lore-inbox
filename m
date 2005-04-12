Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbVDLXtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbVDLXtE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVDLXrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 19:47:05 -0400
Received: from mx1.elte.hu ([157.181.1.137]:49080 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263033AbVDLXJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 19:09:31 -0400
Date: Wed, 13 Apr 2005 01:09:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUGs in 2.6.12-rc2-RT-V0.7.45-01
Message-ID: <20050412230921.GA22360@elte.hu>
References: <Pine.LNX.4.58.0504121443310.3023@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504121443310.3023@echo.lysdexia.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Weston <weston@sysex.net> wrote:

> Triggered when running 'yum update', followed by system lockup within 
> one minute:
> 
> BUG: sleeping function called from invalid context python(4302) at kernel/rt.c:1613
> in_atomic():1 [00000001], irqs_disabled():1
>  [<c0103dba>] dump_stack+0x23/0x25 (20)
>  [<c0119ed0>] __might_sleep+0xd8/0xed (36)
>  [<c0139bbc>] __spin_lock+0x34/0x50 (24)
>  [<c0139bf5>] _spin_lock+0x1d/0x1f (16)
>  [<c01465cf>] lock_kprobes+0x17/0x23 (12)
>  [<c01122c9>] kprobe_handler+0xa9/0x209 (32)
>  [<c011251c>] kprobe_exceptions_notify+0x48/0x13c (28)

what are you using kprobes for? Do you get lockups even if you disable 
kprobes?

	Ingo
