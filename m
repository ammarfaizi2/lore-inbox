Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbULBVOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbULBVOr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 16:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbULBVMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 16:12:42 -0500
Received: from mail.gmx.de ([213.165.64.20]:38312 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261778AbULBVKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 16:10:35 -0500
X-Authenticated: #4399952
Date: Thu, 2 Dec 2004 22:12:51 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
Message-ID: <20041202221251.5b1c4255@mango.fruits.de>
In-Reply-To: <20041202184421.229cf5d5@mango.fruits.de>
References: <20041201213023.GA23470@elte.hu>
	<32788.192.168.1.8.1101938057.squirrel@192.168.1.8>
	<20041201220916.GA24992@elte.hu>
	<20041201234355.0dac74cf@mango.fruits.de>
	<20041202084040.GC7585@elte.hu>
	<20041202132218.02ea2c48@mango.fruits.de>
	<20041202122931.GA25357@elte.hu>
	<20041202140612.4c07bca8@mango.fruits.de>
	<20041202131002.GA30503@elte.hu>
	<20041202144037.5c9da188@mango.fruits.de>
	<20041202134934.GA32216@elte.hu>
	<20041202184421.229cf5d5@mango.fruits.de>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2004 18:44:21 +0100
Florian Schmidt <mista.tapas@gmx.net> wrote:

> this simple patch adds the gettimeofday calls around the calling of the
> process callback:
> 

[snip]

> 
> The results i see are rather interesting though. Even with a noop jack
> client (which does nothing but return 0 in the process callback) i get a
> syslog report everytime i start the client. Client source attached.
> 

[snip]

> 
> The atomicity check operates on a per task (thread) basis right?
> 
> Flo
> 

Well, my error. gettimeofday(1,0) != gettimeofday(0,1) :)

flo

-- 
Palimm Palimm!
Sounds/Ware:
http://affenbande.org/~tapas/
