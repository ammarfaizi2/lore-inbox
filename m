Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbUKCAom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbUKCAom (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUKCAol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 19:44:41 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:13336 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261164AbUKCAmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 19:42:22 -0500
Message-ID: <32796.192.168.1.5.1099442372.squirrel@192.168.1.5>
Date: Wed, 3 Nov 2004 00:39:32 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.9
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Rui Nuno Capela" <rncbc@rncbc.org>
Cc: "Ingo Molnar" <mingo@elte.hu>, mark_h_johnson@raytheon.com,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Paul Davis" <paul@linuxaudiosystems.com>,
       "LKML" <linux-kernel@vger.kernel.org>, "Bill Huey" <bhuey@lnxw.com>,
       "Adam Heath" <doogie@debian.org>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "K.R. Foley" <kr@cybsft.com>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
References: <OFB38B3DE8.983DDEAD-ON86256F40.0062F170-86256F40.0062F1A5@raytheon.com>
             <20041102191858.GB1216@elte.hu>
    <20041102192709.GA1674@elte.hu>   
    <32932.192.168.1.8.1099437703.squirrel@192.168.1.8>
In-Reply-To: <32932.192.168.1.8.1099437703.squirrel@192.168.1.8>
X-OriginalArrivalTime: 03 Nov 2004 00:42:15.0410 (UTC) FILETIME=[F6FC1D20:01C4C13D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Nuno Capela wrote:
>
> I am also rehearsing these same tests on my P4/SMT desktop.
> I'll post those a bit later today.
>

So here they are. This machine is a P4 2.80C@3.366GHz, HT enabled on a
Asus P4P800 mobo, Intel 82801EB onboard sound device (snd-intel8x0).

                                   2.6.9smp   RT-V0.6.9smp
                                 ------------ ------------
 XRUN Rate   . . . . . . . . . :       0            0      /hour
 Delay Rate (>spare time)  . . :       0            0      /hour
 Delay Rate (>1000 usecs)  . . :       0            0      /hour
 Delay Maximum . . . . . . . . :     346          166      usecs
 Cycle Maximum . . . . . . . . :     986         1028      usecs
 Average DSP Load. . . . . . . :      25.0         25.7    %
 Average Interrupt Rate  . . . :    1717         1718      /sec
 Average Context-Switch Rate . :   10082        15793      /sec

As you can see, the results here aren't so disparate as on my UP laptop.

I guess that I can stress this out and lower the period size on jackd -R,
to -p64. And even increase the workload with more client instances (from 9
to 18 ?) to let the RT show it's potential, if that makes sense at all.

Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org




