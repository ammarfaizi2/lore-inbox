Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262809AbVAQOkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262809AbVAQOkn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 09:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbVAQOkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 09:40:43 -0500
Received: from mx1.elte.hu ([157.181.1.137]:58585 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262809AbVAQOki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 09:40:38 -0500
Date: Mon, 17 Jan 2005 15:40:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] __get_cpu_var should use __smp_processor_id() not smp_processor_id()
Message-ID: <20050117144016.GC10341@elte.hu>
References: <20050117055044.GA3514@taniwha.stupidest.org> <20050117073809.GA3654@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117073809.GA3654@taniwha.stupidest.org>
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


* Chris Wedgwood <cw@f00f.org> wrote:

> It seems logical that __get_cpu_var should use __smp_processor_id()
> rather than smp_processor_id().  Noticed when __get_cpu_var was making
> lots of noise with CONFIG_DEBUG_PREEMPT=y

no ... normally you should only use __get_cpu_var() if you know that you
are in a non-preempt case. It's a __ internal function for a reason. 
Where did it trigger?

	Ingo
