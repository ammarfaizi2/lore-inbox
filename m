Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131345AbRCSCOr>; Sun, 18 Mar 2001 21:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131344AbRCSCOh>; Sun, 18 Mar 2001 21:14:37 -0500
Received: from csl.Stanford.EDU ([171.64.66.149]:53437 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S131336AbRCSCOX>;
	Sun, 18 Mar 2001 21:14:23 -0500
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200103190213.SAA23463@csl.Stanford.EDU>
Subject: Re: [CHECKER] blocking w/ spinlock or interrupt's disabled
To: manfred@colorfullife.com (Manfred Spraul)
Date: Sun, 18 Mar 2001 18:13:29 -0800 (PST)
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
In-Reply-To: <001801c0af8e$bda30c10$5517fea9@local> from "Manfred Spraul" at Mar 18, 2001 10:35:00 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it difficult to split it into "interrupts disabled" and "spin lock
> held"?

Nope, since it's already done ;-)  The suffix of each error message
should say whether it's because you have a spinlock, ints disabled, or
both:

2.4.1/drivers/atm/idt77105.c:153:fetch_stats: ERROR:BLOCK:151:153:
    calling blocking fn '__constant_copy_to_user' w/ int's disabled
2.4.1/drivers/atm/iphase.c:2426:ia_led_timer: ERROR:BLOCK:2423:2426:
    calling blocking fn 'ia_tx_poll' w/ spin lock held

Dawson
