Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264391AbUEEJyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbUEEJyB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 05:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUEEJyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 05:54:01 -0400
Received: from port-212-202-41-96.reverse.qsc.de ([212.202.41.96]:58775 "EHLO
	rocklinux-consulting.de") by vger.kernel.org with ESMTP
	id S264412AbUEEJx5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 05:53:57 -0400
Date: Wed, 05 May 2004 11:53:50 +0200 (CEST)
Message-Id: <20040505.115350.52162881.rene@rocklinux-consulting.de>
To: mikpe@csd.uu.se
Cc: rmrmg@wp.pl, linux-kernel@vger.kernel.org, m.c.p@kernel.linux-systeme.com
Subject: Re: Linux 2.4.27-pre2 (gcc-3.4.0)
From: Rene Rebe <rene@rocklinux-consulting.de>
In-Reply-To: <16536.46148.924407.411523@alkaid.it.uu.se>
References: <20040505.083644.241899480.rene@rocklinux-consulting.de>
	<20040505101553.7110da0c.rmrmg@wp.pl>
	<16536.46148.924407.411523@alkaid.it.uu.se>
X-Mailer: Mew version 3.1 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "heap.localnet", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On: Wed, 5 May 2004 11:30:44 +0200, Mikael
	Pettersson <mikpe@csd.uu.se> wrote: >  =?ISO-8859-1?Q?=20Rafa=B3?= 'rmrmg' Roszak writes: > >
	begin Rene Rebe <rene@rocklinux-consulting.de> quote: > > > > > It is
	for 2.4.26 - but should apply mostly to 2.4.27-pre2, too - I > > > have
	not yet booted the resulting kernel, soo .... > > > > patching file
	kernel/sysctl.c > > Hunk #1 succeeded at 879 (offset 3 lines). > > Hunk
	#3 succeeded at 1133 (offset 3 lines). > > patching file lib/brlock.c >
	> patching file lib/crc32.c > > patching file lib/rwsem.c > > patching
	file lib/string.c > > patching file mm/filemap.c > > patching file
	mm/memory.c > > patching file mm/page_alloc.c > > Hunk #1 FAILED at 82.
	> > Hunk #2 succeeded at 241 (offset 41 lines). > > Hunk #4 succeeded
	at 295 (offset 41 lines). > > Hunk #6 succeeded at 486 (offset 41
	lines). > > Hunk #8 succeeded at 509 (offset 41 lines). > > 1 out of 8
	hunks FAILED -- saving rejects to file mm/page_alloc.c.rej > > Read the
	archives, a solution has been available since last week. Use: >
	http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-2.4.27-pre2
	> > This has been throughly tested on i386 and x86_64 UP and SMP, and
	ppc UP, > although I have not verified drivers I don't use myself.
	[...] 
	Content analysis details:   (0.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On: Wed, 5 May 2004 11:30:44 +0200,
    Mikael Pettersson <mikpe@csd.uu.se> wrote:
> Rafa³ 'rmrmg' Roszak writes:
>  > begin  Rene Rebe <rene@rocklinux-consulting.de> quote:
>  > 
>  > > It is for 2.4.26 - but should apply mostly to 2.4.27-pre2, too - I
>  > > have not yet booted the resulting kernel, soo ....
>  > 
>  > patching file kernel/sysctl.c
>  > Hunk #1 succeeded at 879 (offset 3 lines).
>  > Hunk #3 succeeded at 1133 (offset 3 lines).
>  > patching file lib/brlock.c
>  > patching file lib/crc32.c
>  > patching file lib/rwsem.c
>  > patching file lib/string.c
>  > patching file mm/filemap.c
>  > patching file mm/memory.c
>  > patching file mm/page_alloc.c
>  > Hunk #1 FAILED at 82.
>  > Hunk #2 succeeded at 241 (offset 41 lines).
>  > Hunk #4 succeeded at 295 (offset 41 lines).
>  > Hunk #6 succeeded at 486 (offset 41 lines).
>  > Hunk #8 succeeded at 509 (offset 41 lines).
>  > 1 out of 8 hunks FAILED -- saving rejects to file mm/page_alloc.c.rej
> 
> Read the archives, a solution has been available since last week. Use:
> http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-2.4.27-pre2
> 
> This has been throughly tested on i386 and x86_64 UP and SMP, and ppc UP,
> although I have not verified drivers I don't use myself.

IIRC I based "my" patch uppon your's rediffed one chunk for 2.4.26 and
added some more driver fixes (since our build system automatically
enables as many as possible ...

So your patch alone should not fix this error - unfortunatly I'm
already fixing so many user-space apps for gcc-3.4 that I have not the
time to track 2.4.27 right now.

Sincerely yours,
  René Rebe
    - ROCK Linux stable release maintainer

--  
René Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene@rocklinux-consulting.de
http://www.rocklinux.org http://www.rocklinux-consulting.de

