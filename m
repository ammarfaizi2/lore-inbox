Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVGIRFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVGIRFY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 13:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVGIRFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 13:05:23 -0400
Received: from ns2.suse.de ([195.135.220.15]:24293 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261618AbVGIRFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 13:05:21 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] compress the stack layout of do_page_fault(), x86
References: <20050709144116.GA9444@elte.hu.suse.lists.linux.kernel>
	<20050709152924.GA13492@elte.hu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 09 Jul 2005 19:05:20 +0200
In-Reply-To: <20050709152924.GA13492@elte.hu.suse.lists.linux.kernel>
Message-ID: <p73ll4f29m7.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:
>  
> +static void force_sig_info_fault(int si_signo, int si_code,
> +				 unsigned long address, struct task_struct *tsk)

This won't work with a unit-at-a-time compiler which happily
inlines everything static with only a single caller. Use noinline

-Andi
