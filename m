Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbUKJKBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbUKJKBc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 05:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUKJKBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 05:01:31 -0500
Received: from mx2.elte.hu ([157.181.151.9]:5822 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261659AbUKJKBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 05:01:12 -0500
Date: Wed, 10 Nov 2004 12:03:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Hood <jdthood@yahoo.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/preempt-locking.txt clarification
Message-ID: <20041110110313.GA5493@elte.hu>
References: <1073302283.1903.85.camel@thanatos.hubertnet> <1074561880.26456.26.camel@localhost> <1100074907.3654.780.camel@thanatos> <20041110005742.35828d2b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041110005742.35828d2b.akpm@osdl.org>
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

> But I don't see why that's needed: if the preempt command came from
> another CPU then this CPU will take the cross-CPU interrupt as soon as
> interrupts are enabled.  And the preempt command couldn't have come
> from _this_ CPU, because it had interrupts disabled.

this CPU can easily trigger a reschedule by _waking_ another task
synchronously (from within the irqs-off section) and hence causing
itself to preempt. I'd not say it's common, but it can happen in quite
unexpected places, so i'd encourage us to keep the more cautious advice
that is in the current text.

	Ingo
