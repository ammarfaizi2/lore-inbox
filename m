Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbUKLTVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbUKLTVA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 14:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbUKLTTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 14:19:01 -0500
Received: from mx2.elte.hu ([157.181.151.9]:12465 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261903AbUKLTSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 14:18:38 -0500
Date: Fri, 12 Nov 2004 21:19:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Gunther Persoons <gunther_persoons@spymac.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
Message-ID: <20041112201936.GA15133@elte.hu>
References: <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <41951380.2080801@spymac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41951380.2080801@spymac.com>
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


* Gunther Persoons <gunther_persoons@spymac.com> wrote:

> I cant use my pcmcia wireless network card with this version, i can
> use it with V0.7.25-0. dhcpcd and ifconfig lock when i try to use
> them.  config attached.

extremely weird - there simply was no change between -0 and -1 that
could have affected it. If you do this on the -1 kernel:

	echo 0 > /proc/sys/kernel/preempt_wakeup_timing
	echo 1 > /proc/sys/kernel/debug_direct_keyboard

then you'll get precisely the -0 kernel, bit for bit. (plus the symbol
export fix in rtc.ko, which should have zero relevance to your setup.)

[note that debug_direct_keyboard is dangerous.]

so i believe the explanation has to be something else:

 - are you sure the build is correct?

 - are you sure it still works with the -0 kernel, maybe the bug is 
   transient?

	Ingo
