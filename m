Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbTJRQtj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 12:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTJRQtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 12:49:39 -0400
Received: from adsl-215-226.38-151.net24.it ([151.38.226.215]:5905 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S261705AbTJRQth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 12:49:37 -0400
Date: Sat, 18 Oct 2003 18:49:35 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test8
Message-ID: <20031018164934.GA937@picchio.gall.it>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0310171530001.1988-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310171530001.1988-100000@home.osdl.org>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.22
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 03:31:00PM -0700, Linus Torvalds wrote:
> 
> More changes than I would have liked, but most of them are fairly small. 
> The most noticeable changes:
> 

I get these two sleeping functions etc. etc. on boot with 2.6.0-test8:

Kernel command line: root=/dev/hda3
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Debug: sleeping function called from invalid context at include/linux/rwsem.h:66
in_atomic():1, irqs_disabled():1
Call Trace:
 [<c011d1d0>] __might_sleep+0xa0/0xd0
 [<c02796f0>] cpufreq_register_notifier+0x30/0xa0
 [<c0105000>] rest_init+0x0/0x60
 [<c03b330b>] init_tsc+0x4b/0x170
 [<c03b683b>] init_timers+0x3b/0x40
 [<c0105000>] rest_init+0x0/0x60
 [<c011467d>] select_timer+0x2d/0x50
 [<c03afa8e>] time_init+0x3e/0x70
 [<c03ac675>] start_kernel+0xb5/0x160
 [<c03ac480>] unknown_bootoption+0x0/0x100

Detected 1674.442 MHz processor.
Console: colour VGA+ 80x25
Memory: 482692k/491432k available (1930k kernel code, 7948k reserved, 789k data, 144k init, 0k highmem)
Calibrating delay loop... 3309.56 BogoMIPS
Debug: sleeping function called from invalid context at mm/page_alloc.c:548
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c0105000>] rest_init+0x0/0x60
 [<c011d1d0>] __might_sleep+0xa0/0xd0
 [<c013db75>] __alloc_pages+0x335/0x340
 [<c011fdbc>] printk+0x12c/0x180
 [<c0105000>] rest_init+0x0/0x60
 [<c013dbf0>] get_zeroed_page+0x20/0x60
 [<c03b6a7c>] pidmap_init+0xc/0x40
 [<c03ac69d>] start_kernel+0xdd/0x160
 [<c03ac480>] unknown_bootoption+0x0/0x100

Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[...]

Apart from that, everything work well (of what has been tested 8) ).

-- 
----------------------------------------
Daniele Venzano
Web: http://digilander.iol.it/webvenza/

