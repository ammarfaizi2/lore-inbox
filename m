Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVBUKiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVBUKiN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 05:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVBUKiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 05:38:12 -0500
Received: from fire.osdl.org ([65.172.181.4]:11968 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261945AbVBUKhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 05:37:51 -0500
Date: Mon, 21 Feb 2005 02:37:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: m_droh01@uni-muenster.de, linux-kernel@vger.kernel.org
Subject: Re: Why does printk helps PCMCIA card to initialise?
Message-Id: <20050221023702.0868c88f.akpm@osdl.org>
In-Reply-To: <20050221091754.A28213@flint.arm.linux.org.uk>
References: <42187819.5050808@uni-muenster.de>
	<20050220123817.A12696@flint.arm.linux.org.uk>
	<20050221091754.A28213@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Sun, Feb 20, 2005 at 12:38:17PM +0000, Russell King wrote:
>  > The first thing that needs solving is why you're getting the "odd IO
>  > request" crap.  That may explain why the resource can't be allocated.
> 
>  In cs.c, alloc_io_space(), find the line:
> 
>      if (*base & ~(align-1)) {
> 
>  delete the ~ and rebuild.  This may resolve your problem.
> 
>  This looks like a long standing bug in the PCMCIA code, going back to
>  2.4 kernels.

That looks right to me - I'll queue up a fix for after 2.6.11.
