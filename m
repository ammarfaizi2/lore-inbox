Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVGKSt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVGKSt3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 14:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVGKSsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 14:48:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:4348 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261640AbVGKSqp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 14:46:45 -0400
Subject: Re: Real-Time Preemption Patch -RT-2.6.12-final-V0.7.51-26 failed
	,to compile
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Steven Wooding <steve@wooding.uklinux.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42D2B6AD.40907@wooding.uklinux.net>
References: <42D2B6AD.40907@wooding.uklinux.net>
Content-Type: text/plain
Organization: MontaVista
Date: Mon, 11 Jul 2005 11:46:38 -0700
Message-Id: <1121107598.9477.3.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may help ..


Index: linux-2.6.12/arch/x86_64/kernel/mce.c
===================================================================
--- linux-2.6.12.orig/arch/x86_64/kernel/mce.c  2005-06-17 19:48:29.000000000 +0000
+++ linux-2.6.12/arch/x86_64/kernel/mce.c       2005-07-11 18:44:42.000000000 +0000
@@ -15,6 +15,8 @@
 #include <linux/sysdev.h>
 #include <linux/miscdevice.h>
 #include <linux/fs.h>
+#include <linux/semaphore.h>
+
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/mce.h>


On Mon, 2005-07-11 at 19:13 +0100, Steven Wooding wrote:
> Hi,
>  
> I wonder if someone can help a newbie to the Real-Time Preemption 
> Patch. After appling the lastest patch (-RT-2.6.12-final-V0.7.51-26) to the 
> 2.6.12 vanilla kernel I get the following error when compiling the 
> patched kernel:
>  
> arch/x86_64/kernel/mce.c: In function 'mce_read':
> arch/x86_64/kernel/mce.c:383: warning: type defaults to 'int' in 
> declarationd of 'DECLARE_MUTEX'
> arch/x86_64/kernel/mce.c:383: warning: parameter names (without types) 
> in function declaration
> arch/x86_64/kernel/mce.c:392:error: 'mce_read_sem' undeclared (first 
> use in this function)
>  
> Then the mce.o fails to get made and the make stops.
>  
> I've tried compiling the vanilla 2.6.12 kernel without the patch and 
> that works fine. It is strange that the error should be in 
> arch/x86_64/kernel/mce.c as this is not altered by the patch. I've also tried saying 
> no to MCE support, but got the some error.
>  
> I'm using RHEL 4 on a SMP system (gcc version 3.4.3).
>  
> Thanks,
>  
> Steve.
> 
> PS Please CC me on replies. Thanks.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

