Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWI3Igp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWI3Igp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWI3Igp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:36:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62367 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751134AbWI3Igm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:36:42 -0400
Date: Sat, 30 Sep 2006 01:36:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 07/23] cleanup: uninline irq_enter() and move it into a
 function
Message-Id: <20060930013618.7ec19fe6.akpm@osdl.org>
In-Reply-To: <20060929234439.611901000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	<20060929234439.611901000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 23:58:26 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> --- linux-2.6.18-mm2.orig/kernel/softirq.c	2006-09-30 01:41:13.000000000 +0200
> +++ linux-2.6.18-mm2/kernel/softirq.c	2006-09-30 01:41:16.000000000 +0200
> @@ -279,6 +279,13 @@ EXPORT_SYMBOL(do_softirq);
>  # define invoke_softirq()	do_softirq()
>  #endif
>  
> +extern void irq_enter(void)

unneeded `extern'.
