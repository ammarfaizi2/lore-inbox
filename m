Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932771AbWF1HoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932771AbWF1HoH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 03:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932768AbWF1HoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 03:44:07 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:14562 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932764AbWF1HoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 03:44:05 -0400
Date: Wed, 28 Jun 2006 09:39:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Zou Nan hai <nanhai.zou@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] jbd commit code deadloop when installing Linux
Message-ID: <20060628073917.GA11526@elte.hu>
References: <1151470123.6052.17.camel@linux-znh> <20060627234005.dda13686.akpm@osdl.org> <20060628063859.GA9726@elte.hu> <20060627235500.8c2c290e.akpm@osdl.org> <1151473582.6052.28.camel@linux-znh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151473582.6052.28.camel@linux-znh>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5113]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Zou Nan hai <nanhai.zou@intel.com> wrote:

> @@ -4094,8 +4093,7 @@ int cond_resched_lock(spinlock_t *lock)

> -		__cond_resched();
> -		ret = 1;
> +		ret |= __cond_resched();

> @@ -4106,14 +4104,13 @@ EXPORT_SYMBOL(cond_resched_lock);

> -		__cond_resched();
> +		ret = __cond_resched();

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
