Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbVJQQFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbVJQQFa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVJQQFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:05:30 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:10626 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932315AbVJQQF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:05:29 -0400
Date: Mon, 17 Oct 2005 18:05:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>
Subject: 2.6.14-rc4-rt7
Message-ID: <20051017160536.GA2107@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the 2.6.14-rc4-rt7 tree, which can be downloaded from 
the usual place:

  http://redhat.com/~mingo/realtime-preempt/

the biggest change is the merging of "ktimers next step", a'ka the 
clockevents framework, from Thomas Gleixner. This is mostly a design 
cleanup of the existing timekeeping, timer and HRT codebase. One 
user-visible aspect is that the PIT timer is now available as a hres 
source too - APIC-less systems will find this useful.

otherwise, there are lots of fixes all across the spectrum.

Changes since 2.6.14-rc4-rt1:

- clockevents framework (Thomas Gleixner)

- ktimer and HRT updates (Thomas Gleixner)

- robust futex updates (David Singleton)

- symbol export fixes (Steven Rostedt)

- export tsc_c3_compensate for real (reported by Rui Nuno Capela)

- fix for the nanosleep() -ERESTARTBLOCK bug
  (reported by Fernando Lopez-Lezcano)

- x64 latency tracer fixes (reported by Mark Knecht)

- PRINTK_IGNORE_LOGLEVEL bugfix

- various build fixes

to build a 2.6.14-rc4-rt7 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.13.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.14-rc4.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.14-rc4-rt7

	Ingo
