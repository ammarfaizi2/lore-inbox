Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbULCOeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbULCOeg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 09:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbULCOec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 09:34:32 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:36104 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262203AbULCOeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 09:34:31 -0500
Message-ID: <41B07B1E.8050503@hist.no>
Date: Fri, 03 Dec 2004 15:41:34 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Andrew Morton <akpm@osdl.org>, andrea@suse.de,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
References: <20041201104820.1.patchmail@tglx>	 <20041201211638.GB4530@dualathlon.random>	 <1101938767.13353.62.camel@tglx.tec.linutronix.de>	 <20041202033619.GA32635@dualathlon.random>	 <1101985759.13353.102.camel@tglx.tec.linutronix.de>	 <1101995280.13353.124.camel@tglx.tec.linutronix.de>	 <20041202164725.GB32635@dualathlon.random>	 <20041202085518.58e0e8eb.akpm@osdl.org>	 <20041202180823.GD32635@dualathlon.random>	 <1102013716.13353.226.camel@tglx.tec.linutronix.de>	 <20041202110729.57deaf02.akpm@osdl.org>	 <1102014493.13353.239.camel@tglx.tec.linutronix.de>	 <20041202112208.34150647.akpm@osdl.org> <1102015450.13353.245.camel@tglx.tec.linutronix.de>
In-Reply-To: <1102015450.13353.245.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:

> I know, but the console and the reset button are 150km away. When I dial
>
>into the machine or try to connect via the network, I cannot connect
>with the current kernels. Neither 2.4, because the fork fails, nor 2.6
>because oom killed sshd. So I cannot send anything except a service man,
>who drives 150km to hit sysrq-F or the reset button.
>  
>

The case of OOM killed sshd is fixable without touching the kernel:
Make sure sshd is started from init, init will then restart sshd whenever
it quits for some reason.  This will get you your essential sshd back
assuming the machine is still running and the OOM killer managed
to free up some memory by killing some other processes.

One might still wish for better OOM behaviour, but it is a case
where something has to give.

Helge Hafting
