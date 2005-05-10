Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVEJEjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVEJEjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 00:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVEJEjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 00:39:36 -0400
Received: from web60515.mail.yahoo.com ([209.73.178.178]:53397 "HELO
	web60515.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261543AbVEJEj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 00:39:27 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=fVexhMnxTkElIHsiFi3hMTopz/O/wYWnW2euwkATuQdvNjYxjANThVs62CKGN/k2ZybWc+h+iz/R9JBoDKkaPI28AUBv2dVdK6wzzbr5sZo+BJUzynde7dU1mgVk5QPJlU0Hsmx8rOVq95xqbO/LbYhcVCRAsTKe9vL8RQRDgPk=  ;
Message-ID: <20050510043927.74120.qmail@web60515.mail.yahoo.com>
Date: Mon, 9 May 2005 21:39:27 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: Re: [BUG][Resend] 2.6.12-rc3-mm3: Kernel BUG at "mm/slab.c":1219
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Andi Kleen <ak@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael, under what scenario does it occur, do u have a
reproducible test case for this.

-lnxluv

--- "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> Hi,
> 
> I get this from 2.6.12-rc3-mm3 on a UP AMD64 box
> (Asus L5D), 100% of the time:
> 
> ]--snip--[
> ACPI: bus type pci registered
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> kmem_cache_create: Early error in slab <NULL>
> ----------- [cut here ] --------- [please bite here
> ] ---------
> Kernel BUG at "mm/slab.c":1219
> invalid operand: 0000 [1]
> CPU 0
> Modules linked in:
> Pid: 1, comm: swapper Not tainted 2.6.12-rc3-mm3
> RIP: 0010:[<ffffffff80179eeb>]
> <ffffffff80179eeb>{kmem_cache_create+139}
> RSP: 0000:ffff810001ca1eb8  EFLAGS: 00010292
> RAX: 0000000000000034 RBX: 0000000000000000 RCX:
> 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000dd3 RDI:
> ffffffff804167e0
> RBP: 0000000000000005 R08: 0000000000000000 R09:
> 0000000000000000
> R10: 0000000000000010 R11: 0000000000000008 R12:
> 0000000000042000
> R13: 0000000000000000 R14: 0000ffffffff8010 R15:
> 0000000000000000
> FS:  0000000000000000(0000)
> GS:ffffffff8055a840(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000004000 CR3: 0000000000101000 CR4:
> 00000000000006e0
> Process swapper (pid: 1, threadinfo
> ffff810001ca0000, task ffff810001c5a7a0)
> Stack: fffffffffffffff8 0000000000000000
> 0000000000000000 0000000000000000
>        0000000000000010 0000000000000000
> 0000000000000005 0000000000000006
>        00000000ffffffff 0000ffffffff8010
> Call Trace:<ffffffff8057a11d>{init_bio+93}
> <ffffffff8010c0f2>{init+178}
>        <ffffffff8010fc37>{child_rip+8}
> <ffffffff8010c040>{init+0}
>        <ffffffff8010fc2f>{child_rip+0}
> 
> 
> Greets,
> Rafael


		
__________________________________ 
Yahoo! Mail Mobile 
Take Yahoo! Mail with you! Check email on your mobile phone. 
http://mobile.yahoo.com/learn/mail 
