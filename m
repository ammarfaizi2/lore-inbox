Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287306AbSALWbh>; Sat, 12 Jan 2002 17:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287609AbSALWb1>; Sat, 12 Jan 2002 17:31:27 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:15601 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S287306AbSALWbL>; Sat, 12 Jan 2002 17:31:11 -0500
Date: Sat, 12 Jan 2002 17:34:56 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1-2-3 GB
Message-ID: <20020112173456.A7114@earthlink.net>
In-Reply-To: <20020112004528.A159@earthlink.net> <20020112125625.E1482@inspiron.school.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020112125625.E1482@inspiron.school.suse.de>; from andrea@suse.de on Sat, Jan 12, 2002 at 12:56:25PM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This configure help may be clearer than the previous.

--- linux.aa2/Documentation/Configure.help      Fri Jan 11 20:57:58 2002
+++ linux/Documentation/Configure.help  Sat Jan 12 17:27:01 2002
@@ -376,6 +376,50 @@
   Select this if you have a 32-bit processor and more than 4
   gigabytes of physical RAM.

+# Choice: maxvm
+Maximum Virtual Memory
+CONFIG_1GB
+  If you have 4 Gigabytes of physical memory or less, you can change
+  where the kernel maps high memory.  If you have less than 1 gigabyte
+  of physical memory, you should disable CONFIG_HIGHMEM4G because you
+  don't need the choices below.
+
+  If you have a large amount of physical memory, all of it may not
+  be "permanently mapped" by the kernel. The physical memory that
+  is not permanently mapped is called "high memory".
+
+  The numbers in the configuration options are not precise because
+  of the kernel's vmalloc() area, and the PCI space on motherboards
+  may vary as well.  Typically there will 128 megabytes less
+  "user memory" mapped than the number in the configuration option.
+  Saying that another way, "high memory" will usually start 128
+  megabytes lower than the configuration option.
+
+  Selecting "05GB" results in a "3.5GB/0.5GB" kernel/user split:
+  3.5 gigabytes are kernel mapped so each process sees a 3.5
+  gigabyte virtual memory space and the remaining part of the 4
+  gigabyte virtual memory space is used by the kernel to permanently
+  map as much physical memory as possible.  On a system with 1 gigabyte
+  of physical memory, you may get 384 megabytes of "user memory" and
+  640 megabytes of "high memory" with this selection.
+
+  Selecting "1GB" results in a "3GB/1GB" kernel/user split:
+  On a system with 1 gigabyte of memory, you may get 896 megabytes
+  of "user memory" and 128 megabytes of "high memory"
+
+  Selecting "2GB" results in a "2GB/2GB" kernel/user split:
+  On a system with 1 to 1.75 gigabytes of physical memory, this
+  option will make it so no memory is mapped as "high memory".
+
+  Selecting "3GB" results in a "1GB/3GB" kernel/user split:
+  On a system with 1 to 2.75 gigabytes of physical memory, this
+  option will make it so no memory is mapped as "high memory".
+
+  Options "2GB" and "3GB" may expose bugs that were dormant in
+  certain hardware and possibly even the kernel.
+
+  If unsure, say "1GB".
+
 HIGHMEM I/O support
 CONFIG_HIGHIO
   If you want to be able to do I/O to high memory pages, say Y.

-- 
Randy Hron

