Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVFHLbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVFHLbK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 07:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbVFHLbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 07:31:10 -0400
Received: from mx2.elte.hu ([157.181.151.9]:60099 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262175AbVFHLat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 07:30:49 -0400
Date: Wed, 8 Jun 2005 13:28:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050608112801.GA31084@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the -V0.7.48-00 Real-Time Preemption patch, which can be 
downloaded from the usual place:

    http://redhat.com/~mingo/realtime-preempt/

this release includes an improved version of Daniel Walker's soft 
irq-flag (hardirq-disable removal) feature. It is an unconditional part
of the PREEMPT_RT preemption model - other preemption models should not
be affected that much (besides possible build issues). Non-x86 arches
wont build. Some regressions might happen, so take care..

Changes since -47-29:

 - soft IRQ flag support (Daniel Walker)

 - fix race in usbnet.c (Eugeny S. Mints)

 - further improvements to the soft IRQ flag code

to build a -V0.7.48-00 tree, the following patches should to be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc6.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc6-V0.7.48-00

	Ingo
