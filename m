Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263904AbUDPWvi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbUDPWvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:51:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:52439 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263904AbUDPWv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:51:27 -0400
Date: Fri, 16 Apr 2004 15:53:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: k.gavrilenko@arhont.com
Cc: mlists@arhont.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm6 reiserfs and hpt366 problems
Message-Id: <20040416155337.34555e61.akpm@osdl.org>
In-Reply-To: <408057A5.6010604@arhont.com>
References: <408057A5.6010604@arhont.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Gavrilenko <mlists@arhont.com> wrote:
>
> Anyway, I applied 2.6.5-mm6 patch. The system does not hang anymore, but,
> I get this weird errors filling up syslog:
> 
> 
> Apr 16 22:45:06 filo kernel: Debug: sleeping function called from 
> invalid context at drivers/block/ll_rw_blk.c:1156
> Apr 16 22:45:06 filo kernel: in_atomic():0, irqs_disabled():1
> Apr 16 22:45:06 filo kernel: Call Trace:
> Apr 16 22:45:06 filo kernel:  [<c0117449>] __might_sleep+0x99/0xb0
> Apr 16 22:45:06 filo kernel:  [<c02950bf>] generic_unplug_device+0x1f/0x60
> Apr 16 22:45:06 filo kernel:  [<c02d9fc9>] unplug_slaves+0x69/0x70
> Apr 16 22:45:06 filo kernel:  [<c029511f>] blk_backing_dev_unplug+0x1f/0x30
> Apr 16 22:45:06 filo kernel:  [<c014dc99>] __wait_on_buffer+0xd9/0xe0
> Apr 16 22:45:06 filo kernel:  [<c0117770>] autoremove_wake_function+0x0/0x50
> Apr 16 22:45:06 filo kernel:  [<c013998c>] mark_page_accessed+0x2c/0x40
> Apr 16 22:45:06 filo kernel:  [<c0117770>] autoremove_wake_function+0x0/0x50
> Apr 16 22:45:06 filo kernel:  [<c01a91da>] flush_commit_list+0x29a/0x3a0
> Apr 16 22:45:06 filo kernel:  [<c01adf1a>] do_journal_end+0x85a/0xb60
> Apr 16 22:45:06 filo kernel:  [<c0136b30>] pdflush+0x0/0x30
> Apr 16 22:45:06 filo kernel:  [<c01acc8d>] journal_end_sync+0x4d/0x90
> Apr 16 22:45:06 filo kernel:  [<c019964d>] reiserfs_sync_fs+0x4d/0x60
> Apr 16 22:45:06 filo kernel:  [<c03776b7>] __down_failed_trylock+0x7/0xc
> Apr 16 22:45:06 filo kernel:  [<c0152b81>] sync_supers+0xb1/0xc0
> Apr 16 22:45:06 filo kernel:  [<c01361d6>] wb_kupdate+0x56/0x140
> Apr 16 22:45:06 filo kernel:  [<c0377974>] schedule+0x2a4/0x480
> Apr 16 22:45:06 filo kernel:  [<c0136a54>] __pdflush+0xa4/0x180
> Apr 16 22:45:06 filo kernel:  [<c0136b58>] pdflush+0x28/0x30
> Apr 16 22:45:06 filo kernel:  [<c0136180>] wb_kupdate+0x0/0x140
> Apr 16 22:45:06 filo kernel:  [<c0136b30>] pdflush+0x0/0x30

Someone else saw this, but they had an EVMS patch applied.  Have you
applied any additional patches here?

