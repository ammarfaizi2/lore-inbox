Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbTLZTIv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 14:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbTLZTIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 14:08:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:54447 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265213AbTLZTIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 14:08:50 -0500
Date: Fri, 26 Dec 2003 11:08:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 kgdb without serial port
Message-Id: <20031226110851.29ce9fa5.akpm@osdl.org>
In-Reply-To: <20031226182740.GA10397@elf.ucw.cz>
References: <20031215200640.GA3724@elf.ucw.cz>
	<20031215223438.196295a8.akpm@osdl.org>
	<20031226182740.GA10397@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> > > 2.6 kgdb patches in -mm tree seem to contain kgdb-over-ethernet stuff,
> > > but still require me to fill in serial port interrupt/address. Is
> > > there easy way to make it work without serial port? [This notebook has
> > > none :-(].
> > 
> > That's a bit ugly, but things should still work OK?  Give it some random
> > UART address but specify an ethernet connection at boot time - the kgdb
> > stub should never touch the UART.
> 
> I found out what was biting me: using 2.95 with kgdb is bad idea. 2.95
> with kgdb means reboot just after uncompressing kernel -- pretty nasty
> to debug. Please apply,

I've been using 2.95.3 on and off for ages, no problems?

> PS: kgdb could use some code-style changes. Will you accept such
> patches?

Spose so.  The kgdb stub really needs a serious reorganisation so that
non-ia32 architectures can share generic things.  And general reduction of
the patch footprint, maybe some feature removal too.   A fairly large job.

