Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbUJaO7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUJaO7b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 09:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUJaO7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 09:59:31 -0500
Received: from imap.gmx.net ([213.165.64.20]:63960 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261653AbUJaO7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 09:59:18 -0500
X-Authenticated: #4399952
Date: Sun, 31 Oct 2004 16:59:13 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041031165913.2d0ad21e@mango.fruits.de>
In-Reply-To: <20041031162059.1a3dd9eb@mango.fruits.de>
References: <1099165925.1972.22.camel@krustophenia.net>
	<20041030221548.5e82fad5@mango.fruits.de>
	<1099167996.1434.4.camel@krustophenia.net>
	<20041030231358.6f1eeeac@mango.fruits.de>
	<1099171567.1424.9.camel@krustophenia.net>
	<20041030233849.498fbb0f@mango.fruits.de>
	<20041031120721.GA19450@elte.hu>
	<20041031124828.GA22008@elte.hu>
	<1099227269.1459.45.camel@krustophenia.net>
	<20041031131318.GA23437@elte.hu>
	<20041031134016.GA24645@elte.hu>
	<20041031162059.1a3dd9eb@mango.fruits.de>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Oct 2004 16:20:59 +0100
Florian Schmidt <mista.tapas@gmx.net> wrote:

> 
> V0.6.2 works pretty good. max jitter until now 21% [205us]. still fiddling
> with the output formatting for rtc_wakeup.
> 

i got a deadlock though. it was a weird one. mouse and keyboard [including
sysrq] froze. but the find / i started kept on running in an xterm. had to
press reset due to lack of second machine..

flo

p.s. new rtc_wakeup version uploaded, which shows the percentage converted
to usecs (always positive, you need the sign?). btw: with V0.6.2 i sometimes
see jitter > 100% but still no lost irq (/dev/rtc still reports only 1
delivered irq on next wakeup). I cannot provke lost irqs with -f up to 2048.
With -f 8192 i do get lost irq's [not amazing though].
