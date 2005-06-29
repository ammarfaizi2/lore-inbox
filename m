Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbVF2M5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbVF2M5e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 08:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVF2M5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 08:57:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26043 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262567AbVF2M5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 08:57:21 -0400
Date: Wed, 29 Jun 2005 14:56:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050629125657.GA29475@elte.hu>
References: <200506281927.43959.annabellesgarden@yahoo.de> <20050628202147.GA30862@elte.hu> <20050628203017.GA371@elte.hu> <200506290151.53675.annabellesgarden@yahoo.de> <20050629063439.GB12536@elte.hu> <20050629070058.GA15987@elte.hu> <Pine.LNX.4.58.0506290159050.12101@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506290159050.12101@echo.lysdexia.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Weston <weston@sysex.net> wrote:

> On Wed, 29 Jun 2005, Ingo Molnar wrote:
> 
> > > [...] but i think i'm going to revert that, it's causing too many 
> > > problems all around.
> > 
> > reverted it and this enabled the removal of the extra ->disable() you 
> > noticed - this should further speed up the IOAPIC code. These changes 
> > are in the -50-34 kernel i just uploaded.
> 
> -50-34 fixed the wakeup latency regression I was seeing on my Athlon 
> box with -50-33, and seems a bit more responsive than -50-25.  Max 
> wakeup latency is back down to 14us (from 39us), even while running 
> JACK (xrun free) and two instances of burnK7.  Overall system response 
> is probably the best I've seen with the RT kernels ;-}

great! The SMP box running BurnP6 is another system, right? Could you 
sum up the remaining regressions you are seeing under -RT? (the 
latency.c warning is one, what others are remaining?)

	Ingo
