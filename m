Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUEMSzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUEMSzq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 14:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbUEMSzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 14:55:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:32177 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264396AbUEMSzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 14:55:45 -0400
Date: Thu, 13 May 2004 11:55:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lorenzo Allegrucci <l_allegrucci@despammed.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2
Message-Id: <20040513115516.1bbfa7b7.akpm@osdl.org>
In-Reply-To: <200405131707.36807.l_allegrucci@despammed.com>
References: <20040513032736.40651f8e.akpm@osdl.org>
	<200405131707.36807.l_allegrucci@despammed.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Allegrucci <l_allegrucci@despammed.com> wrote:
>
>  On Thursday 13 May 2004 12:27, Andrew Morton wrote:
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-m
>  >m2/
> 
>  make[2]: *** No rule to make target `fs/xfs/support/qsort.s', needed by 
>  `fs/xfs/support/qsort.o'.  Stop.

That's odd.

diff -puN fs/xfs/Makefile~have-xfs-use-kernel-provided-qsort-fix fs/xfs/Makefile
--- 25/fs/xfs/Makefile~have-xfs-use-kernel-provided-qsort-fix	2004-05-13 11:54:24.869488456 -0700
+++ 25-akpm/fs/xfs/Makefile	2004-05-13 11:54:28.218979256 -0700
@@ -142,7 +142,6 @@ xfs-y				+= $(addprefix linux/, \
 xfs-y				+= $(addprefix support/, \
 				   debug.o \
 				   move.o \
-				   qsort.o \
 				   uuid.o)
 
 xfs-$(CONFIG_XFS_TRACE)		+= support/ktrace.o

_

