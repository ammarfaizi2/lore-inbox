Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263239AbUJ2LeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbUJ2LeS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 07:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbUJ2LeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 07:34:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:31631 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263239AbUJ2LdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 07:33:00 -0400
Date: Fri, 29 Oct 2004 13:34:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SysRq-n changes RT tasks to normal
Message-ID: <20041029113405.GA32204@elte.hu>
References: <yw1xy8hpix4z.fsf@inprovide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xy8hpix4z.fsf@inprovide.com>
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


* Måns Rullgård <mru@inprovide.com> wrote:

> +	for_each_process (p) {
> +		if (!rt_task(p))
> +			continue;
> +
> +		read_lock_irq(&tasklist_lock);
> +		rq = task_rq_lock(p, &flags);

you must take the tasklist_lock outside the for_each_process().

otherwise, looks good.

	Ingo
