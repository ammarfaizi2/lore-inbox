Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbUGMACv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUGMACv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 20:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUGMACl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 20:02:41 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:7888 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S264382AbUGMABy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 20:01:54 -0400
Message-Id: <200407130001.i6D01pkJ003489@localhost.localdomain>
To: Andrew Morton <akpm@osdl.org>
cc: Lee Revell <rlrevell@joe-job.com>, linux-audio-dev@music.columbia.edu,
       mingo@elte.hu, arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch 
In-reply-to: Your message of "Mon, 12 Jul 2004 16:31:41 PDT."
             <20040712163141.31ef1ad6.akpm@osdl.org> 
Date: Mon, 12 Jul 2004 20:01:51 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [141.151.61.237] at Mon, 12 Jul 2004 19:01:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>OK, thanks.  The problem areas there are the timer-based route cache
>flushing and reiserfs.
>
>We can probably fix the route caceh thing by rescheduling the timer after
>having handled 1000 routes or whatever, although I do wonder if this is a
>thing we really need to bother about - what else was that machine up to?

i have one concern about this that i talked to takashi about when we
were in bordeaux. it seems to me that the ALSA xrun debug stuff is
measuring things when the interrupt handler for the ALSA device
executes and detects an xrun. if the handler itself was delayed, then
the stack trace for its execution doesn't or might not show what
caused the delay. this means, perhaps, that we need to be rather
careful interpreting these traces.

--p
