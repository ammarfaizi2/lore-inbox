Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUADVH4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 16:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbUADVH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 16:07:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:996 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264389AbUADVHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 16:07:55 -0500
Date: Sun, 4 Jan 2004 13:07:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make modules_install problem in 2.6.0-rc1-mm1
Message-Id: <20040104130752.17be7460.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401040749180.11783@localhost.localdomain>
References: <Pine.LNX.4.58.0401040749180.11783@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina <tmolina@cablespeed.com> wrote:
>
> I get the following message when compiling profile suport into 
>  2.6.0-rc1-mm1:
> 
>  WARNING: /lib/modules/2.6.1-rc1-mm1/kernel/arch/i386/oprofile/oprofile.ko needs unknown symbol cpu_possible

This should fix it.

--- 25/drivers/oprofile/oprofile_stats.c~for_each_cpu-oprofile-fix	2004-01-01 11:52:30.000000000 -0800
+++ 25-akpm/drivers/oprofile/oprofile_stats.c	2004-01-01 11:52:30.000000000 -0800
@@ -8,7 +8,7 @@
  */
 
 #include <linux/oprofile.h>
-#include <linux/smp.h>
+#include <linux/cpumask.h>
 #include <linux/threads.h>
  
 #include "oprofile_stats.h"

_

