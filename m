Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263823AbUEEIQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUEEIQV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 04:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbUEEIQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 04:16:03 -0400
Received: from smtp.wp.pl ([212.77.101.160]:693 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S263823AbUEEIP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 04:15:58 -0400
Date: Wed, 5 May 2004 10:15:53 +0200
From: "=?ISO-8859-2?Q?Rafa=B3?= 'rmrmg' Roszak" <rmrmg@wp.pl>
To: linux-kernel@vger.kernel.org
Cc: m.c.p@kernel.linux-systeme.com
Subject: Re: Linux 2.4.27-pre2 (gcc-3.4.0)
Message-Id: <20040505101553.7110da0c.rmrmg@wp.pl>
In-Reply-To: <20040505.083644.241899480.rene@rocklinux-consulting.de>
References: <20040504211939.79ed1e6f.rmrmg@wp.pl>
	<200405042146.40404@WOLK>
	<20040504220325.25516d8f.rmrmg@wp.pl>
	<20040505.083644.241899480.rene@rocklinux-consulting.de>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A. [wersja 2.0c]
X-WP-AntySpam-Rezultat: NIE-SPAM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

begin  Rene Rebe <rene@rocklinux-consulting.de> quote:

> It is for 2.4.26 - but should apply mostly to 2.4.27-pre2, too - I
> have not yet booted the resulting kernel, soo ....

patching file kernel/sysctl.c
Hunk #1 succeeded at 879 (offset 3 lines).
Hunk #3 succeeded at 1133 (offset 3 lines).
patching file lib/brlock.c
patching file lib/crc32.c
patching file lib/rwsem.c
patching file lib/string.c
patching file mm/filemap.c
patching file mm/memory.c
patching file mm/page_alloc.c
Hunk #1 FAILED at 82.
Hunk #2 succeeded at 241 (offset 41 lines).
Hunk #4 succeeded at 295 (offset 41 lines).
Hunk #6 succeeded at 486 (offset 41 lines).
Hunk #8 succeeded at 509 (offset 41 lines).
1 out of 8 hunks FAILED -- saving rejects to file mm/page_alloc.c.rej

[root@slack:/usr/src/linux-2.4.27-pre2#] cat ./mm/page_alloc.c.rej 
***************
*** 82,88 ****
   */
  
  static void FASTCALL(__free_pages_ok (struct page *page, unsigned int
order));- static void __free_pages_ok (struct page *page, unsigned int
order)  {
  	unsigned long index, page_idx, mask, flags;
  	free_area_t *area;
--- 82,88 ----
   */
  
  static void FASTCALL(__free_pages_ok (struct page *page, unsigned int
order));+ static void fastcall __free_pages_ok (struct page *page,
unsigned int order)  {
  	unsigned long index, page_idx, mask, flags;
  	free_area_t *area;
[root@slack:/usr/src/linux-2.4.27-pre2#] 


make[2]: Entering directory `/usr/src/linux-2.4.27-pre2/mm'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.27-pre2/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon
-fno-unit-at-a-time   -nostdinc -iwithprefix include
-DKBUILD_BASENAME=page_alloc  -DEXPORT_SYMTAB -c page_alloc.c
page_alloc.c:115: error: conflicting types for '__free_pages_ok'
page_alloc.c:51: error: previous declaration of '__free_pages_ok' was
here page_alloc.c:115: error: conflicting types for '__free_pages_ok'
page_alloc.c:51: error: previous declaration of '__free_pages_ok' was
here page_alloc.c:51: warning: '__free_pages_ok' used but never defined
make[2]: *** [page_alloc.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.27-pre2/mm'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.27-pre2/mm'
make: *** [_dir_mm] Error 2




-- 
. JID: rmrmg(at)jabberpl(dot)org |   RMRMG   .
.           gg: #2311504         | signature .
.   mail: rmrmg(at)wp(dot)pl     |  version  .
.  registered Linux user 261525  |   0.0.3   .
