Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbWJBU7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbWJBU7R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbWJBU7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:59:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965112AbWJBU7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:59:15 -0400
Date: Mon, 2 Oct 2006 13:58:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Brownell <david-b@pacbell.net>
Cc: David Howells <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>, Greg KH <greg@kroah.com>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than
 passing to IRQ handlers
Message-Id: <20061002135842.35e31418.akpm@osdl.org>
In-Reply-To: <200610021346.13135.david-b@pacbell.net>
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
	<20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
	<20061002132116.2663d7a3.akpm@osdl.org>
	<200610021346.13135.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2006 13:46:11 -0700
David Brownell <david-b@pacbell.net> wrote:

> The only downside I can think of for dropping pt_regs is that now it's harder
> to just find the IRQ handler in a driver ... it's previously been all but
> guaranteed that the _only_ use of that type is the IRQ logic.  The upsides
> surely outweigh that.

You can use irqreturn_t for that.
