Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbUJaWMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbUJaWMV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 17:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUJaWMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 17:12:14 -0500
Received: from relay02.pair.com ([209.68.5.16]:62472 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S261666AbUJaWMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 17:12:02 -0500
X-pair-Authenticated: 66.190.53.4
Message-ID: <4185632B.4020407@cybsft.com>
Date: Sun, 31 Oct 2004 16:11:55 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Florian Schmidt <mista.tapas@gmx.net>, Lee Revell <rlrevell@joe-job.com>,
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
References: <20041030115808.GA29692@elte.hu> <1099158570.1972.5.camel@krustophenia.net> <20041030191725.GA29747@elte.hu> <20041030214738.1918ea1d@mango.fruits.de> <1099165925.1972.22.camel@krustophenia.net> <20041030221548.5e82fad5@mango.fruits.de> <1099167996.1434.4.camel@krustophenia.net> <20041030231358.6f1eeeac@mango.fruits.de> <1099171567.1424.9.camel@krustophenia.net> <20041030233849.498fbb0f@mango.fruits.de> <20041031120721.GA19450@elte.hu>
In-Reply-To: <20041031120721.GA19450@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> 
>>On Sat, 30 Oct 2004 17:26:06 -0400
>>Lee Revell <rlrevell@joe-job.com> wrote:
>>
>>
>>>OK this is pretty sweet.  With T3 the jitter never exceeds 7% on an idle
>>>system.  As soon as I start moving the mouse this goes to 7 or 8%.  I
>>>cannot get it to go higher than 10%.  Moving windows around has no
>>>effect, the highest jitter happens when I type or move the mouse really
>>>fast IOW it corresponds to the interrupt rate.
>>>
>>>This is a pretty good baseline for what an xrun-free system would look
>>>like.  Now to test the latest version...
>>
>>Well, 
>>
>>on V0.5.16 i see something like the below output (which is much worse). It
>>seems that missed irq's with rtc show up at the same time as the xruns in
>>jackd do [i ran both jackd and wakeup in parallel].
> 
> 
> ok, could you try the -RT-V0.6.0 patch i've just uploaded? It could i
> believe improve these latencies.
> 
> 	Ingo
> -

I am not able to get V0.6.2 to boot on my SMP system here. There is no 
indication as to why. It just locks. I don't see anything in the log 
that gives an indication as to why so I am only attaching the end of the 
log. If you would like all of it, just let me know. I am going to try 
building it for my SMP system now.

kr

Oct 31 09:28:05 porky vsftpd: vsftpd vsftpd succeeded
Oct 31 09:28:06 porky xinetd[2824]: xinetd Version 2.3.13 started with 
libwrap loadavg options compiled in.
Oct 31 09:28:06 porky xinetd[2824]: Started working: 2 available services
Oct 31 09:28:06 porky sendmail: sendmail startup succeeded
Oct 31 09:28:06 porky sendmail: sm-client startup succeeded
Oct 31 09:28:07 porky gpm[2897]: *** info [startup.c(95)]:
Oct 31 09:28:07 porky gpm[2897]: Started gpm successfully. Entered 
daemon mode.
Oct 31 09:28:07 porky gpm[2897]: *** info [mice.c(1766)]:
Oct 31 09:28:07 porky gpm[2897]: imps2: Auto-detected intellimouse PS/2
Oct 31 09:28:07 porky gpm: gpm startup succeeded
Oct 31 09:28:07 porky crond: crond startup succeeded
Oct 31 09:28:08 porky xfs: xfs startup succeeded
Oct 31 09:28:08 porky anacron: anacron startup succeeded
Oct 31 09:28:09 porky atd: atd startup succeeded
Oct 31 09:28:09 porky readahead: Starting background readahead:
Oct 31 09:28:09 porky rc: Starting readahead:  succeeded
Oct 31 09:28:10 porky messagebus: messagebus startup succeeded
