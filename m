Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263347AbUJ2On1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263347AbUJ2On1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263346AbUJ2Old
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:41:33 -0400
Received: from imap.gmx.net ([213.165.64.20]:18888 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263359AbUJ2OgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:36:25 -0400
X-Authenticated: #4399952
Date: Fri, 29 Oct 2004 16:53:34 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: "Rui Nuno Capela" <rncbc@rncbc.org>, "Ingo Molnar" <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
Message-ID: <20041029165334.09055fdb@mango.fruits.de>
In-Reply-To: <20041029163135.1886d67f@mango.fruits.de>
References: <5225.195.245.190.94.1098880980.squirrel@195.245.190.94>
	<20041027135309.GA8090@elte.hu>
	<12917.195.245.190.94.1098890763.squirrel@195.245.190.94>
	<20041027205126.GA25091@elte.hu>
	<20041027211957.GA28571@elte.hu>
	<33083.192.168.1.5.1098919913.squirrel@192.168.1.5>
	<20041028063630.GD9781@elte.hu>
	<20668.195.245.190.93.1098952275.squirrel@195.245.190.93>
	<20041028085656.GA21535@elte.hu>
	<26253.195.245.190.93.1098955051.squirrel@195.245.190.93>
	<20041028093215.GA27694@elte.hu>
	<43163.195.245.190.94.1098981230.squirrel@195.245.190.94>
	<20041029163135.1886d67f@mango.fruits.de>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004 16:31:35 +0200
Florian Schmidt <mista.tapas@gmx.net> wrote:

> i tried a V0.5.2 with PREEMPT_REALTIME and all debugging off (config
> attached). I cannot reproduce your results. I have experienced around 30
> xruns in 10 minutes. And big ones, too (> 5ms). I don't know exactly what
> kind of load triggers them. Here's a bit of qjackctl message window (btw:
> jackd was idle, no clients connected, except for qjackctl):
> 
[snip]

i forgot to mention though that i do use jack in full duplex mode and with a
periodsize of 64:

/usr/bin/jackd -R -P60 -t20000 -dalsa -dhw:0 -r48000 -p64 -n2

The results are thus not really comparable. Anyways, 7ms xruns still
shouldn't happen (with the older VP patches i could run 32 frames full
duplex for hours w/o xruns).

flo
