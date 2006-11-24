Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757498AbWKXBqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757498AbWKXBqm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 20:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757550AbWKXBqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 20:46:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27145 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1755348AbWKXBqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 20:46:01 -0500
Date: Fri, 24 Nov 2006 02:46:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] make proc_pid_io_accounting() static
Message-ID: <20061124014604.GR3557@stusta.de>
References: <20061123021703.8550e37e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123021703.8550e37e.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 02:17:03AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc5-mm2:
>...
> +io-accounting-report-in-procfs.patch
>...
>  per-task IO accounting
>...

proc_pid_io_accounting() can become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm1/fs/proc/base.c.old	2006-11-24 01:23:55.000000000 +0100
+++ linux-2.6.19-rc6-mm1/fs/proc/base.c	2006-11-24 01:24:06.000000000 +0100
@@ -1805,7 +1805,7 @@
 }
 
 #ifdef CONFIG_TASK_IO_ACCOUNTING
-int proc_pid_io_accounting(struct task_struct *task, char *buffer)
+static int proc_pid_io_accounting(struct task_struct *task, char *buffer)
 {
 	return sprintf(buffer,
 			"read_bytes: %llu\n"

