Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264996AbUFAL0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264996AbUFAL0n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 07:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264992AbUFAL01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 07:26:27 -0400
Received: from holomorphy.com ([207.189.100.168]:38543 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264986AbUFAL0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 07:26:20 -0400
Date: Tue, 1 Jun 2004 04:26:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
Message-ID: <20040601112616.GN2093@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040601021539.413a7ad7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040601021539.413a7ad7.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 02:15:39AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc2/2.6.7-rc2-mm1/
> - NFS server udpates
> - md updates
> - big x86 dmi_scan.c cleanup
> - merged perfctr.  No documentation though :(
> - cris architecture update

Hmm. task_cpu() on UP seems to be missing a const.


-- wli

Index: linux-2.6.7-rc2-mm1/include/linux/sched.h
===================================================================
--- linux-2.6.7-rc2-mm1.orig/include/linux/sched.h	2004-06-01 03:25:54.000000000 -0700
+++ linux-2.6.7-rc2-mm1/include/linux/sched.h	2004-06-01 04:24:17.000000000 -0700
@@ -1109,7 +1109,7 @@
 
 #else
 
-static inline unsigned int task_cpu(struct task_struct *p)
+static inline unsigned int task_cpu(const struct task_struct *p)
 {
 	return 0;
 }
