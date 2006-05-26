Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030515AbWEZHaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030515AbWEZHaR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030521AbWEZHaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:30:17 -0400
Received: from main.gmane.org ([80.91.229.2]:55252 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030515AbWEZHaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:30:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kari Hurtta <hurtta+gmane@siilo.fmi.fi>
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
Date: 26 May 2006 09:58:27 +0300
Message-ID: <5du07dclws.fsf@attruh.keh.iki.fi>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cs181108174.pp.htv.fi
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> writes in gmane.linux.kernel:

> This patch implements hard CPU rate caps per task as a proportion of a
> single CPU's capacity expressed in parts per thousand.

> + * Require: 1 <= new_cap <= 1000
> + */
> +int set_cpu_rate_hard_cap(struct task_struct *p, unsigned int new_cap)
> +{
> +	int is_allowed;
> +	unsigned long flags;
> +	struct runqueue *rq;
> +	int delta;
> +
> +	if (new_cap > 1000 && new_cap > 0)
> +		return -EINVAL;

That condition looks wrong.



