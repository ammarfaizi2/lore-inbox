Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbUJaWCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbUJaWCO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 17:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbUJaWCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 17:02:14 -0500
Received: from smtp3.netcabo.pt ([212.113.174.30]:2111 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261663AbUJaWBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 17:01:37 -0500
Message-ID: <32954.192.168.1.5.1099259923.squirrel@192.168.1.5>
In-Reply-To: <20041031120721.GA19450@elte.hu>
References: <20041030115808.GA29692@elte.hu>
    <1099158570.1972.5.camel@krustophenia.net>
    <20041030191725.GA29747@elte.hu>
    <20041030214738.1918ea1d@mango.fruits.de>
    <1099165925.1972.22.camel@krustophenia.net>
    <20041030221548.5e82fad5@mango.fruits.de>
    <1099167996.1434.4.camel@krustophenia.net>
    <20041030231358.6f1eeeac@mango.fruits.de>
    <1099171567.1424.9.camel@krustophenia.net>
    <20041030233849.498fbb0f@mango.fruits.de>
    <20041031120721.GA19450@elte.hu>
Date: Sun, 31 Oct 2004 21:58:43 -0000 (WET)
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Florian Schmidt" <mista.tapas@gmx.net>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Paul Davis" <paul@linuxaudiosystems.com>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "LKML" <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "jackit-devel" <jackit-devel@lists.sourceforge.net>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 31 Oct 2004 22:01:30.0122 (UTC) FILETIME=[2D1E76A0:01C4BF95]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> ok, could you try the -RT-V0.6.0 patch i've just uploaded? It could i
> believe improve these latencies.
>

Just made a try with RT-V0.6.2 and it locks pretty easily on my P4/UP
laptop while running my jackd-R + 9*fluidsynth workload. These tests are
setup to run for 5 min. Not once it got through, and I've tried several
times now.

Although it's been 100% reproducible, the system lockup varies in tine
from the start of the test. Unfortunately it says nothing through
netconsole, so there's no additional info/dump/trace to give you for
analysis.

Most of the kernel hacking/debugging options are unset (N), except
Magic-SysRq. Hitting on SysRq+T, right after when system hangs, comes out
with absolutely nothing, only this line (via netconsole):

SysRq : Show State

Guess something's got wrong, yet again.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


