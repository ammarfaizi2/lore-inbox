Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266692AbUF3PRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266692AbUF3PRr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266693AbUF3PRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:17:47 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42883 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266692AbUF3PRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:17:46 -0400
Date: Wed, 30 Jun 2004 17:18:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK
Message-ID: <20040630151857.GA29070@elte.hu>
References: <200406301341.i5UDfkKX010518@localhost.localdomain> <20040630150430.GA28506@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630150430.GA28506@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> A simple "strace -f" should show whether the setscheduler() call
> succeeds or not. Does 'jackstart' do anything with glibc internals?

it seems part of the problem is that the setscheduler() calls 'succeed',
but the policy is not changed to SCHED_FIFO. The question here is, 
are the correct PIDs used?

	Ingo
