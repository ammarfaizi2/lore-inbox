Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbUKEMFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbUKEMFt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 07:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbUKEMFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 07:05:49 -0500
Received: from mx2.elte.hu ([157.181.151.9]:32233 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262657AbUKEMFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 07:05:46 -0500
Date: Fri, 5 Nov 2004 13:06:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: andyliu <liudeyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH]add an ifdef in sched.c
Message-ID: <20041105120615.GA5034@elte.hu>
References: <aad1205e04110504023d53ce65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aad1205e04110504023d53ce65@mail.gmail.com>
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


* andyliu <liudeyan@gmail.com> wrote:

> -#define for_each_domain(cpu, domain) \
> +#ifdef CONFIG_SMP
> +# define for_each_domain(cpu, domain) \
>         for (domain = cpu_rq(cpu)->sd; domain; domain = domain->parent)
> +#endif

why? A macro hanging around does not cause any bigger code - and the
#ifdef certainly makes the code less readable.

	Ingo
