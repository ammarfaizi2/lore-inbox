Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbUKANl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbUKANl7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 08:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbUKANl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 08:41:58 -0500
Received: from pop.gmx.de ([213.165.64.20]:62594 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262683AbUKANky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 08:40:54 -0500
X-Authenticated: #4399952
Date: Mon, 1 Nov 2004 14:40:18 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041101144018.24a7fea9@mango.fruits.de>
In-Reply-To: <20041101131511.GA16832@elte.hu>
References: <20041031124828.GA22008@elte.hu>
	<1099227269.1459.45.camel@krustophenia.net>
	<20041031131318.GA23437@elte.hu>
	<20041031134016.GA24645@elte.hu>
	<20041031162059.1a3dd9eb@mango.fruits.de>
	<20041031165913.2d0ad21e@mango.fruits.de>
	<20041101115546.GA2620@elte.hu>
	<20041101123701.GA4443@elte.hu>
	<1099312527.3337.5.camel@thomas>
	<20041101125127.GA13442@elte.hu>
	<20041101131511.GA16832@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004 14:15:11 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > [...] I am too seeing rtc_wakeup weirdnesses that were not present in
> > earlier -V0.6 kernels.
> 
> this turned out to be a user error - used the wrong script to renice
> IRQ8. Perhaps rtc_wakeup could check for the presence of IRQ 8 and chrt
> it to 99 if it's present? :-|

Hi,

well, how would i best check for the presence of the process/thread "IRQ 8"?
A quick glance through the output of apropos pid didn't show anything. i
suppose in the worst case i'd have to iterate over the list of all processes
and find the one that matches the name. Dunno how to do that either yet. If
it's fairly straightforward, i'll add it.

Although: is rtc always garanteed to be "IRQ 8" or is this only the case on
ia32 with XT-PIC?

?

flo
