Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUCQSZz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 13:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUCQSZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 13:25:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:61656 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261904AbUCQSZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 13:25:53 -0500
Date: Wed, 17 Mar 2004 10:25:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: thomas.schlichter@web.de, phil.el@wanadoo.fr, schwab@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.4-rc2] bogus semicolon behind if()
Message-Id: <20040317102550.2ca7737c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.55.0403171734090.14525@jurand.ds.pg.gda.pl>
References: <200403090014.03282.thomas.schlichter@web.de>
	<20040308162947.4d0b831a.akpm@osdl.org>
	<20040309070127.GA2958@zaniah>
	<200403091208.20556.thomas.schlichter@web.de>
	<Pine.LNX.4.55.0403171734090.14525@jurand.ds.pg.gda.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:
>
>  You need timer_ack set to one when either:
> 
> 1. you use the I/O APIC NMI watchdog and you have a discrete APIC chip
> (i.e. the 82489DX),
> 
> or:
> 
> 2. the timer interrupt (IRQ 0) goes through one of the APICs (whatever
> way; we check three variations) and the TSC is non-functional (absent or 
> disabled).
> 

I still have a couple of NMI patches in -mm:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc1/2.6.5-rc1-mm1/broken-out/nmi_watchdog-local-apic-fix.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc1/2.6.5-rc1-mm1/broken-out/nmi-1-hz.patch

What should we do with these?
