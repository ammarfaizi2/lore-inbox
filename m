Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbUKAJeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbUKAJeA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 04:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbUKAJeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 04:34:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:41179 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261649AbUKAJd6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 04:33:58 -0500
Date: Mon, 1 Nov 2004 01:31:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jaakko =?ISO-8859-1?B?SHl25HR0aQ==?= <jaakko@hyvatti.iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 and nfsd do not work under load (Re: x86_64, LOCKUP on
 CPU0, kjournald)
Message-Id: <20041101013150.2ab0aaa5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411010847180.2172@gyre.weather.fi>
References: <Pine.LNX.4.58.0410260818560.3400@gyre.weather.fi>
	<Pine.LNX.4.58.0411010847180.2172@gyre.weather.fi>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaakko Hyvätti <jaakko@hyvatti.iki.fi> wrote:
>
> 
> Here is another oops and lockup, with nfsd now there in the trace also:
> 
> Unable to handle kernel paging request at ffffffff00000808 RIP:
> <ffffffff80161b37>{cache_alloc_refill+329}
> PML4 103027 PGD 0
> Oops: 0002 [1] SMP
> CPU 0
> Modules linked in: w83627hf i2c_sensor i2c_isa i2c_core nfsd exportfs lockd sunrpc md5 ipv6 parport_pc lp parport tg3 ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables dm_mod ohci_hcd button battery asus_acpi ac ext3 jbd 3w_xxxx sd_mod scsi_mod
> Pid: 1968, comm: nfsd Not tainted 2.6.8-1.521smp

That's a vendor kernel of some form, yes?

> RIP: 0010:[<ffffffff80161b37>] <ffffffff80161b37>{cache_alloc_refill+329}

I'd suggest that you either recompile this vendor kernel with
CONFIG_DEBUG_SLAB=y or try a later kernel.org kernel and see if it's fixed.
Or look for an updated kernel from your vendor.  And check the vendor's
bug tracking system for other reports of this problem.

I don't recall having seen anyone else report this crash.
