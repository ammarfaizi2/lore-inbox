Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbULCVUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbULCVUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 16:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbULCVUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 16:20:30 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:39552
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262298AbULCVUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 16:20:25 -0500
Subject: Re: [PATCH] oom killer (Core)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Helge Hafting <helge.hafting@hist.no>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>,
       nickpiggin@yahoo.com.au
In-Reply-To: <41B07B1E.8050503@hist.no>
References: <20041201104820.1.patchmail@tglx>
	 <20041201211638.GB4530@dualathlon.random>
	 <1101938767.13353.62.camel@tglx.tec.linutronix.de>
	 <20041202033619.GA32635@dualathlon.random>
	 <1101985759.13353.102.camel@tglx.tec.linutronix.de>
	 <1101995280.13353.124.camel@tglx.tec.linutronix.de>
	 <20041202164725.GB32635@dualathlon.random>
	 <20041202085518.58e0e8eb.akpm@osdl.org>
	 <20041202180823.GD32635@dualathlon.random>
	 <1102013716.13353.226.camel@tglx.tec.linutronix.de>
	 <20041202110729.57deaf02.akpm@osdl.org>
	 <1102014493.13353.239.camel@tglx.tec.linutronix.de>
	 <20041202112208.34150647.akpm@osdl.org>
	 <1102015450.13353.245.camel@tglx.tec.linutronix.de>
	 <41B07B1E.8050503@hist.no>
Content-Type: text/plain
Date: Fri, 03 Dec 2004 22:20:22 +0100
Message-Id: <1102108823.13353.267.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-03 at 15:41 +0100, Helge Hafting wrote:
> The case of OOM killed sshd is fixable without touching the kernel:
> Make sure sshd is started from init, init will then restart sshd whenever
> it quits for some reason.  This will get you your essential sshd back
> assuming the machine is still running and the OOM killer managed
> to free up some memory by killing some other processes.
> 
> One might still wish for better OOM behaviour, but it is a case
> where something has to give.
> 

Hey, are you kidding ?

2.4 lets me not in, because the fork of sshd fails. How do you fix this
with changing the userspace ?

2.6 oom is plain buggy

I have no problem to help myself, but I want to get this fixed in a
reliable way which meets the comment in oom_kill.c: "least surprise"

tglx


