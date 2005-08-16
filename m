Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbVHPRHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbVHPRHV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 13:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbVHPRHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 13:07:21 -0400
Received: from mx1.elte.hu ([157.181.1.137]:55487 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S1030250AbVHPRHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 13:07:18 -0400
Date: Tue, 16 Aug 2005 19:08:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: 2.6.13-rc6-rt6
Message-ID: <20050816170805.GA12959@elte.hu>
References: <20050816121843.GA24308@elte.hu> <1124206316.5764.14.camel@localhost.localdomain> <1124207046.5764.17.camel@localhost.localdomain> <1124208507.5764.20.camel@localhost.localdomain> <20050816163202.GA5288@elte.hu> <20050816163730.GA7879@elte.hu> <20050816165247.GA10386@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050816165247.GA10386@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> it's the raw_local_irq_save() in ___trace() that causes trouble.

ok, i've uploaded 2.6.13-rc6-rt6, which should fix this. (i've pushed 
the IRQ tracing into the raw_local_*() primitives, and kept the 
__raw_local_*() primitives clean, and ___trace() is using them now)

Does it boot for you now?

-rt6 also includes the USB fixes from Alan Stern, and an x64 fix from 
Dave Jiang. (albeit x64 likely doesnt work yet)

	Ingo
