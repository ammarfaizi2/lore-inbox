Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131260AbRCRSnh>; Sun, 18 Mar 2001 13:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131262AbRCRSn1>; Sun, 18 Mar 2001 13:43:27 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:18089 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131260AbRCRSnS>;
	Sun, 18 Mar 2001 13:43:18 -0500
Message-ID: <3AB50177.47489C00@mandrakesoft.com>
Date: Sun, 18 Mar 2001 13:41:59 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Guillaume Cottenceau <gc@mandrakesoft.com>
Subject: Q: "kapm-idled" and CPU usage
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The message quoted below is from a MandrakeSoft co-worker and friend, in
a thread discussing APM's kernel thread, and how the idle function uses
CPU time.  This thread was in response to yet another Bugzilla bug
report about kapm-idled using CPU time.

Several months ago, kapmd was renamed to kapm-idled in an attempt to
signal users that it was a special process, and that its CPU time wasn't
"real CPU time."  This hasn't silenced the bug reports and confusion.

Is there some way to hack the scheduler statistics so that idle
processes are special cases, which do not accumulate CPU time nor
contribute to the load average?

I agree that it's not pretty to special case idle function process(es),
but those idle functions in turn are causing an incorrect picture of the
system state to be presented to userland.

	Jeff


-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.


Guillaume Cottenceau wrote:
> On the other hand, you'll agree Jeff that it needs some fixing: it's
> fucking up many statistics such as load average and instant cpu usage, and
> is very confusing for people..
> 
> On another side, what I don't understand is that its cpu usage is not
> constant, which makes people things it's sort of a bug: for example my
> machine is up 1 day, 18:33 with 2.4.2-15mdk, kapm-ideld is reported to
> have consumed 1355m, but currently it's staying at 0.0% of cpu. Sometimes
> it gets bigger, sometimes it gets lower. Rather confusing.
