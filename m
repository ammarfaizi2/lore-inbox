Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbUJ0UlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbUJ0UlK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbUJ0UkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:40:04 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:28685 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262719AbUJ0UcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:32:14 -0400
Message-ID: <32913.192.168.1.5.1098908937.squirrel@192.168.1.5>
In-Reply-To: <20041027185716.66965.qmail@web12202.mail.yahoo.com>
References: <32865.192.168.1.5.1098898770.squirrel@192.168.1.5>
    <20041027185716.66965.qmail@web12202.mail.yahoo.com>
Date: Wed, 27 Oct 2004 21:28:57 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "karsten wiese" <annabellesgarden@yahoo.de>
Cc: "Lee Revell" <rlrevell@joe-job.com>, "Ingo Molnar" <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, "Bill Huey" <bhuey@lnxw.com>,
       "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 27 Oct 2004 20:32:06.0873 (UTC) FILETIME=[06B89C90:01C4BC64]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

karsten wiese wrote:
> Rui Nuno Capela wrote:
>> Should I try the other way around? Lets see... 'chrt -p
>> -f 90 `pidof ksoftirwd/0`',... yes, apparentely the xrun
>> rate seems to decrease into half, but IMHO not conclusive
>> enough, thought.
>>
> 'into half' makes me wonder:
> did you also 'chrt -p -f 90 `pidof ksoftirwd/1`'?
> I guess you meant that with '...'. Just in case :-)
>

Wonder no more. All my statistical-wise tests were carried on a UP box (my
laptop), so there's no "ksoftirqd/1" in there, just a single
"ksoftirqd/0".

Speaking of which, I was not taking tests very seriously on my other
SMP/HT box, just because I don't want to rant about it anymore :) Only
recently VP and RT kernels were barely able to boot there, where even
plain vanilla 2.6.9 seems to be snappier and with far fewer xruns than
V0.4.1 or even U3 (either RT or not).

OTOH, on my laptop (P4/UP) I can testify as truth that, at least for
RT-U3, the improvement is real: I don't have a record of such a top
performer, when regarding the zero-xrun, low-latency audio setup
potential. When even compared, it just outperforms by far that old
2.4+preempt+low-latency myth ;)

Unfortunately, this is not what I see on my P4/SMP/HT desktop box. I
cannot tell a lie ;)

Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

P.S. Karsten, my US-224 is working real nice on my laptop now (provided
I'm with RT-U3 :) I'm real thankful for all of your work on snd-usb-usx2y.
Cheers.


