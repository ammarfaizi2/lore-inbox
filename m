Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272048AbRH2TTe>; Wed, 29 Aug 2001 15:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272057AbRH2TT0>; Wed, 29 Aug 2001 15:19:26 -0400
Received: from ns.ithnet.com ([217.64.64.10]:44036 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S272048AbRH2TTE>;
	Wed, 29 Aug 2001 15:19:04 -0400
Date: Wed, 29 Aug 2001 21:18:10 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Message-Id: <20010829211810.68a75425.skraw@ithnet.com>
In-Reply-To: <200108291657.f7TGvlw27738@mailf.telia.com>
In-Reply-To: <20010829140706.3fcb735c.skraw@ithnet.com>
	<200108291657.f7TGvlw27738@mailf.telia.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2001 18:47:54 +0200
Roger Larsson <roger.larsson@skelleftea.mail.telia.com> wrote:

> Change the printout of 'current->pid' to 'current->comm' format '%s'

Ok. I can present this one:

Aug 29 21:13:27 admin kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=0, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8845>] [<fdcf8913>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf8913>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 2-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=2, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8845>] [<fdcf8913>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 1-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=1, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8845>] [<fdcf8913>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=0, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8845>] [<fdcf8913>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf8913>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf8913>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf8913>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf8913>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf8913>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf8913>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf8913>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf8913>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf8913>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf8913>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf8913>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf8913>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf8913>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf8913>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 
Aug 29 21:13:27 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 29 21:13:27 admin kernel: comm=cdda2wav; __alloc_pages(gfp=0x20, order=3, ...)
Aug 29 21:13:27 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] [<fdcf77d7>] 
Aug 29 21:13:27 admin kernel:    [<fdcf80f5>] [<fdcf6589>] [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcf8826>] [<fdcf88f5>] 
Aug 29 21:13:27 admin kernel:    [<fdcf76bd>] [filemap_nopage+171/1008] [do_no_page+90/244] [handle_mm_fault+97/192] [<fdcf54aa>] [do_page_fault+0/1164] 
Aug 29 21:13:27 admin kernel:    [dentry_open+189/316] [filp_open+82/92] [do_fcntl+370/712] [sys_ioctl+443/532] [system_call+51/56] 

Let me see if I can produce some others, too. 
I'll be back.

Regards, Stephan

