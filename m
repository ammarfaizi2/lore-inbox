Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbTK3Srd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 13:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTK3Srd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 13:47:33 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:62594
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262762AbTK3Srb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 13:47:31 -0500
Date: Sun, 30 Nov 2003 13:46:24 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: pgcl-2.6.0-test5-bk3-17
In-Reply-To: <20031130164301.GK8039@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0311301321100.31421@montezuma.fsmlabs.com>
References: <20031128041558.GW19856@holomorphy.com> <20031128072148.GY8039@holomorphy.com>
 <20031130164301.GK8039@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Nov 2003, William Lee Irwin III wrote:

> On Thu, Nov 27, 2003 at 11:21:48PM -0800, William Lee Irwin III wrote:
> > Now also ported to 2.6.0-test11:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/pgcl-2.6.0-test11-1.gz
> > This also corrects some PAGE_SHIFT instances that crept into mm/mmap.c
> > while I wasn't looking and drops sym2 driver changes.
>
> I wonder if this would be enough to get sysenter support going again.
> I've not got a sysenter-capable userspace around, so I can't really
> test this myself.
>
> vs. pgcl-2.6.0-test11-5

Brilliant!

Linux arusha.mastecende.com 2.6.0-test11-pgcl #4 SMP Sun Nov 30 13:30:51 EST 2003 i686 i686 i386 GNU/Linux

tcsh          S C0155C8D     0  1132   1131                     (NOTLB)
def85e60 00000086 def8b29c c0155c8d def85e44 def85e9c c060b940 c013010f
       0001c1ec 00000000 c1143640 00008734 ff21d58e 00000019 dea41fd0 0000000e
       fff24fc0 00000008 7fffffff c1657d7c de7f9000 c0131035 dc21bfcc c1119338
Call Trace:
 [<c0155c8d>] private_folio_page+0x1d/0x2c0
 [<c013010f>] __mod_timer+0x10f/0x360
 [<c0131035>] schedule_timeout+0xb5/0xc0
 [<c032cc53>] read_chan+0x2b3/0xc50
 [<c011d1f1>] do_page_fault+0x5b1/0x871
 [<c0121830>] default_wake_function+0x0/0x20
 [<c032dfc1>] set_termios+0x111/0x180
 [<c0121830>] default_wake_function+0x0/0x20
 [<c0326c3b>] tty_read+0x15b/0x1a0
 [<c0326ae0>] tty_read+0x0/0x1a0
 [<c0326ae0>] tty_read+0x0/0x1a0
 [<c016ac9c>] vfs_read+0xac/0xf0
 [<c016aead>] sys_read+0x2d/0x50
 [<c0109719>] sysenter_past_esp+0x52/0x79
