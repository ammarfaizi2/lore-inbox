Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbTI2VM6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 17:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263051AbTI2VM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 17:12:57 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:44305 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263012AbTI2VMH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 17:12:07 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] Athlon Prefetch workaround for 2.6.0test6
Date: 29 Sep 2003 21:02:39 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bla6lf$3ul$1@gatekeeper.tmr.com>
References: <20030929125629.GA1746@averell>
X-Trace: gatekeeper.tmr.com 1064869359 4053 192.168.12.62 (29 Sep 2003 21:02:39 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030929125629.GA1746@averell>, Andi Kleen  <ak@muc.de> wrote:

| It removes the previous dumb in kernel workaround for this and shrinks the 
| kernel by >10k.
| 
| Small behaviour change is that a SIGBUS fault for a *_user access will
| cause an EFAULT now, no SIGBUS.
| 
| This version addresses all criticism that I got for previous versions.
| 
| - Only checks on AMD K7+ CPUs. 
| - Computes linear address for VM86 mode or code segments
| with non zero base.
| - Some cleanup
| - No pointer comparisons
| - More comments

I have to try this on a P4 and K7, but WRT "Only checks on AMD K7+ CPUs"
I hope you meant "only generates code if AMD CPU is target" and not that
the code size penalty is still there for CPUs which don't need it.

Will check Wednesday, life is very busy right now.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
