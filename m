Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264440AbUEEKVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264440AbUEEKVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 06:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbUEEKVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 06:21:12 -0400
Received: from aun.it.uu.se ([130.238.12.36]:42193 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264440AbUEEKVE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 06:21:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16536.49160.419657.899445@alkaid.it.uu.se>
Date: Wed, 5 May 2004 12:20:56 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Rene Rebe <rene@rocklinux-consulting.de>
Cc: mikpe@csd.uu.se, rmrmg@wp.pl, linux-kernel@vger.kernel.org,
       m.c.p@kernel.linux-systeme.com
Subject: Re: Linux 2.4.27-pre2 (gcc-3.4.0)
In-Reply-To: <20040505.115350.52162881.rene@rocklinux-consulting.de>
References: <20040505.083644.241899480.rene@rocklinux-consulting.de>
	<20040505101553.7110da0c.rmrmg@wp.pl>
	<16536.46148.924407.411523@alkaid.it.uu.se>
	<20040505.115350.52162881.rene@rocklinux-consulting.de>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Rebe writes:
 > Hi,
 > 
 > On: Wed, 5 May 2004 11:30:44 +0200,
 >     Mikael Pettersson <mikpe@csd.uu.se> wrote:
 > > Rafa³ 'rmrmg' Roszak writes:
 > >  > begin  Rene Rebe <rene@rocklinux-consulting.de> quote:
 > >  > 
 > >  > > It is for 2.4.26 - but should apply mostly to 2.4.27-pre2, too - I
 > >  > > have not yet booted the resulting kernel, soo ....
 > >  > 
 > >  > patching file kernel/sysctl.c
 > >  > Hunk #1 succeeded at 879 (offset 3 lines).
 > >  > Hunk #3 succeeded at 1133 (offset 3 lines).
 > >  > patching file lib/brlock.c
 > >  > patching file lib/crc32.c
 > >  > patching file lib/rwsem.c
 > >  > patching file lib/string.c
 > >  > patching file mm/filemap.c
 > >  > patching file mm/memory.c
 > >  > patching file mm/page_alloc.c
 > >  > Hunk #1 FAILED at 82.
 > >  > Hunk #2 succeeded at 241 (offset 41 lines).
 > >  > Hunk #4 succeeded at 295 (offset 41 lines).
 > >  > Hunk #6 succeeded at 486 (offset 41 lines).
 > >  > Hunk #8 succeeded at 509 (offset 41 lines).
 > >  > 1 out of 8 hunks FAILED -- saving rejects to file mm/page_alloc.c.rej
 > > 
 > > Read the archives, a solution has been available since last week. Use:
 > > http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-2.4.27-pre2
 > > 
 > > This has been throughly tested on i386 and x86_64 UP and SMP, and ppc UP,
 > > although I have not verified drivers I don't use myself.
 > 
 > IIRC I based "my" patch uppon your's rediffed one chunk for 2.4.26 and
 > added some more driver fixes (since our build system automatically
 > enables as many as possible ...

I see. That wasn't apparent from your previous message.

Anyway, 2.4.27-pre2 changed mm/page_alloc.c in a way that caused
the gcc340 fixes patch for 2.4.27-pre1 to fail. My updated patch
for -pre2 fixes this problem.
