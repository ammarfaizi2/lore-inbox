Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132571AbRDHQ7K>; Sun, 8 Apr 2001 12:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132572AbRDHQ7A>; Sun, 8 Apr 2001 12:59:00 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:15378 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S132571AbRDHQ6s>;
	Sun, 8 Apr 2001 12:58:48 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200104081658.UAA15180@ms2.inr.ac.ru>
Subject: Re: softirq buggy [Re: Serial port latency]
To: manfred@colorfullife.COM (Manfred Spraul)
Date: Sun, 8 Apr 2001 20:58:31 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3ACF9473.343CD4A2@colorfullife.com> from "Manfred Spraul" at Apr 8, 1 12:45:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> +	if (softirq_active(smp_processor_id()) & softirq_mask(smp_processor_id())) {
> +		do_softirq();
> +		return 0;

BTW you may delete do_softirq()... schedule() will call this.


> + *
> + * Isn't this identical to default_idle with the 'no-hlt' boot
> + * option? <manfred@colorfullife.com>

Seeems, it is not. need_resched=-1 avoids useless IPIs.

Alexey
