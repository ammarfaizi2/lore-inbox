Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268072AbUJNWYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268072AbUJNWYg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUJNWYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:24:10 -0400
Received: from mx1.elte.hu ([157.181.1.137]:49093 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268077AbUJNWWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:22:50 -0400
Date: Fri, 15 Oct 2004 00:24:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adam Heath <doogie@debian.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
Message-ID: <20041014222414.GA19961@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <Pine.LNX.4.58.0410141230380.1221@gradall.private.brainfood.com> <Pine.LNX.4.58.0410141716160.1221@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410141716160.1221@gradall.private.brainfood.com>
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


* Adam Heath <doogie@debian.org> wrote:

> > Seems to be working fine.  Has been running 11 minutes, without problems.
> >
> > ps: Something that irks me.  During bootup, I get the high-latency traces for
> >     swapper/0.  These fill up the dmesg ring buffer, so the early messages get
> >     dropped.  Is there anything that can be done to fix that?
> 
> Got my first message.
> 
> scheduling while atomic: kswapd0/0x04000001/10
> caller is cond_resched+0x53/0x70
>  [<c027ad31>] schedule+0x531/0x570
>  [<c027b2a3>] cond_resched+0x53/0x70
>  [<c012c604>] _mutex_lock+0x14/0x40
>  [<c0149521>] page_lock_anon_vma+0x31/0x60

i'm working on this one currently, it's a bit tricky.

	Ingo
