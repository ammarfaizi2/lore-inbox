Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbUJ0Kdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbUJ0Kdf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 06:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbUJ0KaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 06:30:05 -0400
Received: from pop.gmx.net ([213.165.64.20]:35971 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262389AbUJ0K2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 06:28:31 -0400
X-Authenticated: #4399952
Date: Wed, 27 Oct 2004 12:45:24 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041027124524.693161b8@mango.fruits.de>
In-Reply-To: <20041027123329.14570992@mango.fruits.de>
References: <20041022175633.GA1864@elte.hu>
	<20041025104023.GA1960@elte.hu>
	<417D4B5E.4010509@cybsft.com>
	<20041025203807.GB27865@elte.hu>
	<417E2CB7.4090608@cybsft.com>
	<20041027002455.GC31852@elte.hu>
	<417F16BB.3030300@cybsft.com>
	<20041027082831.GA15192@elte.hu>
	<20041027084401.GA15989@elte.hu>
	<20041027085221.GA16742@elte.hu>
	<20041027090620.GA17621@elte.hu>
	<20041027123329.14570992@mango.fruits.de>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004 12:33:29 +0200
Florian Schmidt <mista.tapas@gmx.net> wrote:

> V0.3.2 builds and boots fine here. It seems to run ok, too. Uptime 25
> minutes and no BUG's [yay! 25 minutes already! ;)]. Well anyways,
> preempt_max_thresh is at 38us after running several concurrent find's plus
> jackd.
> 
> There's a problem though with jackd performance. Read on below if it is of
> any interest at this point. 
[snip]

anyways, i still see the mysterious pauses which do not show up in the
preempt_max_thresh.

ah, and btw: what does the /proc/sys/kernel/kernel_preemption tunable do
with PREEMPT_REALTIME enabled?

mango:~# cat /proc/sys/kernel/kernel_preemption 
1

[all the other VP tunables are not available anymore]

mango:~# cat /proc/sys/kernel/voluntary_preemption
cat: /proc/sys/kernel/voluntary_preemption: No such file or directory
mango:~# cat /proc/sys/kernel/hardirq_preemption
cat: /proc/sys/kernel/hardirq_preemption: No such file or directory
mango:~# cat /proc/sys/kernel/softirq_preemption
cat: /proc/sys/kernel/softirq_preemption: No such file or directory

flo
