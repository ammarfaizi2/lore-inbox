Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265721AbSKFI2O>; Wed, 6 Nov 2002 03:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265996AbSKFI2O>; Wed, 6 Nov 2002 03:28:14 -0500
Received: from packet.digeo.com ([12.110.80.53]:28081 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265721AbSKFI2M>;
	Wed, 6 Nov 2002 03:28:12 -0500
Message-ID: <3DC8D423.DAD2BF1A@digeo.com>
Date: Wed, 06 Nov 2002 00:34:43 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: 2.5.46-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 08:34:43.0968 (UTC) FILETIME=[5B50C800:01C2856F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.46/2.5.46-mm1/

It wasn't clear whether it was useful or desirable to keep these patchsets
turning over.  But it will be helpful to keep them as a marshalling point
for people to see what is queued up, to get some additional testing and
stabilisation and for people to sync up against.  And also to keep things
like shared pagetables and dcache-rcu under test.

2.5.46-mm1 includes various fixes to things, Bill's hugetlb rework,
dcache-rcu and shared pagetables.

Also the patches which make the address_space's private_lock and page_lock
irq-safe.  So Badari can run set_page_dirty() from interrupts...


linus.patch
  cset-1.895.1.7-to-1.925.txt.gz

kgdb.patch

net-timer-init.patch

genksyms-hurts.patch
  fix exporting of per-cpu symbols for modversions

misc.patch
  misc fixes

writev-bad-seg-fix.patch
  Fix readv/writev return value

wli-01-iowait.patch
  SMP iowait stats

wli-02-zap_hugetlb_resources.patch
  hugetlb: fix zap_hugetlb_resources()

wli-03-remove-unlink_vma.patch
  hugetlb: remove unlink_vma()

wli-04-internalize-hugetlb-init.patch
  hugetlb: internalize hugetlb init

wli-05-sysctl-cleanup.patch
  hugetlb: remove sysctl.c intrusion

wli-06-cleanup-proc.patch
  hugetlb: remove /proc/ intrusion

wli-07-hugetlb-static.patch
  hugetlb: make private functions static

msec-fix.patch
  Fix math underflow in disk accounting

touch_buffer-fix.patch
  buffer_head refcounting fixes and cleanup

mbcache-atomicity-fix.patch

pgalloc-accounting-fix.patch
  fix page alloc/free accounting

htree-fix.patch
  fix ext3-htree buffer_head leak

irq-save-vm-locks.patch
  make mapping->page_lock irq-safe

irq-safe-private-lock.patch
  make mapping->private_lock irq-safe

akpm-deadline.patch
  deadline scheduler tweaks

dcache_rcu.patch
  Use RCU for dcache

page-reservation.patch
  Page reservation API

resurrect-incremental-min.patch
  strengthen the `incremental min' logic in the page allocator

wli-show_free_areas.patch
  show_free_areas extensions

shpte-ng.patch
  pagetable sharing for ia32
