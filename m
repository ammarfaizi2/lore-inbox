Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWBPIj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWBPIj1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 03:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWBPIj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 03:39:27 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:9170 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932278AbWBPIj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 03:39:27 -0500
Date: Thu, 16 Feb 2006 09:37:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: SMP BUG
Message-ID: <20060216083744.GA18962@elte.hu>
References: <43F12207.9010507@watson.ibm.com> <20060215230701.GD1508@flint.arm.linux.org.uk> <Pine.LNX.4.64.0602151521320.22082@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602151521320.22082@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> That said, nobody seemed to comment on this patch by Rik, which seemed 
> to be a nice cleanup regardless of any other issues.
> 
> Does this fix the ARM oops?

> Signed-off-by: Rik van Riel <riel@redhat.com>

yep - i agree that pushing runqueue initialization into init_idle() is a 
natural thing to do. [We used to do init_idle() much later in the past, 
but today we do it straight from sched_init() - so Rik's patch should be 
perfectly fine.]

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo
