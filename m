Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVAXBF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVAXBF1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 20:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVAXBF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 20:05:27 -0500
Received: from mail.joq.us ([67.65.12.105]:56961 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261404AbVAXBFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 20:05:22 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
 scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
	<87pszvlvma.fsf@sulphur.joq.us> <41F42BD2.4000709@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Sun, 23 Jan 2005 19:06:46 -0600
In-Reply-To: <41F42BD2.4000709@kolivas.org> (Con Kolivas's message of "Mon,
 24 Jan 2005 09:57:22 +1100")
Message-ID: <877jm3ljo9.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> There are two things that the SCHED_ISO you tried is not that
> SCHED_FIFO is - As you mentioned there is no priority support, and it
> is RR, not FIFO. I am not sure whether it is one and or the other
> responsible. Both can be added to SCHED_ISO. I haven't looked at jackd
> code but it should be trivial to change SCHED_FIFO to SCHED_RR to see
> if RR with priority support is enough or not. 

Sure, that's easy.  I didn't do it because I assumed it would not
matter.  Since the RR scheduling quantum is considerably longer than
the basic 1.45msec audio cycle, it should work exactly the same.  I'll
cobble together a JACK version to try that for you.

> Second the patch I sent you is fine for testing; I was hoping you
> would try it. What you can't do with it is spawn lots of userspace
> apps safely SCHED_ISO with it - it will crash, but it not take down
> your hard disk. I've had significantly better results with that
> patch so far. Then we cn take it from there.

Sorry.  I took you literally when you said it was not yet ready to
try.  This would be the isoprio3 patch you posted?

Do I have to use 2.6.11-rc1-mm2, or will it work with 2.6.11-rc1?
-- 
  joq
