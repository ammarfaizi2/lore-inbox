Return-Path: <linux-kernel-owner+willy=40w.ods.org-S280117AbUKARRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S280117AbUKARRc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 12:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S280116AbUKARRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 12:17:31 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:64423
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S280027AbUKARQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 12:16:51 -0500
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       "K.R. Foley" <kr@cybsft.com>
In-Reply-To: <32917.192.168.1.5.1099328648.squirrel@192.168.1.5>
References: <20041031120721.GA19450@elte.hu>
	 <20041031124828.GA22008@elte.hu>
	 <1099227269.1459.45.camel@krustophenia.net>
	 <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu>
	 <20041031162059.1a3dd9eb@mango.fruits.de>
	 <20041031165913.2d0ad21e@mango.fruits.de>
	 <20041031200621.212ee044@mango.fruits.de> <20041101134235.GA18009@elte.hu>
	 <20041101135358.GA19718@elte.hu> <20041101140630.GA20448@elte.hu>
	 <32917.192.168.1.5.1099328648.squirrel@192.168.1.5>
Content-Type: text/plain
Organization: linutronix
Date: Mon, 01 Nov 2004 18:08:32 +0100
Message-Id: <1099328912.3337.40.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-01 at 17:04 +0000, Rui Nuno Capela wrote:
> Ingo Molnar wrote:
> >
> > I've uploaded -V0.6.5 to the usual place:
> >
> >   http://redhat.com/~mingo/realtime-preempt/
> >
> 
> Build error:
> 
> kernel/built-in.o(.text+0x308a): In function `show_state':
> : undefined reference to `show_all_locks'
> kernel/built-in.o(.text+0x30bc): In function `show_state':
> : undefined reference to `show_all_locks'
> make: *** [.tmp_vmlinux1] Error 1

You have lock debugging disabled.

tglx


--- linux/lib/rwsem-generic.o.c	2004-11-01 18:07:02.000000000 +0100
+++ linux/lib/rwsem-generic.c	2004-11-01 15:49:27.000000000 +0100
@@ -413,6 +413,9 @@
 {
 }
 
+void show_all_locks(void)
+{
+}
 #endif
 
 /*


