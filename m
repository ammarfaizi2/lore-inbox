Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272959AbRIHFsY>; Sat, 8 Sep 2001 01:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272960AbRIHFsG>; Sat, 8 Sep 2001 01:48:06 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:36612 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272959AbRIHFrp>; Sat, 8 Sep 2001 01:47:45 -0400
Subject: Re: Feedback on preemptible kernel patch
From: Robert Love <rml@tech9.net>
To: grue@lakesweb.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010908052256.A3DE9597C5@g-box.vf.shawcable.net>
In-Reply-To: <20010908052256.A3DE9597C5@g-box.vf.shawcable.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.05.07.08 (Preview Release)
Date: 08 Sep 2001 01:47:43 -0400
Message-Id: <999928066.903.18.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-09-08 at 01:22, grue@lakesweb.com wrote:
> I am running 2.4.10-pre4 with the rml-preempt patch.
> built and rebooted this on my workstation yesterday when I saw the patch
> posted and it's been working great.

_Very_ glad to hear this.

> I'm running it on a dual P3-550 with 256MB ram with CONFIG_SMP and no
> problems whatsoever although it hasn't been worked 'real' hard yet.
> (load no higher than 4) ;)

I am surprised you have no problems with CONFIG_SMP=y &&
CONFIG_PREEMPT=y.  Promising.

> Figured I'd give some positive feedback about the patch. If you want,
> Rob, I could run some benchmarks on this against an unpatched kernel, or
> if you have some ideas for me to really stress this thing to see if it
> breaks, let me know.

I would love this.  We could use some SMP datapoints badly.

You can run some of the tests made especially for testing latency, like
an audio benchmark.  One such test is at
http://www.gardena.net/benno/linux/latencytest-0.42.tar.gz

Obviously a heavily tasked I/O benchmark is useful, I have used dbench
in the past (ftp://samba.org/pub/tridge/dbench/) (try it with 16
processes or so), but I have been told I should use bonnie.

You can time normal things, too. `time make dep clean bzImage' is always
a favorite :)

Under UP, enabling preemption helps all of this (the recent linuxdevices
article on preemption shows a 30x decrease in latency.).  Both myself
and Nigel have run dbench with good results for -16.  See
http://kpreempt.sourceforge.net/ for some more.

whatever you can... anyhow, thank you for the positive feedback.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

