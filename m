Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVFEITY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVFEITY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 04:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVFEITY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 04:19:24 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36057 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261520AbVFEITV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 04:19:21 -0400
Date: Sun, 5 Jun 2005 10:18:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Daniel Walker <dwalker@mvista.com>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: patch] Real-Time Preemption, plist fixes
Message-ID: <20050605081835.GA20981@elte.hu>
References: <1117930633.20785.239.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117930633.20785.239.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> 5. [...]

#6 looks pretty significant too:

>  unsigned plist_chprio(struct plist *plist, struct plist *pl, int new_prio)
>  {
> -	if (new_prio == plist->prio)
> +	if (new_prio == pl->prio)
>  		return 0;

right?

	Ingo
