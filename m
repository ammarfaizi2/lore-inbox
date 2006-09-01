Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWIAJxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWIAJxf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 05:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWIAJxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 05:53:35 -0400
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:47377 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S1751380AbWIAJxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 05:53:35 -0400
Message-ID: <44F80314.7030200@roarinelk.homelinux.net>
Date: Fri, 01 Sep 2006 11:53:24 +0200
From: Manuel Lauss <mano@roarinelk.homelinux.net>
User-Agent: Thunderbird/1.0 Mnenhy/0.7
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc5-mm1
References: <20060901015818.42767813.akpm@osdl.org>
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need the following patch to make it build.

__NR_execve is undeclared.


--- a/arch/i386/kernel/sys_i386.c~      2006-09-01 11:48:45.000000000 +0200
+++ b/arch/i386/kernel/sys_i386.c       2006-09-01 11:48:45.000000000 +0200
@@ -22,6 +22,7 @@

 #include <asm/uaccess.h>
 #include <asm/ipc.h>
+#include <asm/unistd.h>

 /*
  * sys_pipe() is the normal C calling standard for creating
