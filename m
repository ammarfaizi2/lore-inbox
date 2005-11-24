Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030595AbVKXFDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030595AbVKXFDG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 00:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030596AbVKXFDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 00:03:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60033 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030595AbVKXFDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 00:03:05 -0500
Date: Wed, 23 Nov 2005 21:02:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc2-mm1
Message-Id: <20051123210252.05cac86c.akpm@osdl.org>
In-Reply-To: <438530F2.2020904@jp.fujitsu.com>
References: <20051123033550.00d6a6e8.akpm@osdl.org>
	<438530F2.2020904@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
>     CHK     include/linux/version.h
>     CHK     include/linux/compile.h
>     CHK     usr/initramfs_list
>     CC      drivers/base/memory.o
>  drivers/base/memory.c:28: error: static declaration of 'memory_sysdev_class' follows non-static declaration
>  include/linux/memory.h:88: error: previous declaration of 'memory_sysdev_class' was here

Thanks.

--- devel/include/linux/memory.h~memory_sysdev_class-is-static	2005-11-23 21:01:27.000000000 -0800
+++ devel-akpm/include/linux/memory.h	2005-11-23 21:01:36.000000000 -0800
@@ -85,7 +85,6 @@ struct notifier_block;
 extern int register_memory_notifier(struct notifier_block *nb);
 extern void unregister_memory_notifier(struct notifier_block *nb);
 
-extern struct sysdev_class memory_sysdev_class;
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 #define hotplug_memory_notifier(fn, pri) {			\
_

