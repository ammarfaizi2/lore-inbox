Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbUJZSuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbUJZSuV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 14:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbUJZSuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 14:50:21 -0400
Received: from mx1.elte.hu ([157.181.1.137]:48005 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261400AbUJZSuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 14:50:16 -0400
Date: Tue, 26 Oct 2004 20:50:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Michael Geithe <warpy@gmx.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: 2.6.10-rc1-bk4 and kernel/futex.c:542
Message-ID: <20041026185044.GA10894@elte.hu>
References: <200410261135.51035.warpy@gmx.de> <20041026133126.1b44fb38@mango.fruits.de> <20041026112415.GA21015@elte.hu> <200410261338.00341.warpy@gmx.de> <417E3D4C.2010909@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417E3D4C.2010909@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >Oct 26 11:02:19 h2so4 kernel: Badness in futex_wait at kernel/futex.c:542

> Hi,
> Can you try the following patch and see what it says?

i found the bug that most likely caused the PREEMPT_REALTIME one
reported by Florian - it was a spurious wakeup caused by that patch, so
upstream is not affected.

	Ingo
