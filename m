Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUKFMGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUKFMGW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 07:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbUKFMGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 07:06:22 -0500
Received: from mx1.elte.hu ([157.181.1.137]:54920 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261378AbUKFMGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 07:06:10 -0500
Date: Sat, 6 Nov 2004 13:05:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Amit Shah <amitshah@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RT-preempt-2.6.10-rc1-mm2-V0.7.11 hang
Message-ID: <20041106120525.GA15363@elte.hu>
References: <200411051837.02083.amitshah@gmx.net> <20041105134639.GA14830@elte.hu> <200411061414.11719.amitshah@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411061414.11719.amitshah@gmx.net>
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


* Amit Shah <amitshah@gmx.net> wrote:

> I had left the machine running overnight; I got a few BUGs and some
> spinlock hold counts.
> 
> The message mentioned above about the e1000 xmit frame also keeps
> appearing, but does not result in hangs.
> 
> I've uploaded the /var/log/messages file to
> 
>  http://amitshah.nav.to/kernel/messages-rt-0.7.13.txt
> 
> Please take a look.

found the bug(s), the e1000 driver disabled interrupts on
PREEMPT_REALTIME too, and the debug-message printout had a bug as well.
Found a similar problem in the tg3 driver too. Could you check out
-V0.7.15 that i've just uploaded to:

   http://redhat.com/~mingo/realtime-preempt/

does this work any better? [you'll still get the e100 message but that
is harmless.]

	Ingo
