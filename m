Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317392AbSHGJud>; Wed, 7 Aug 2002 05:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSHGJud>; Wed, 7 Aug 2002 05:50:33 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:36235 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317392AbSHGJuc>; Wed, 7 Aug 2002 05:50:32 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200208070953.g779raO16534@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.20-pre1 - compile errors
To: Billy.Harvey@thrillseeker.net (Billy Harvey)
Date: Wed, 7 Aug 2002 05:53:36 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel), alan@redhat.com
In-Reply-To: <1028682750.5057.4.camel@rhino> from "Billy Harvey" at Aug 06, 2002 09:12:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> apm.c: In function `apm_bios_call':
> apm.c:605: called object is not a function
> apm.c:605: warning: unused variable `cpus'

Doh, silly macro bug

--- arch/i386/kernel/apm.c~	2002-08-07 10:53:16.000000000 +0100
+++ arch/i386/kernel/apm.c	2002-08-07 10:53:16.000000000 +0100
@@ -524,7 +524,7 @@
  *	No CPU lockdown needed on a uniprocessor
  */
  
-#define apm_save_cpus	0
+#define apm_save_cpus()	0
 #define apm_restore_cpus(x)
 
 #endif
