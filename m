Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbTJOKSp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 06:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbTJOKSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 06:18:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:431 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262493AbTJOKSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 06:18:44 -0400
Date: Wed, 15 Oct 2003 03:22:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bradley Chapman <kakadu_croc@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7-mm1
Message-Id: <20031015032215.58d832c1.akpm@osdl.org>
In-Reply-To: <20031015101151.11153.qmail@web40901.mail.yahoo.com>
References: <20031015101151.11153.qmail@web40901.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bradley Chapman <kakadu_croc@yahoo.com> wrote:
>
> After compiling 2.6.0-test7-mm1, I get the following error after installing the
>  modules:
> 
>  if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.0-test7-mm1; fi
>  WARNING: /lib/modules/2.6.0-test7-mm1/kernel/fs/ext2/ext2.ko needs unknown symbol
>  __blockdev_direct_IO

Thanks.


 fs/direct-io.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/direct-io.c~O_DIRECT-race-fixes-rework-XFS-fix-fix fs/direct-io.c
--- 25/fs/direct-io.c~O_DIRECT-race-fixes-rework-XFS-fix-fix	2003-10-15 03:21:13.000000000 -0700
+++ 25-akpm/fs/direct-io.c	2003-10-15 03:21:16.000000000 -0700
@@ -1089,4 +1089,4 @@ __blockdev_direct_IO(int rw, struct kioc
 out:
 	return retval;
 }
-EXPORT_SYMBOL(blockdev_direct_IO);
+EXPORT_SYMBOL(__blockdev_direct_IO);

_

