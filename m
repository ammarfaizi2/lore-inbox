Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131533AbRCXBlS>; Fri, 23 Mar 2001 20:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131538AbRCXBlI>; Fri, 23 Mar 2001 20:41:08 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:48655 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131533AbRCXBlB>;
	Fri, 23 Mar 2001 20:41:01 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Panic] 2.4.2ac22 
In-Reply-To: Your message of "Fri, 23 Mar 2001 19:44:16 CDT."
             <20010324004416.E03FE35D77@oscar.casa.dyndns.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 24 Mar 2001 12:40:14 +1100
Message-ID: <26858.985398014@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001 19:44:16 -0500 (EST), 
root@casa.dyndns.org (root) wrote:
>Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry

Against 2.4.2-ac23 to remove above warning.

Index: 2.45/mm/Makefile
--- 2.45/mm/Makefile Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/j/19_Makefile 1.1 644)
+++ 2.45(w)/mm/Makefile Sat, 24 Mar 2001 12:37:25 +1100 kaos (linux-2.4/j/19_Makefile 1.1 644)
@@ -9,6 +9,8 @@
 
 O_TARGET := mm.o
 
+export-objs := shmem.o
+
 obj-y	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
 	    page_alloc.o swap_state.o swapfile.o numa.o oom_kill.o \

