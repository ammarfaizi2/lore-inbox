Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbUKDAgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUKDAgg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbUKDAde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:33:34 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:45367 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261953AbUKDA34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:29:56 -0500
Message-ID: <32813.192.168.1.8.1099527473.squirrel@192.168.1.8>
Date: Thu, 4 Nov 2004 00:17:53 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.7
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
References: <OFB0917CE0.7B8A1BDB-ON86256F41.006FCA71@raytheon.com>
In-Reply-To: <OFB0917CE0.7B8A1BDB-ON86256F41.006FCA71@raytheon.com>
X-OriginalArrivalTime: 04 Nov 2004 00:19:49.0801 (UTC) FILETIME=[FF5A3990:01C4C203]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes my latest stats, now regarding under 2.6.10-rc1 and running 
jackd -R -r44100 -p64 -n2 with 8 loaded fluidsynth instances, on a P4
2.533GHz UP 512MB laptop.

The main change from my previous posted results are that buffer/period
size has been decreased from 128 to 64 frames, being now a bit/much more
harnessing than before.

                              2.6.10-rc1 2.6.10-rc1-mm2 RT-V0.7.7
                              ---------- -------------- ---------
XRUN Rate . . . . . . . . . :   687.6        832.0         45.6   /hour
Delay Rate (>spare time)  . :  1354.8       1517.3         43.2   /hour
Delay Rate (>1000 usecs)  . :  1146.0       1245.3          3.6   /hour
Delay Maximum . . . . . . . :  4510         8786         1249     usecs
Cycle Maximum . . . . . . . :   957          976          946     usecs
Average DSP Load  . . . . . :    51.4         51.9         55.2   %
Average CPU System Load . . :     6.4          6.7         13.2   %
Average CPU User Load . . . :    40.3         40.4         41.9   %
Average CPU Nice Load . . . :     0.0          0.0          0.0   %
Average CPU I/O Wait Load . :     0.0          0.1          0.1   %
Average CPU IRQ Load  . . . :     0.0          0.0          0.0   %
Average CPU Soft-IRQ Load . :     0.0          0.0          0.0   %
Average Interrupt Rate  . . :  1673.7       1674.3       1675.4   /sec
Average Context-Switch Rate : 10967.4      10967.9      13940.9   /sec

As a first look, the -mm2 branch is performing quite badly, even though it
has been configured with the PREEMPT_BKL option set.

S/W versions are:

jackd 0.99.10
fluidsynth 1.0.5

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


