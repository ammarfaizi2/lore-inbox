Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVCLKmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVCLKmF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 05:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVCLKmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 05:42:05 -0500
Received: from fire.osdl.org ([65.172.181.4]:20969 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261343AbVCLKmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 05:42:02 -0500
Date: Sat, 12 Mar 2005 02:41:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Junfeng Yang <yjf@stanford.edu>
Cc: chaffee@bmrc.berkeley.edu, mc@cs.Stanford.EDU,
       linux-kernel@vger.kernel.org,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [CHECKER] crash + fsck cause file systems to contain loops
 (msdos and vfat, 2.6.11)
Message-Id: <20050312024114.173114fb.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.44.0503120220190.10643-100000@elaine24.Stanford.EDU>
References: <Pine.GSO.4.44.0503120220190.10643-100000@elaine24.Stanford.EDU>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junfeng Yang <yjf@stanford.edu> wrote:
>
> We are from the Stanford Checker team and are currently developing a file
>  system checker call FiSC.  FiSC mainly focuses on finding crash-recovery
>  errors.  We applied it to FiSC and found a serious error where crash then
>  recovery cause the file system to contain loops.
> 
>  To reproduce the warning, download and run our test cases at
> 
>  http://fisc.stanford.edu/bug7/crash.c (for msdos)
>  http://fisc.stanford.edu/bug10/crash.c (for vfat)
> 
>  you can also find the crashed disk images in the corresponding
>  directories.
> 
>  We are not sure if these are bugs or not.  Your
>  confirmations/clarifications on this are well appreciated.

Linus's current tree includes support for `mount -o sync' on the msdos and
vfat filesystems.

