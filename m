Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVF2JQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVF2JQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 05:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVF2JQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 05:16:29 -0400
Received: from unused.mind.net ([69.9.134.98]:11910 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262237AbVF2JQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 05:16:26 -0400
Date: Wed, 29 Jun 2005 02:15:02 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: Karsten Wiese <annabellesgarden@yahoo.de>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
In-Reply-To: <20050629070058.GA15987@elte.hu>
Message-ID: <Pine.LNX.4.58.0506290159050.12101@echo.lysdexia.org>
References: <200506281927.43959.annabellesgarden@yahoo.de> <20050628202147.GA30862@elte.hu>
 <20050628203017.GA371@elte.hu> <200506290151.53675.annabellesgarden@yahoo.de>
 <20050629063439.GB12536@elte.hu> <20050629070058.GA15987@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005, Ingo Molnar wrote:

> > [...] but i think i'm going to revert that, it's causing too many 
> > problems all around.
> 
> reverted it and this enabled the removal of the extra ->disable() you 
> noticed - this should further speed up the IOAPIC code. These changes 
> are in the -50-34 kernel i just uploaded.

-50-34 fixed the wakeup latency regression I was seeing on my Athlon box
with -50-33, and seems a bit more responsive than -50-25.  Max wakeup
latency is back down to 14us (from 39us), even while running JACK (xrun
free) and two instances of burnK7.  Overall system response is probably
the best I've seen with the RT kernels ;-}

--ww
