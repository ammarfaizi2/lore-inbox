Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVCLNkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVCLNkf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 08:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVCLNkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 08:40:33 -0500
Received: from mail.aei.ca ([206.123.6.14]:59630 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261910AbVCLNkZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 08:40:25 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-mm3
Date: Sat, 12 Mar 2005 08:40:58 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050312034222.12a264c4.akpm@osdl.org>
In-Reply-To: <20050312034222.12a264c4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503120840.59095.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 March 2005 06:42, Andrew Morton wrote:
> 2.6.11-mm3
>  From: Andrew Morton <akpm@osdl.org>
>  To: linux-kernel@vger.kernel.org
>  
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm3/
> 
> 
> - A new version of the "acpi poweroff fix".  People who were having trouble
>   with ACPI poweroff, please test and report.
> 
> - A very large update to the CFQ I/O scheduler.  Treat with caution, run
>   benchmarks.  Remember that the I/O scheduler can be selected on a per-disk
>   basis with 
> 
>         echo as > /sys/block/sda/queue/scheduler
>         echo deadline > /sys/block/sda/queue/scheduler
>         echo cfq > /sys/block/sda/queue/scheduler
> 
> - video-for-linux update

Building with an -mm1 oldconfiged  on x86-64 arch I get:

  LD      fs/ntfs/built-in.o
  CC [M]  fs/ntfs/aops.o
  CC [M]  fs/ntfs/attrib.o
fs/ntfs/attrib.c: In function `ntfs_attr_make_non_resident':
fs/ntfs/attrib.c:1295: warning: implicit declaration of function `ntfs_cluster_alloc'
fs/ntfs/attrib.c:1296: error: `DATA_ZONE' undeclared (first use in this function)
fs/ntfs/attrib.c:1296: error: (Each undeclared identifier is reported only once
fs/ntfs/attrib.c:1296: error: for each function it appears in.)
fs/ntfs/attrib.c:1296: warning: assignment makes pointer from integer without a cast
fs/ntfs/attrib.c:1435: warning: implicit declaration of function `flush_dcache_mft_record_page'
fs/ntfs/attrib.c:1436: warning: implicit declaration of function `mark_mft_record_dirty'
fs/ntfs/attrib.c:1443: warning: implicit declaration of function `mark_page_accessed'
fs/ntfs/attrib.c:1521: warning: implicit declaration of function `ntfs_cluster_free_from_rl'
make[2]: *** [fs/ntfs/attrib.o] Error 1
make[1]: *** [fs/ntfs] Error 2
make: *** [fs] Error 2

Ed Tomlinson
