Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWGGVvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWGGVvn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWGGVvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:51:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25497 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932324AbWGGVvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:51:42 -0400
Date: Fri, 7 Jul 2006 14:55:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/19] UML - timer initialization cleanup
Message-Id: <20060707145516.6df4afb3.akpm@osdl.org>
In-Reply-To: <200607070033.k670XaAg008677@ccure.user-mode-linux.org>
References: <200607070033.k670XaAg008677@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> wrote:
>
> +	err = request_irq(TIMER_IRQ, um_timer, SA_INTERRUPT, "timer", NULL);

SA_INTERRUPT is deprecated - I'll change this to IRQF_DISABLED.

We have a compatibility layer for now, but we need to start getting used to
using INTF_*.
