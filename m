Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbVJSPAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbVJSPAB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 11:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbVJSPAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 11:00:01 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:36313 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751026AbVJSPAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 11:00:00 -0400
Date: Wed, 19 Oct 2005 10:59:45 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
Message-ID: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

I switched my custom kernel timer to use the ktimers with the prio of -1
as you mentioned to me offline.  I set up the timer to be monotonic and
have a requirement that the returned time is always greater or equal to
the last time returned from do_get_ktime_mono.

Now here's the results that I got between two calls of do_get_ktime_mono

358.069795728 secs then later 355.981483177.  Should this ever happen?

I haven't look to see if this happens in vanilla -rt10 but I haven't
touched your ktimer code except for my logging and the patch with the
unlock_ktimer_base (since I was based off of -rt9)

FYI, the system is UP. And I compiled without CONFIG_KTIME_SCALAR.

 Thanks

-- Steve

