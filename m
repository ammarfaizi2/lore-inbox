Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268328AbUIWSVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268328AbUIWSVk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 14:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268331AbUIWSVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 14:21:39 -0400
Received: from scanner1.mail.elte.hu ([157.181.1.137]:52366 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268213AbUIWST1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 14:19:27 -0400
Date: Thu, 23 Sep 2004 20:20:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S4
Message-ID: <20040923182053.GA26284@elte.hu>
References: <20040907115722.GA10373@elte.hu> <20040923130949.GB12984@elte.hu> <200409231346.21398.norberto+linux-kernel@bensa.ath.cx> <200409231414.00356.norberto+linux-kernel@bensa.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409231414.00356.norberto+linux-kernel@bensa.ath.cx>
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


* Norberto Bensa <norberto+linux-kernel@bensa.ath.cx> wrote:

> Ingo, is this on purpose:
> 
> --- linux/kernel/printk.c.orig 
> +++ linux/kernel/printk.c 
> @@ -401,7 +401,7 @@ static void __call_console_drivers(unsig
>  static void _call_console_drivers(unsigned long start,
>      unsigned long end, int msg_log_level)
>  {
> - if (msg_log_level < console_loglevel &&
> + if (/*msg_log_level < console_loglevel && */
>     console_drivers && start != end) {

not intended, debugging leftover, you can remove it.

	Ingo
