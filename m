Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbUJaXRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbUJaXRO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 18:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbUJaXRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 18:17:13 -0500
Received: from tron.kn.vutbr.cz ([147.229.191.152]:28432 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261688AbUJaXQz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 18:16:55 -0500
Message-ID: <4185724B.8090802@stud.feec.vutbr.cz>
Date: Mon, 01 Nov 2004 00:16:27 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
References: <1099165925.1972.22.camel@krustophenia.net> <20041030221548.5e82fad5@mango.fruits.de> <1099167996.1434.4.camel@krustophenia.net> <20041030231358.6f1eeeac@mango.fruits.de> <1099171567.1424.9.camel@krustophenia.net> <20041030233849.498fbb0f@mango.fruits.de> <20041031120721.GA19450@elte.hu> <20041031124828.GA22008@elte.hu> <1099227269.1459.45.camel@krustophenia.net> <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu>
In-Reply-To: <20041031134016.GA24645@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (0.6 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -0.1 BAYES_20               BODY: Bayesian spam probability is 20 to 30%
                              [score: 0.2565]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i've just uploaded V0.6.2 that fixes a console-unblanking-timer thinko. 
> This bug was present for quite some time, but this is the first time it 
> triggered on my testbox - might be more common on others.
> 
> 	Ingo

Hi Ingo,
I finally got to test your patch again. Now I've been running -V0.6.2 
for almost two hours and have not yet encountered a single deadlock.
So it seems that the netfilter deadlock, that I could easily reproduce 
in -V0.4.1, is solved.

There is one strange thing, though:
michich@k4-912b:~$ uptime
  00:09:17 up  1:49,  7 users,  load average: 707.72, 706.40, 682.16

In fact my computer is mostly idle.
ps shows no zombies nor any D-state processes. The system runs fine.

Michal
