Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbULHLNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbULHLNd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 06:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbULHLNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 06:13:33 -0500
Received: from mx1.elte.hu ([157.181.1.137]:61863 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261183AbULHLNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 06:13:32 -0500
Date: Wed, 8 Dec 2004 12:13:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Akinobu Mita <amgta@yacht.ocn.ne.jp>
Cc: phil.el@wanadoo.fr, John Levon <levon@movementarian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [mm patch] oprofile: backtrace operation does not initialized
Message-ID: <20041208111316.GA24484@elte.hu>
References: <200412081830.51607.amgta@yacht.ocn.ne.jp> <200412081834.38462.amgta@yacht.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412081834.38462.amgta@yacht.ocn.ne.jp>
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


* Akinobu Mita <amgta@yacht.ocn.ne.jp> wrote:

> -	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
> +	if (timer_hook) {
> +		struct pt_regs regs;
> +
> +		GET_CURRENT_REGS(regs);
> +		timer_hook(&regs);
> +	}

ugh. nack.

	Ingo
