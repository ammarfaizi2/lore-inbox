Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422630AbWJLHAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422630AbWJLHAg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422770AbWJLHAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:00:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41659 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422630AbWJLHAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:00:36 -0400
Date: Thu, 12 Oct 2006 00:00:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Harris <googlegroups@mgharris.com>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.18: Kernel BUG at mm/rmap.c:522
Message-Id: <20061012000026.8b6ea2e5.akpm@osdl.org>
In-Reply-To: <20061011160740.GA6868@dingu.igconcepts.com>
References: <20061011160740.GA6868@dingu.igconcepts.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 11:07:40 -0500
Michael Harris <googlegroups@mgharris.com> wrote:


> Hi, I can readily reproduce this with 2.6.18 doing 4 simultanous kernel
> compiles on two disks to load test a P4 3.2 HT with 2GB.  I have SMP and
> SMT scheduling enabled, and the 4GB memory option.  Here is output with
> CONFIG_DEBUG_VM enabled followed by another crash before CONFIG_DEBUG_VM
> was enabled.

Repeatable.  That's good news.

> 
> [*ROOT* hen /usr/src/linux-2.6.18 14 ] uname -a
> Linux hen.igconcepts.com 2.6.18 #2 SMP Tue Oct 10 11:46:01 CDT 2006 i686 i686 i386 GNU/Linux
> [*ROOT* hen /usr/src/linux-2.6.18 15 ] gcc -v
> Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/3.2.2/specs
> Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --disable-checking --with-system-zlib --enable-__cxa_atexit --host=i386-redhat-linux
> Thread model: posix
> gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)
> 
> 
> ----------------
> Oct 11 04:53:35 hen kernel: VM: killing process cc1
> Oct 11 04:53:35 hen kernel: swap_free: Unused swap offset entry 00004000
> Oct 11 04:53:35 hen kernel: Eeek! page_mapcount(page) went negative! (-1)
> Oct 11 04:53:35 hen kernel:   page->flags = c0080014
> Oct 11 04:53:35 hen kernel:   page->count = 0
> Oct 11 04:53:35 hen kernel:   page->mapping = 00000000
> Oct 11 04:53:35 hen kernel: ------------[ cut here ]------------
> Oct 11 04:53:35 hen kernel: kernel BUG at mm/rmap.c:522!

Does that machine run any earlier kernels OK?  If so, which?

Thanks.
