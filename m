Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbUC3JYl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 04:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUC3JYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 04:24:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:52151 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263571AbUC3JYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 04:24:17 -0500
Date: Tue, 30 Mar 2004 01:24:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm5
Message-Id: <20040330012404.34012b35.akpm@osdl.org>
In-Reply-To: <200403301127.35263.rjwysocki@sisk.pl>
References: <20040329014525.29a09cc6.akpm@osdl.org>
	<200403301127.35263.rjwysocki@sisk.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
>
> On Monday 29 of March 2004 11:45, Andrew Morton wrote:
> >
> > +remove-down_tty_sem.patch
> > +tty-locking-again.patch
> >
> 
> These two patches break things quite a bit for me.  With them, the kernel is 
> unable to open any tty (virtual console, pts, whatever), it seems (my system 
> is a dual AMD64 w/ NUMA w/o kernel preemption).

yup.  Please revert tty-locking-again.patch.  Or just do
rm drivers/char/tty* and start again.
