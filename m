Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268520AbUJJV5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268520AbUJJV5j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 17:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUJJV5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 17:57:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:46292 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268520AbUJJV5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 17:57:34 -0400
Date: Sun, 10 Oct 2004 23:59:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: dwalker@mvista.com, sdietrich@mvista.com, linux-kernel@vger.kernel.org,
       abatyrshin@ru.mvista.com, amakarov@ru.mvista.com, emints@ru.mvista.com,
       ext-rt-dev@mvista.com, hzhang@ch.mvista.com, yyang@ch.mvista.com
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041010215906.GA19497@elte.hu>
References: <41677E4D.1030403@mvista.com> <20041010084633.GA13391@elte.hu> <1097437314.17309.136.camel@dhcp153.mvista.com> <20041010142000.667ec673.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041010142000.667ec673.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> Lockmeter gets in the way of all this activity in a big way.  I'll
> drop it.

great. Daniel, would you mind to merge your patchkit against the
following base:

	-mm3, minus lockmeter, plus the -T3 patch

? To make this easier i've uploaded a combined undo-lockmeter patch to:

  http://redhat.com/~mingo/voluntary-preempt/undo-lockmeter-2.6.9-rc3-mm3-A1

which you should apply to vanilla -mm3, then apply the -T3 patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3

this will apply cleanly with some minor fuzz. The resulting kernel
builds & boots fine with my .config.

	Ingo
