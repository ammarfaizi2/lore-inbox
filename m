Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbVAZIKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVAZIKQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 03:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbVAZIKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 03:10:16 -0500
Received: from mx1.elte.hu ([157.181.1.137]:11157 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262379AbVAZIKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 03:10:10 -0500
Date: Wed, 26 Jan 2005 09:09:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Bill Huey <bhuey@lnxw.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.36-04
Message-ID: <20050126080952.GC4771@elte.hu>
References: <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <20050104064013.GA19528@nietzsche.lynx.com> <20050104094518.GA13868@elte.hu> <20050107192651.GG5259@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107192651.GG5259@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Tom Rini <trini@kernel.crashing.org> wrote:

> Here's a handful of little things to fix issues in the patch for when
> you try and use the patchset on an architecture that doesn't (yet) work.
> 
> - cycles_t is defined in <asm/timex.h>, but that wasn't part of
>   <linux/irq.h> previously (breaks ppc32, I _think_).
> - debug_direct_keyboard & such only exist on GENERIC_HARDIRQ arches (and
>   I would guess make sense on ones you have a console & !USB keyboard
>   on).
> - The stubs for init_hardirqs / early_init_hardirqs were in a
>   conflicting state (as seen on ppc32, which is GENERIC_HARDIRQ, but not
>   yet supported).  I think this gets them down to what was intended.
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>

thanks - i have applied all of these and have released the
-2.6.11-rc2-V0.7.36-04 patch which can be downloaded from the usual
place:

  http://redhat.com/~mingo/realtime-preempt/

The -04 patch should also fix the down_write_interruptible() related
build error reported by Lee Revell and others.

	Ingo
