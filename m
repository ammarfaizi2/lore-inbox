Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbULATBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbULATBN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 14:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbULATBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 14:01:13 -0500
Received: from smtp3.netcabo.pt ([212.113.174.30]:19854 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261412AbULATBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 14:01:05 -0500
Message-ID: <33059.192.168.1.5.1101927565.squirrel@192.168.1.5>
In-Reply-To: <20041201162034.GA8098@elte.hu>
References: <41358.195.245.190.93.1101734020.squirrel@195.245.190.93>
    <20041129143316.GA3746@elte.hu> <20041129152344.GA9938@elte.hu>
    <48590.195.245.190.94.1101810584.squirrel@195.245.190.94>
    <20041130131956.GA23451@elte.hu>
    <17532.195.245.190.94.1101829198.squirrel@195.245.190.94>
    <20041201103251.GA18838@elte.hu>
    <32831.192.168.1.5.1101905229.squirrel@192.168.1.5>
    <20041201154046.GA15244@elte.hu> <20041201160632.GA3018@elte.hu>
    <20041201162034.GA8098@elte.hu>
Date: Wed, 1 Dec 2004 18:59:25 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       "Esben Nielsen" <simlo@phys.au.dk>, "Andrew Morton" <akpm@osdl.org>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 01 Dec 2004 19:01:03.0203 (UTC) FILETIME=[1A93FB30:01C4D7D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
>> ok, this could be ACPI CPU-sleep related. Could you disable all ACPI
>> options in your .config (as a workaround), and re-check whether the
>> xruns still occur?
>
> i think i found the bug - it's an upstream ACPI bug. Does the patch
> below (or the -31-19 kernel, which i've just uploaded) fix the xruns?
>

So far so good.

I have now an armed RT-V0.31-19 on my laptop, running for about 30 minutes
already, running the usual 'jackd -R -dalsa -dhw:0 -r44100 -p64 -n2 -S -P'
from qjackctl, several qsynth (fluidsynth) engines are up and running,
normal desktop janitor work (KDE) and yes, ACPI is on. Oh, wi-fi is also
pumping nice :)

Guess what? No XRUNs, not even one to show you a single latency trace.

I'll keep you posted, if anything goes less right than it is :).
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

