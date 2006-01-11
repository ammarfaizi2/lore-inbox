Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWAKMtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWAKMtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWAKMtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:49:25 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:12419 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751450AbWAKMtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:49:24 -0500
Date: Wed, 11 Jan 2006 13:49:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rt3-sr1
Message-ID: <20060111124908.GA29559@elte.hu>
References: <1136982981.6197.85.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136982981.6197.85.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Ingo,
> 
> While trying to exploit the race in the hrtimer code in your kernel 
> (still unsuccessful), I found a bug that I introduced with the 
> wait_on_softirqd patch.  The wake_up is called within preempt_disable, 
> and thus might schedule and cause a bug output.  I've uploaded my 
> latest with the fix for this.

thanks, applied - and i've released -rt4 with this.

	Ingo
