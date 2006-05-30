Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751542AbWE3B2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbWE3B2W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWE3B2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:28:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55999 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751540AbWE3B2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:28:21 -0400
Date: Mon, 29 May 2006 18:32:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 01/61] lock validator: floppy.c irq-release fix
Message-Id: <20060529183234.2ee78c49.akpm@osdl.org>
In-Reply-To: <20060529212256.GA3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212256.GA3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:22:56 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> floppy.c does alot of irq-unsafe work within floppy_release_irq_and_dma():
> free_irq(), release_region() ... so when executing in irq context, push
> the whole function into keventd.

I seem to remember having issues with this - of the "not yet adequate"
type.  But I forget what they were.  Perhaps we have enough
flush_scheduled_work()s in there now.

We're glad to see you reassuming floppy.c maintenance.
