Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268342AbUHLCFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268342AbUHLCFc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 22:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268349AbUHLCFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 22:05:31 -0400
Received: from web13903.mail.yahoo.com ([216.136.175.29]:2331 "HELO
	web13903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268342AbUHLCFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 22:05:09 -0400
Message-ID: <20040812020459.8528.qmail@web13903.mail.yahoo.com>
Date: Wed, 11 Aug 2004 19:04:59 -0700 (PDT)
From: <spaminos-ker@yahoo.com>
Reply-To: spaminos-ker@yahoo.com
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and others)
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <cone.1092193795.772385.25569.502@pc.kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Con Kolivas <kernel@kolivas.org> wrote:
> Hi
> 
> I tried this on the latest staircase patch (7.I) and am not getting any 
> output from your script when tested up to 60 threads on my hardware. Can you 
> try this version of staircase please?
> 
> There are 7.I patches against 2.6.8-rc4 and 2.6.8-rc4-mm1
> 
> http://ck.kolivas.org/patches/2.6/2.6.8/
> 
> Cheers,
> Con
> 

Just tried on my machine:
2.6.8-rc4 fails all tests (did the test just to be sure)

2.6.8-rc4 with the "from_2.6.8-rc4_to_staircase7.I" patch and things look
pretty good:
on my hardware, I could put 60 threads too, and my shells are still very
responsive etc, and I get no slow downs with my watchdog script.

A few  strange things happened though (with 60 threads):
* after a few minutes, I got one message
Wed Aug 11 18:06:11 PDT 2004
>>>>>>> delta = 57
57 seconds !?! very surprising
* shortly after that, I tried to run top, or ps, and they all got stuck, I
waited a couple minutes and they were still stuck. I opened a few shells, I
could do anything but commands that enumerate the process list. After a while,
I killed the cputest program (ctrld c it), and the stucked ps/top continued
their execution.

I could not reproduce those problems ; I even rebooted the machine, but only
got one message delta of 3 every 30 minutes or so.

Nicolas

