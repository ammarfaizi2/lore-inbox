Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269318AbRIVNCC>; Sat, 22 Sep 2001 09:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269641AbRIVNBn>; Sat, 22 Sep 2001 09:01:43 -0400
Received: from mailc.telia.com ([194.22.190.4]:3814 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S267196AbRIVNBl>;
	Sat, 22 Sep 2001 09:01:41 -0400
Message-Id: <200109221301.f8MD1n129687@mailc.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Robert Love <rml@tech9.net>, Andre Pang <ozone@algorithm.com.au>,
        Andrea Arcangeli <andrea@suse.de>
Subject: ksoftirqd? (Was: Re: [PATCH] Preemption Latency Measurement Tool)
Date: Sat, 22 Sep 2001 14:56:58 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, safemode@speakeasy.net,
        Dieter.Nuetzel@hamburg.de, iafilius@xs4all.nl, ilsensine@inwind.it,
        george@mvista.com
In-Reply-To: <1000939458.3853.17.camel@phantasy> <1001131036.557760.4340.nullmailer@bozar.algorithm.com.au> <1001139027.1245.28.camel@phantasy>
In-Reply-To: <1001139027.1245.28.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have a new kid on the block since we started thinking of a preemptive 
kernel.

ksoftirqd...

Running with nice 19 (shouldn't it really be -19?)
Or have a RT setting? (maybe not since one of the reasons for
softirqd would be lost - would be scheduled in immediately)
Can't a high prio or RT process be starved due to missing
service (bh) after an interrupt?

This will not show up in latency profiling patches since
the kernel does what is requested...

Previously it was run directly after interrupt,
before returning to the interrupted process...

See:
  /usr/src/develop/linux/kernel/softirq.c

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
